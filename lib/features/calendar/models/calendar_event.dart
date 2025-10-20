import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';

class CalendarEvent extends Equatable {
  final String id;
  final String title;
  final String description;
  final Color color;
  final DateTime gregorianDate;
  final HijriCalendar hijriDate;

  CalendarEvent({
    String? id,
    required this.title,
    required this.description,
    required this.gregorianDate,
    required this.color,
  })  : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        hijriDate = HijriCalendar.fromDate(gregorianDate);

  CalendarEvent copyWith({
    String? id,
    String? title,
    String? description,
    Color? color,
    DateTime? gregorianDate,
  }) {
    return CalendarEvent(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      color: color ?? this.color,
      gregorianDate: gregorianDate ?? this.gregorianDate,
    );
  }

  @override
  List<Object?> get props => [id, title, description, color, gregorianDate];
}
