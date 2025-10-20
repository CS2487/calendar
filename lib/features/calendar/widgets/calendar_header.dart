import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../cubit/calendar_cubit.dart';
import '../cubit/calendar_state.dart';
import '../models/calendar_type.dart';

class CalendarHeader extends StatelessWidget implements PreferredSizeWidget {
  final DateTime focusedDay;

  const CalendarHeader({
    Key? key,
    required this.focusedDay,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, calendarState) {
        final isHijri = calendarState.currentCalendarType == CalendarType.hijri;
        final calendarCubit = context.read<CalendarCubit>();
        final String headerTitle =
            isHijri ? l10n.hijriCalendar : l10n.gregorianCalendar;

        return AppBar(
          title: Text(
            headerTitle,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: calendarState.isWeekView
                  ? const Icon(Icons.view_module)
                  : const Icon(Icons.view_week),
              onPressed: () => calendarCubit.toggleCalendarView(),
              tooltip: calendarState.isWeekView
                  ? l10n.switchToMonthView
                  : l10n.switchToWeekView,
            ),
          ],
        );
      },
    );
  }
}
