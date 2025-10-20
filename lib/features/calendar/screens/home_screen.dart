import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../cubit/calendar_cubit.dart';
import '../cubit/calendar_state.dart';
import '../models/calendar_type.dart';
import '../widgets/add_event_dialog.dart';
import '../widgets/calendar_header.dart';
import '../widgets/event_card.dart';
import 'event_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  void _showEventsBottomSheet(BuildContext context, DateTime selectedDay) {
    final calendarCubit = context.read<CalendarCubit>();
    final events = calendarCubit.getEventsForDay(selectedDay);

    if (events.isEmpty) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.5,
            minChildSize: 0.3,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return EventCard(
                    event: event,
                    onDelete: () {
                      calendarCubit.removeEvent(event);
                      Navigator.pop(context);
                    },
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetailsScreen(
                          event: event,
                          selectedDay: selectedDay,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    final calendarCubit = context.read<CalendarCubit>();

    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, calendarState) {
        final isHijri = calendarState.currentCalendarType == CalendarType.hijri;

        return Scaffold(
          appBar: CalendarHeader(focusedDay: _focusedDay),
          body: Column(
            children: [
              TableCalendar(
                locale: l10n.localeName,
                firstDay: DateTime.utc(2000, 1, 1),
                lastDay: DateTime.utc(2050, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: calendarState.isWeekView
                    ? CalendarFormat.week
                    : CalendarFormat.month,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                  _showEventsBottomSheet(context, selectedDay);
                },
                eventLoader: (day) => calendarCubit.getEventsForDay(day),
                calendarStyle: const CalendarStyle(
                  markersMaxCount: 1,
                  markerSize: 8,
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextFormatter: (date, locale) {
                    if (isHijri) {
                      final hijri = HijriCalendar.fromDate(date);
                      return '${hijri.getLongMonthName()} ${hijri.hYear}';
                    }
                    return DateFormat.yMMMM(locale).format(date);
                  },
                ),
                onHeaderTapped: (day) async {
                  final newDate = await showDatePicker(
                    context: context,
                    initialDate: _focusedDay,
                    firstDate: DateTime.utc(1999, 1, 1),
                    lastDate: DateTime.utc(2030, 12, 31),
                  );
                  if (newDate != null) {
                    setState(() {
                      _focusedDay = newDate;
                      _selectedDay = newDate;
                    });
                  }
                },
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    final hijri = HijriCalendar.fromDate(day);

                    return Container(
                      margin: const EdgeInsets.all(1),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${day.day}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '(${hijri.hDay}/${hijri.hMonth})',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor:
                isDarkMode ? const Color(0xFF393939) : Colors.white,
            onPressed: () async {
              if (_selectedDay != null) {
                final event = await showDialog(
                  context: context,
                  builder: (context) => AddEventDialog(
                    selectedDay: _selectedDay!,
                  ),
                );

                if (event != null) {
                  calendarCubit.addEvent(event);
                }
              }
            },
            shape: const CircleBorder(),
            child: Icon(
              Icons.add,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        );
      },
    );
  }
}
