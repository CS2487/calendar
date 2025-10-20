# Project Structure

## Overview
This Flutter application follows Clean Architecture principles with feature-based organization and Cubit state management.

## Directory Structure

```
dual_calendar/
│
├── lib/
│   ├── core/                          # Core application components
│   │   ├── themes/
│   │   │   └── app_theme.dart         # Light & Dark theme configurations
│   │   └── widgets/
│   │       └── bottom_navigation.dart # Main navigation widget
│   │
│   ├── features/                      # Feature modules
│   │   ├── calendar/                  # Calendar feature
│   │   │   ├── cubit/
│   │   │   │   ├── calendar_cubit.dart    # Calendar business logic
│   │   │   │   └── calendar_state.dart    # Calendar state definition
│   │   │   ├── models/
│   │   │   │   ├── calendar_event.dart    # Event model
│   │   │   │   └── calendar_type.dart     # Calendar type enum
│   │   │   ├── screens/
│   │   │   │   ├── home_screen.dart           # Main calendar screen
│   │   │   │   ├── event_details_screen.dart  # Event details view
│   │   │   │   └── edit_event_screen.dart     # Edit event screen
│   │   │   └── widgets/
│   │   │       ├── calendar_header.dart   # Calendar header widget
│   │   │       ├── event_card.dart        # Event card widget
│   │   │       └── add_event_dialog.dart  # Add event dialog
│   │   │
│   │   └── settings/                  # Settings feature
│   │       ├── cubit/
│   │       │   ├── settings_cubit.dart    # Settings business logic
│   │       │   └── settings_state.dart    # Settings state definition
│   │       └── screens/
│   │           └── settings_screen.dart   # Settings screen
│   │
│   ├── l10n/                          # Localization files
│   │   ├── app_en.arb                 # English translations
│   │   ├── app_ar.arb                 # Arabic translations
│   │   └── l10n.yaml                  # Localization config
│   │
│   └── main.dart                      # Application entry point
│
├── analysis_options.yaml              # Dart analyzer configuration
├── pubspec.yaml                       # Dependencies and assets
├── README.md                          # Project documentation
└── PROJECT_STRUCTURE.md               # This file

```

## Key Features by Module

### Calendar Feature
- **State Management**: CalendarCubit manages events, calendar type, and view mode
- **Models**: CalendarEvent (with Equatable), CalendarType enum
- **Screens**: Home, Event Details, Edit Event
- **Widgets**: Calendar Header, Event Card, Add Event Dialog

### Settings Feature
- **State Management**: SettingsCubit manages language and theme preferences
- **Persistence**: SharedPreferences for storing user preferences
- **Screens**: Settings screen with dialogs for language, theme, and calendar type selection

### Core Components
- **Themes**: Separate light and dark themes with Material 3
- **Navigation**: Bottom navigation bar for main app navigation
- **Localization**: Full English and Arabic support

## State Management Flow

```
User Action → Screen → Cubit Method → State Update → UI Rebuild
```

### Example: Adding an Event
1. User taps FAB → Opens AddEventDialog
2. User fills form → Submits
3. HomeScreen calls `calendarCubit.addEvent()`
4. CalendarCubit updates state with new event
5. BlocBuilder rebuilds UI with updated calendar

## Data Models

### CalendarEvent
- Properties: id, title, description, color, gregorianDate, hijriDate
- Uses Equatable for value equality
- Supports copyWith for immutable updates

### CalendarState
- Properties: currentCalendarType, events, isWeekView, selectedDay, focusedDay
- Immutable state with factory method for initial state

### SettingsState
- Properties: locale, themeMode, isLoading
- Persisted using SharedPreferences

## Naming Conventions

- **Files**: snake_case (e.g., `calendar_cubit.dart`)
- **Classes**: PascalCase (e.g., `CalendarCubit`)
- **Variables**: camelCase (e.g., `selectedDay`)
- **Constants**: SCREAMING_SNAKE_CASE (if any)

## Best Practices Implemented

1. **Separation of Concerns**: Features are isolated and independent
2. **Single Responsibility**: Each file has one clear purpose
3. **Immutability**: State objects are immutable
4. **Type Safety**: Full type annotations
5. **Code Reusability**: Widgets are modular and reusable
6. **Proper Error Handling**: Form validation and safe navigation
7. **Clean Code**: Consistent formatting and naming

## Dependencies Overview

| Package | Purpose |
|---------|---------|
| flutter_bloc | State management with Cubit |
| equatable | Value equality for models |
| table_calendar | Calendar widget |
| hijri | Hijri calendar calculations |
| intl | Date formatting |
| shared_preferences | Local data persistence |

## Running the Project

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run

# Run tests (if available)
flutter test

# Build for release
flutter build apk  # Android
flutter build ios  # iOS
```
