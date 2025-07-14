# Nubank Clone Flutter

This project is a simplified clone of NuBank, built with Flutter, Clean Code architecture, and feature-first modularization. The app implements:
- Clean Architecture (Repository, UseCase, DataSource/DAO, Entity)
- Feature-first modularization
- State management with BLoC
- Local persistence with SQLite (Drift)
- Centralized Design System (colors, typography, spacing, radius, theme)
- Screens: Home, Login, Profile, Transactions

## Structure
- `features/`: Each feature has its own layers (data, domain, presentation)
- `core/design_system/`: Centralized visual tokens (AppColors, AppTypography, AppSpacing, AppRadius, AppTheme)
- `ui/`: Main screens and navigation
- `test/`: Unit and widget tests

## Main dependencies
- flutter_bloc
- drift (SQLite)
- path

## How to run
```sh
cd nubank_clone
flutter pub get
flutter run
```

## Design System
The app uses a custom Design System, with color, typography, spacing, and radius tokens centralized in `core/design_system/`. All main screens use these tokens for visual consistency.

## Notes
- The transactions screen (`TransactionView`) was converted to a StatefulWidget to ensure the correct lifecycle of controllers.
- The project follows Clean Architecture and is ready for modular expansion.
