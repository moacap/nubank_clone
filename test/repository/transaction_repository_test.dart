import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nubank_clone/features/transactions/data/repositories/transaction_repository_impl.dart';
import 'package:nubank_clone/features/transactions/data/datasources/transaction_datasource.dart';
import 'package:nubank_clone/dao/transaction_dao.dart';
import 'package:nubank_clone/features/transactions/data/models/transaction_model.dart';
import 'package:nubank_clone/features/transactions/domain/entities/transaction_entity.dart';

class MockTransactionDataSource extends Mock implements TransactionDataSource {}

void main() {
  late MockTransactionDataSource mockDataSource;
  late TransactionRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockTransactionDataSource();
    repository = TransactionRepositoryImpl(mockDataSource);
  });

  group('TransactionRepositoryDrift', () {
    test('addTransaction deve delegar para o datasource', () async {
      when(
        () => mockDataSource.saveTransaction(
          description: any(named: 'description'),
          value: any(named: 'value'),
          date: any(named: 'date'),
        ),
      ).thenAnswer((_) async => 1);

      final result = await repository.addTransaction(
        description: 'desc',
        value: 10.0,
        date: '2025-07-14T12:00:00',
      );
      expect(result, 1);
      verify(
        () => mockDataSource.saveTransaction(
          description: 'desc',
          value: 10.0,
          date: '2025-07-14T12:00:00',
        ),
      ).called(1);
    });

    test('fetchTransactions deve delegar para o datasource', () async {
      when(
        () => mockDataSource.getAllTransactions(),
      ).thenAnswer((_) async => <TransactionModel>[]);
      final result = await repository.fetchTransactions();
      expect(result, isA<List<TransactionEntity>>());
      verify(() => mockDataSource.getAllTransactions()).called(1);
    });
  });
}
