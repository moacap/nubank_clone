


# Nubank Clone Flutter
## Resumo das demandas atendidas

Este projeto foi desenvolvido conforme as seguintes solicitações:

1. **Criação do app estilo NuBank**
   - Estrutura modularizada por features (ex: customers, transactions).
   - Clean Architecture: separação em DataSource, Repository, UseCase, BLoC, Presentation.
   - Uso de SQLite (Drift) para persistência local.

2. **Design System**
   - Implementação de temas, cores, tipografia e espaçamentos centralizados.

3. **Testes automatizados**
   - Testes de UI e de lógica usando `flutter_test`, `bloc_test` e `mocktail`.

4. **Integração com API**
   - Criação de fluxo completo para consumir dados reais de uma API externa.
   - Ajuste do endpoint para `https://demo.salesfarma.com.br/sincronia/api/profissional/160115/`.

5. **Migração e refatoração de features**
   - Migração da feature `example` para `customers`, com renomeação e limpeza de arquivos.
   - Integração da tela de clientes ao dashboard principal.

6. **Correção de injeção de dependências**
   - Ajuste da cadeia de dependências do BLoC na `CustomersPage`.

7. **Exibição de dados reais da API**
   - Mapeamento dos campos do JSON da API para a entidade `Customer`.
   - Exibição dos campos reais (nome, email, celular, especialidade) na tela de clientes.

8. **Recomendações de ferramentas**
   - Sugestão de extensões do VS Code para visualizar JSON (JSON Viewer, JSON Crack).

Caso precise de detalhes de implementação ou queira expandir alguma funcionalidade, consulte a documentação ou abra uma issue.

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
