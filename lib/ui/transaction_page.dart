import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/transactions/presentation/bloc/transaction_bloc.dart';
import '../features/transactions/data/datasources/transaction_datasource_drift.dart';
import '../features/transactions/data/repositories/transaction_repository_impl.dart';
import '../features/transactions/domain/usecases/add_transaction_usecase.dart';
import '../features/transactions/domain/usecases/fetch_transactions_usecase.dart';
import '../dao/transaction_dao.dart';
import '../core/design_system/app_colors.dart';
import '../core/design_system/app_typography.dart';
import '../core/design_system/app_spacing.dart';
import '../core/design_system/app_radius.dart';
import '../core/design_system/app_theme.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = AppDatabase();
    final dataSource = TransactionDataSourceDrift(db);
    final repository = TransactionRepositoryImpl(dataSource);
    final addUseCase = AddTransactionUseCase(repository);
    final fetchUseCase = FetchTransactionsUseCase(repository);
    return BlocProvider(
      create: (_) => TransactionBloc(
        addTransactionUseCase: addUseCase,
        fetchTransactionsUseCase: fetchUseCase,
      )..add(LoadTransactions()),
      child: const TransactionView(),
    );
  }
}

class TransactionView extends StatelessWidget {
  const TransactionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TransactionBloc>(context);
    final descController = TextEditingController();
    final valueController = TextEditingController();

    return Theme(
      data: AppTheme.light,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Transações',
            style: AppTypography.title.copyWith(color: Colors.white),
          ),
          backgroundColor: AppColors.primary,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: descController,
                      decoration: const InputDecoration(labelText: 'Descrição'),
                      style: AppTypography.body,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: valueController,
                      decoration: const InputDecoration(labelText: 'Valor'),
                      keyboardType: TextInputType.number,
                      style: AppTypography.body,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                    ),
                    onPressed: () {
                      final desc = descController.text;
                      final value =
                          double.tryParse(valueController.text) ?? 0.0;
                      if (desc.isNotEmpty && value > 0) {
                        bloc.add(
                          AddTransaction(
                            description: desc,
                            value: value,
                            date: DateTime.now().toIso8601String(),
                          ),
                        );
                        descController.clear();
                        valueController.clear();
                      }
                    },
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<TransactionBloc, TransactionState>(
                builder: (context, state) {
                  if (state is TransactionLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TransactionLoaded) {
                    if (state.transactions.isEmpty) {
                      return Center(
                        child: Text(
                          'Nenhuma transação.',
                          style: AppTypography.body,
                        ),
                      );
                    }
                    return ListView.separated(
                      itemCount: state.transactions.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final t = state.transactions[index];
                        return Card(
                          color: AppColors.card,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.md),
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: AppSpacing.xs,
                            horizontal: 0,
                          ),
                          child: ListTile(
                            title: Text(
                              t.description,
                              style: AppTypography.subtitle,
                            ),
                            subtitle: Text(
                              t.date,
                              style: AppTypography.caption,
                            ),
                            trailing: Text(
                              'R\$ ${t.value.toStringAsFixed(2)}',
                              style: AppTypography.body.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is TransactionError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: AppTypography.body.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
