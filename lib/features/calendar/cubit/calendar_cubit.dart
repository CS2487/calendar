import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/calendar_event.dart';
import '../models/calendar_type.dart';
import 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarState.initial());

  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  void toggleCalendarType() {
    final newType = state.currentCalendarType == CalendarType.gregorian
        ? CalendarType.hijri
        : CalendarType.gregorian;
    emit(state.copyWith(currentCalendarType: newType));
  }

  void toggleCalendarView() {
    emit(state.copyWith(isWeekView: !state.isWeekView));
  }

  void setSelectedDay(DateTime day) {
    emit(state.copyWith(selectedDay: day));
  }

  void setFocusedDay(DateTime day) {
    emit(state.copyWith(focusedDay: day));
  }

  List<CalendarEvent> getEventsForDay(DateTime day) {
    final normalizedDay = _normalizeDate(day);
    return state.events[normalizedDay] ?? [];
  }

  void addEvent(CalendarEvent event) {
    final normalizedDay = _normalizeDate(event.gregorianDate);
    final newEvents = Map<DateTime, List<CalendarEvent>>.from(state.events);

    if (newEvents.containsKey(normalizedDay)) {
      newEvents[normalizedDay]!.add(event);
    } else {
      newEvents[normalizedDay] = [event];
    }
    emit(state.copyWith(events: newEvents));
  }

  void removeEvent(CalendarEvent event) {
    final normalizedDay = _normalizeDate(event.gregorianDate);
    final newEvents = Map<DateTime, List<CalendarEvent>>.from(state.events);

    if (newEvents[normalizedDay] != null) {
      newEvents[normalizedDay]!.removeWhere((e) => e.id == event.id);

      if (newEvents[normalizedDay]!.isEmpty) {
        newEvents.remove(normalizedDay);
      }
      emit(state.copyWith(events: newEvents));
    }
  }

  void updateEvent(CalendarEvent oldEvent, CalendarEvent newEvent) {
    removeEvent(oldEvent);
    addEvent(newEvent);
  }
}
