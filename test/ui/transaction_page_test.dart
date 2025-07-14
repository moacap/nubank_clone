import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nubank_clone/ui/transaction_page.dart';
import 'package:nubank_clone/bloc/transaction_bloc.dart';
import 'package:nubank_clone/repository/transaction_usecases.dart';
import 'package:nubank_clone/repository/transaction_repository.dart';
import 'package:nubank_clone/datasource/transaction_datasource.dart';
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
  Future<List<Transaction>> call() async => [];
}

class FakeRepository implements TransactionRepository {
  @override
  Future<int> addTransaction({
    required String description,
    required double value,
    required String date,
  }) async => 1;
  @override
  Future<List<Transaction>> fetchTransactions() async => [];
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
          child: const TransactionView(),
        ),
      ),
    );
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.text('Transações'), findsOneWidget);
  });
}
