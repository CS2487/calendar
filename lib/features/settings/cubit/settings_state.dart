import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SettingsState extends Equatable {
  final Locale locale;
  final ThemeMode themeMode;
  final bool isLoading;

  const SettingsState({
    required this.locale,
    required this.themeMode,
    this.isLoading = false,
  });

  SettingsState copyWith({
    Locale? locale,
    ThemeMode? themeMode,
    bool? isLoading,
  }) {
    return SettingsState(
      locale: locale ?? this.locale,
      themeMode: themeMode ?? this.themeMode,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  factory SettingsState.initial() => const SettingsState(
        locale: Locale('en'),
        themeMode: ThemeMode.system,
        isLoading: true,
      );

  @override
  List<Object?> get props => [locale, themeMode, isLoading];
}
