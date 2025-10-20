import 'package:equatable/equatable.dart';
import '../models/calendar_event.dart';
import '../models/calendar_type.dart';

class CalendarState extends Equatable {
  final CalendarType currentCalendarType;
  final Map<DateTime, List<CalendarEvent>> events;
  final bool isWeekView;
  final DateTime? selectedDay;
  final DateTime focusedDay;

  const CalendarState({
    required this.currentCalendarType,
    required this.events,
    required this.isWeekView,
    this.selectedDay,
    required this.focusedDay,
  });

  CalendarState copyWith({
    CalendarType? currentCalendarType,
    Map<DateTime, List<CalendarEvent>>? events,
    bool? isWeekView,
    DateTime? selectedDay,
    DateTime? focusedDay,
  }) {
    return CalendarState(
      currentCalendarType: currentCalendarType ?? this.currentCalendarType,
      events: events ?? this.events,
      isWeekView: isWeekView ?? this.isWeekView,
      selectedDay: selectedDay ?? this.selectedDay,
      focusedDay: focusedDay ?? this.focusedDay,
    );
  }

  factory CalendarState.initial() => CalendarState(
        currentCalendarType: CalendarType.gregorian,
        events: {},
        isWeekView: false,
        selectedDay: DateTime.now(),
        focusedDay: DateTime.now(),
      );

  @override
  List<Object?> get props =>
      [currentCalendarType, events, isWeekView, selectedDay, focusedDay];
}
