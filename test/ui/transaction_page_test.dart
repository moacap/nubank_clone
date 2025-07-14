import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nubank_clone/features/transactions/presentation/pages/transaction_page.dart';
import 'package:nubank_clone/features/transactions/presentation/bloc/transaction_bloc.dart';
import 'package:nubank_clone/features/transactions/domain/usecases/add_transaction_usecase.dart';
import 'package:nubank_clone/features/transactions/domain/usecases/fetch_transactions_usecase.dart';
import 'package:nubank_clone/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:nubank_clone/features/transactions/domain/entities/transaction_entity.dart';
import 'package:nubank_clone/dao/transaction_dao.dart';

class MockAddTransactionUseCase extends AddTransactionUseCase {
  MockAddTransactionUseCase() : super(FakeRepository());
  @override
  Future<int> call({
    required String description,
    required double value,
    required String date,
  }) async => 1;
}

class MockFetchTransactionsUseCase extends FetchTransactionsUseCase {
  MockFetchTransactionsUseCase() : super(FakeRepository());
  @override
  Future<List<TransactionEntity>> call() async => [];
}

class FakeRepository implements TransactionRepository {
  @override
  Future<int> addTransaction({
    required String description,
    required double value,
    required String date,
  }) async => 1;
  @override
  Future<List<TransactionEntity>> fetchTransactions() async => [];
}

void main() {
  testWidgets('Deve exibir campos e botão de adicionar', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => TransactionBloc(
            addTransactionUseCase: MockAddTransactionUseCase(),
            fetchTransactionsUseCase: MockFetchTransactionsUseCase(),
          ),
          child: const TransactionPage(),
        ),
      ),
    );
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.text('Transações'), findsOneWidget);
  });
}
