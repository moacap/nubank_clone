

# Nubank Clone Flutter

Este projeto é um clone simplificado do NuBank, utilizando Flutter, arquitetura Clean Code e modularização por features. O app implementa:
- Clean Architecture (Repository, UseCase, DataSource/DAO, Entity)
- Modularização por features (feature-first)
- Gerenciamento de estado com BLoC
- Persistência local com SQLite (Drift)
- Design System centralizado (cores, tipografia, espaçamento, radius, tema)
- Telas: Home, Login, Perfil, Transações


## Estrutura
- `features/`: Cada feature possui suas camadas (data, domain, presentation)
- `core/design_system/`: Tokens visuais centralizados (AppColors, AppTypography, AppSpacing, AppRadius, AppTheme)
- `ui/`: Telas principais e navegação
- `test/`: Testes unitários e de widget

## Principais dependências
- flutter_bloc
- drift (SQLite)
- path

## Como rodar
```sh
cd nubank_clone
flutter pub get
flutter run
```

## Design System
O app utiliza um Design System próprio, com tokens de cor, tipografia, espaçamento e radius centralizados em `core/design_system/`. Todas as telas principais utilizam esses tokens para garantir consistência visual.

## Observações
- A tela de transações (`TransactionView`) foi convertida para StatefulWidget para garantir o ciclo de vida correto dos controllers.
- O projeto segue Clean Architecture e está pronto para expansão modular.
