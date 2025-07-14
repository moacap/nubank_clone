import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:nubank_clone/bloc/transaction_bloc.dart';
import 'package:nubank_clone/repository/transaction_usecases.dart';
import 'package:mocktail/mocktail.dart';

class MockAddTransactionUseCase extends Mock implements AddTransactionUseCase {}

class MockFetchTransactionsUseCase extends Mock
    implements FetchTransactionsUseCase {}

void main() {
  late MockAddTransactionUseCase mockAddUseCase;
  late MockFetchTransactionsUseCase mockFetchUseCase;
  late TransactionBloc bloc;

  setUp(() {
    mockAddUseCase = MockAddTransactionUseCase();
    mockFetchUseCase = MockFetchTransactionsUseCase();
    bloc = TransactionBloc(
      addTransactionUseCase: mockAddUseCase,
      fetchTransactionsUseCase: mockFetchUseCase,
    );
  });

  group('TransactionBloc', () {
    blocTest<TransactionBloc, TransactionState>(
      'emits [TransactionLoading, TransactionLoaded] ao adicionar transação com sucesso',
      build: () {
        when(
          () => mockAddUseCase(
            description: any(named: 'description'),
            value: any(named: 'value'),
            date: any(named: 'date'),
          ),
        ).thenAnswer((_) async => 1);
        when(() => mockFetchUseCase()).thenAnswer((_) async => []);
        return bloc;
      },
      act: (bloc) => bloc.add(
        AddTransaction(
          description: 'Teste',
          value: 10.0,
          date: '2025-07-14T12:00:00',
        ),
      ),
      expect: () => [isA<TransactionLoading>(), isA<TransactionLoaded>()],
    );

    blocTest<TransactionBloc, TransactionState>(
      'emits [TransactionLoading, TransactionError] ao falhar ao adicionar transação',
      build: () {
        when(
          () => mockAddUseCase(
            description: any(named: 'description'),
            value: any(named: 'value'),
            date: any(named: 'date'),
          ),
        ).thenThrow(Exception('Erro'));
        return bloc;
      },
      act: (bloc) => bloc.add(
        AddTransaction(
          description: 'Teste',
          value: 10.0,
          date: '2025-07-14T12:00:00',
        ),
      ),
      expect: () => [isA<TransactionLoading>(), isA<TransactionError>()],
    );

    blocTest<TransactionBloc, TransactionState>(
      'emits [TransactionLoading, TransactionLoaded] ao carregar transações com sucesso',
      build: () {
        when(() => mockFetchUseCase()).thenAnswer((_) async => []);
        return bloc;
      },
      act: (bloc) => bloc.add(LoadTransactions()),
      expect: () => [isA<TransactionLoading>(), isA<TransactionLoaded>()],
    );

    blocTest<TransactionBloc, TransactionState>(
      'emits [TransactionLoading, TransactionError] ao falhar ao carregar transações',
      build: () {
        when(() => mockFetchUseCase()).thenThrow(Exception('Erro'));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadTransactions()),
      expect: () => [isA<TransactionLoading>(), isA<TransactionError>()],
    );
  });
}
