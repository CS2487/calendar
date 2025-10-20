# Dual Calendar App

A beautiful Flutter application that supports both Gregorian and Hijri calendars with comprehensive event management capabilities.

## Features

- **Dual Calendar System**: Switch between Gregorian and Hijri calendars
- **Event Management**: Create, edit, and delete events with custom colors
- **Multi-language Support**: Full support for English and Arabic
- **Theme Support**: Light, Dark, and System theme modes
- **Calendar Views**: Toggle between month and week views
- **Clean Architecture**: Organized with feature-based structure
- **State Management**: Built with Flutter Bloc (Cubit)

## Architecture

The project follows Clean Architecture principles with a feature-based structure:

```
lib/
├── core/
│   ├── themes/
│   │   └── app_theme.dart
│   └── widgets/
│       └── bottom_navigation.dart
├── features/
│   ├── calendar/
│   │   ├── cubit/
│   │   │   ├── calendar_cubit.dart
│   │   │   └── calendar_state.dart
│   │   ├── models/
│   │   │   ├── calendar_event.dart
│   │   │   └── calendar_type.dart
│   │   ├── screens/
│   │   │   ├── edit_event_screen.dart
│   │   │   ├── event_details_screen.dart
│   │   │   └── home_screen.dart
│   │   └── widgets/
│   │       ├── add_event_dialog.dart
│   │       ├── calendar_header.dart
│   │       └── event_card.dart
│   └── settings/
│       ├── cubit/
│       │   ├── settings_cubit.dart
│       │   └── settings_state.dart
│       └── screens/
│           └── settings_screen.dart
├── l10n/
│   ├── app_ar.arb
│   ├── app_en.arb
│   └── l10n.yaml
└── main.dart
```

## Dependencies

- **flutter_bloc**: State management
- **equatable**: Value equality
- **table_calendar**: Calendar widget
- **hijri**: Hijri calendar calculations
- **intl**: Internationalization
- **shared_preferences**: Local storage

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Usage

### Adding Events

1. Navigate to the home screen
2. Tap the floating action button (+)
3. Fill in event details (title, description)
4. Choose a color for the event
5. Tap "Add Event"

### Editing Events

1. Tap on an event in the calendar
2. View event details
3. Tap the edit icon
4. Update event information
5. Tap save

### Changing Settings

1. Navigate to Settings screen
2. Choose your preferred:
   - Language (English/Arabic)
   - Theme (Light/Dark/System)
   - Calendar Type (Gregorian/Hijri)

## State Management

The app uses **Flutter Bloc (Cubit)** for state management:

- **CalendarCubit**: Manages calendar state, events, and view mode
- **SettingsCubit**: Manages app settings (language, theme, etc.)

## Localization

The app supports:
- English (en)
- Arabic (ar)

Localization files are located in `lib/l10n/`.

## Developer

**فارع الضلاع**
- Email: farea2487@gmail.com
- Phone: 717-281-413

## Version

1.0.0

## License

This project is licensed under the MIT License.
