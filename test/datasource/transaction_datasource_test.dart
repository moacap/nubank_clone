import 'package:nubank_clone/features/transactions/data/models/transaction_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nubank_clone/features/transactions/data/datasources/transaction_datasource_drift.dart';

// import 'package:nubank_clone/features/transactions/domain/entities/transaction_entity.dart';
import 'package:nubank_clone/dao/transaction_dao.dart';
// import 'package:drift/drift.dart';

class MockAppDatabase extends Mock implements AppDatabase {
  @override
  Future<int> insertTransaction(dynamic companion) async => 1;
  @override
  Future<List<Transaction>> getAllTransactions() async => <Transaction>[];
}

void main() {
  late MockAppDatabase mockDb;
  late TransactionDataSourceDrift dataSource;

  setUp(() {
    mockDb = MockAppDatabase();
    dataSource = TransactionDataSourceDrift(mockDb);
  });

  group('TransactionDataSourceDrift', () {
    test('saveTransaction deve delegar para o AppDatabase', () async {
      when<dynamic>(
        () => mockDb.insertTransaction(any()),
      ).thenAnswer((_) async => 1);
      final result = await dataSource.saveTransaction(
        description: 'desc',
        value: 10.0,
        date: '2025-07-14T12:00:00',
      );
      expect(result, 1);
      verify(() => mockDb.insertTransaction(any())).called(1);
    });

    test('getAllTransactions deve delegar para o AppDatabase', () async {
      when<dynamic>(
        () => mockDb.getAllTransactions(),
      ).thenAnswer((_) async => <Transaction>[]);
      final result = await dataSource.getAllTransactions();
      expect(result, isA<List<TransactionModel>>());
      verify(() => mockDb.getAllTransactions()).called(1);
    });
  });
}
