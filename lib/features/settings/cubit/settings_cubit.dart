import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  late SharedPreferences _prefs;

  SettingsCubit() : super(SettingsState.initial()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    _prefs = await SharedPreferences.getInstance();
    final String languageCode = _prefs.getString('language') ?? 'en';
    final int themeModeIndex = _prefs.getInt('theme_mode') ?? 0;

    emit(state.copyWith(
      locale: Locale(languageCode),
      themeMode: ThemeMode.values[themeModeIndex],
      isLoading: false,
    ));
  }

  Future<void> setLocale(Locale locale) async {
    await _prefs.setString('language', locale.languageCode);
    emit(state.copyWith(locale: locale));
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _prefs.setInt('theme_mode', mode.index);
    emit(state.copyWith(themeMode: mode));
  }
}
