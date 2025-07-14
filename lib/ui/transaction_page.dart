import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/transaction_bloc.dart';
import '../dao/transaction_dao.dart';
import '../datasource/transaction_datasource.dart';
import '../repository/transaction_repository.dart';
import '../repository/transaction_usecases.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = AppDatabase();
    final repository = TransactionRepositoryDrift(
      TransactionDataSourceDrift(db),
    );
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

    return Scaffold(
      appBar: AppBar(title: const Text('Transações')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: descController,
                    decoration: const InputDecoration(labelText: 'Descrição'),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: valueController,
                    decoration: const InputDecoration(labelText: 'Valor'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    final desc = descController.text;
                    final value = double.tryParse(valueController.text) ?? 0.0;
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
                    return const Center(child: Text('Nenhuma transação.'));
                  }
                  return ListView.builder(
                    itemCount: state.transactions.length,
                    itemBuilder: (context, index) {
                      final t = state.transactions[index];
                      return ListTile(
                        title: Text(t.description),
                        subtitle: Text(t.date),
                        trailing: Text('R\$ ${t.value.toStringAsFixed(2)}'),
                      );
                    },
                  );
                } else if (state is TransactionError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
