import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nubank_clone/features/transactions/domain/usecases/add_transaction_usecase.dart';
import 'package:nubank_clone/features/transactions/domain/usecases/fetch_transactions_usecase.dart';
import 'package:nubank_clone/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:nubank_clone/features/transactions/domain/entities/transaction_entity.dart';

class MockTransactionRepository extends Mock implements TransactionRepository {}

void main() {
  late MockTransactionRepository mockRepository;
  late AddTransactionUseCase addUseCase;
  late FetchTransactionsUseCase fetchUseCase;

  setUp(() {
    mockRepository = MockTransactionRepository();
    addUseCase = AddTransactionUseCase(mockRepository);
    fetchUseCase = FetchTransactionsUseCase(mockRepository);
  });

  group('AddTransactionUseCase', () {
    test('deve delegar para o repository', () async {
      when(
        () => mockRepository.addTransaction(
          description: any(named: 'description'),
          value: any(named: 'value'),
          date: any(named: 'date'),
        ),
      ).thenAnswer((_) async => 1);
      final result = await addUseCase(
        description: 'desc',
        value: 10.0,
        date: '2025-07-14T12:00:00',
      );
      expect(result, 1);
      verify(
        () => mockRepository.addTransaction(
          description: 'desc',
          value: 10.0,
          date: '2025-07-14T12:00:00',
        ),
      ).called(1);
    });
  });

  group('FetchTransactionsUseCase', () {
    test('deve delegar para o repository', () async {
      when(
        () => mockRepository.fetchTransactions(),
      ).thenAnswer((_) async => <TransactionEntity>[]);
      final result = await fetchUseCase();
      expect(result, isA<List<TransactionEntity>>());
      verify(() => mockRepository.fetchTransactions()).called(1);
    });
  });
}
