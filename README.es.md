# Nubank Clone Flutter

Este proyecto es un clon simplificado de NuBank, utilizando Flutter, arquitectura Clean Code y modularización por funcionalidades. La app implementa:
- Clean Architecture (Repository, UseCase, DataSource/DAO, Entity)
- Modularización por funcionalidades (feature-first)
- Gestión de estado con BLoC
- Persistencia local con SQLite (Drift)
- Design System centralizado (colores, tipografía, espaciado, radio, tema)
- Pantallas: Home, Login, Perfil, Transacciones

## Estructura
- `features/`: Cada funcionalidad tiene sus capas (data, domain, presentation)
- `core/design_system/`: Tokens visuales centralizados (AppColors, AppTypography, AppSpacing, AppRadius, AppTheme)
- `ui/`: Pantallas principales y navegación
- `test/`: Pruebas unitarias y de widget

## Principales dependencias
- flutter_bloc
- drift (SQLite)
- path

## Cómo ejecutar
```sh
cd nubank_clone
flutter pub get
flutter run
```

## Design System
La app utiliza un Design System propio, con tokens de color, tipografía, espaciado y radio centralizados en `core/design_system/`. Todas las pantallas principales utilizan estos tokens para garantizar consistencia visual.

## Observaciones
- La pantalla de transacciones (`TransactionView`) fue convertida a StatefulWidget para garantizar el ciclo de vida correcto de los controllers.
- El proyecto sigue Clean Architecture y está listo para expansión modular.
