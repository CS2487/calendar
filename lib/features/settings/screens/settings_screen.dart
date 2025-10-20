import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../calendar/cubit/calendar_cubit.dart';
import '../../calendar/cubit/calendar_state.dart';
import '../../calendar/models/calendar_type.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  void _showThemeDialog(
    BuildContext context,
    SettingsCubit cubit,
    SettingsState state,
    AppLocalizations l10n,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Center(child: Text(l10n.theme)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var mode in [
              ThemeMode.light,
              ThemeMode.dark,
              ThemeMode.system
            ])
              RadioListTile<ThemeMode>(
                title: Text(
                  mode == ThemeMode.light
                      ? l10n.lightMode
                      : mode == ThemeMode.dark
                          ? l10n.darkMode
                          : l10n.system,
                ),
                value: mode,
                groupValue: state.themeMode,
                onChanged: (m) {
                  if (m != null) cubit.setThemeMode(m);
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(
    BuildContext context,
    SettingsCubit cubit,
    SettingsState state,
    AppLocalizations l10n,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Center(child: Text(l10n.language)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: Text(l10n.english),
              value: 'en',
              groupValue: state.locale.languageCode,
              onChanged: (value) {
                if (value != null) cubit.setLocale(Locale(value));
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: Text(l10n.arabic),
              value: 'ar',
              groupValue: state.locale.languageCode,
              onChanged: (value) {
                if (value != null) cubit.setLocale(Locale(value));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCalendarDialog(
    BuildContext context,
    CalendarCubit cubit,
    CalendarState state,
    AppLocalizations l10n,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Center(child: Text(l10n.toggleCalendar)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<CalendarType>(
              title: Text(l10n.gregorianCalendar),
              value: CalendarType.gregorian,
              groupValue: state.currentCalendarType,
              onChanged: (value) {
                if (state.currentCalendarType != CalendarType.gregorian) {
                  cubit.toggleCalendarType();
                }
                Navigator.pop(context);
              },
            ),
            RadioListTile<CalendarType>(
              title: Text(l10n.hijriCalendar),
              value: CalendarType.hijri,
              groupValue: state.currentCalendarType,
              onChanged: (value) {
                if (state.currentCalendarType != CalendarType.hijri) {
                  cubit.toggleCalendarType();
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Center(child: Text(l10n.aboutApp)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.aboutAppDescription,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeveloperInfoDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Center(child: Text(l10n.developerInfo)),
        content: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.code, size: 50),
              const SizedBox(height: 8),
              Text(
                l10n.developerInfo,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Divider(),
              const SizedBox(height: 8),
              Text(
                l10n.contactInfo,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('فارع الضلاع'),
              const Text('farea2487@gmail.com'),
              const Text('717-281-413'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAboutTile(BuildContext context, AppLocalizations l10n) => Card(
        child: ListTile(
          leading: const Icon(Icons.info),
          title: Text(l10n.aboutApp),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () => _showAboutDialog(context, l10n),
        ),
      );

  Widget _buildDeveloperInfo(BuildContext context, AppLocalizations l10n) =>
      Card(
        child: ListTile(
          leading: const Icon(Icons.person),
          title: Text(l10n.developerInfo),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () => _showDeveloperInfoDialog(context, l10n),
        ),
      );

  Widget _buildAppInfo(BuildContext context, AppLocalizations l10n) => Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 32, bottom: 16),
          child: Column(
            children: [
              const Icon(Icons.calendar_month, size: 48),
              Text(
                l10n.appTitle,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(l10n.version),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final settingsCubit = context.read<SettingsCubit>();
    final calendarCubit = context.read<CalendarCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, settingsState) {
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.language),
                  title: Text(l10n.language),
                  subtitle: Text(settingsState.locale.languageCode == 'ar'
                      ? l10n.arabic
                      : l10n.english),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => _showLanguageDialog(
                      context, settingsCubit, settingsState, l10n),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, settingsState) {
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.brightness_6),
                  title: Text(l10n.theme),
                  subtitle: Text(
                    settingsState.themeMode == ThemeMode.light
                        ? l10n.lightMode
                        : settingsState.themeMode == ThemeMode.dark
                            ? l10n.darkMode
                            : l10n.system,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => _showThemeDialog(
                      context, settingsCubit, settingsState, l10n),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          BlocBuilder<CalendarCubit, CalendarState>(
            builder: (context, calendarState) {
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.calendar_month),
                  title: Text(l10n.toggleCalendar),
                  subtitle: Text(
                    calendarState.currentCalendarType == CalendarType.gregorian
                        ? l10n.gregorianCalendar
                        : l10n.hijriCalendar,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => _showCalendarDialog(
                      context, calendarCubit, calendarState, l10n),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          _buildAboutTile(context, l10n),
          const SizedBox(height: 8),
          _buildDeveloperInfo(context, l10n),
          _buildAppInfo(context, l10n),
        ],
      ),
    );
  }
}
