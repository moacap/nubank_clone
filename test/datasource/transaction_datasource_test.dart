import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nubank_clone/datasource/transaction_datasource.dart';
import 'package:nubank_clone/dao/transaction_dao.dart';

import 'package:nubank_clone/dao/transactions_table.dart';
import 'package:drift/drift.dart';

class MockAppDatabase extends Mock implements AppDatabase {}

class MockTransaction extends Mock implements Transaction {}

class FakeTransactionsCompanion extends Fake implements TransactionsCompanion {}

void main() {
  late MockAppDatabase mockDb;
  late TransactionDataSourceDrift dataSource;

  setUpAll(() {
    registerFallbackValue(FakeTransactionsCompanion());
  });
  setUp(() {
    mockDb = MockAppDatabase();
    dataSource = TransactionDataSourceDrift(mockDb);
  });

  group('TransactionDataSourceDrift', () {
    test('saveTransaction deve delegar para o AppDatabase', () async {
      when(() => mockDb.insertTransaction(any())).thenAnswer((_) async => 1);
      final result = await dataSource.saveTransaction(
        description: 'desc',
        value: 10.0,
        date: '2025-07-14T12:00:00',
      );
      expect(result, 1);
      verify(() => mockDb.insertTransaction(any())).called(1);
    });

    test('getAllTransactions deve delegar para o AppDatabase', () async {
      when(
        () => mockDb.getAllTransactions(),
      ).thenAnswer((_) async => <Transaction>[]);
      final result = await dataSource.getAllTransactions();
      expect(result, isA<List<Transaction>>());
      verify(() => mockDb.getAllTransactions()).called(1);
    });
  });
}
