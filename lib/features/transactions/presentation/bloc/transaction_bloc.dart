// Transaction BLoC migrado para estrutura de features
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/add_transaction_usecase.dart';
import '../../domain/usecases/fetch_transactions_usecase.dart';
import '../../domain/entities/transaction_entity.dart';

// Events
abstract class TransactionEvent {}

class AddTransaction extends TransactionEvent {
  final String description;
  final double value;
  final String date;
  AddTransaction({
    required this.description,
    required this.value,
    required this.date,
  });
}

class LoadTransactions extends TransactionEvent {}

// States
abstract class TransactionState {}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<TransactionEntity> transactions;
  TransactionLoaded(this.transactions);
}

class TransactionError extends TransactionState {
  final String message;
  TransactionError(this.message);
}

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final AddTransactionUseCase addTransactionUseCase;
  final FetchTransactionsUseCase fetchTransactionsUseCase;

  TransactionBloc({
    required this.addTransactionUseCase,
    required this.fetchTransactionsUseCase,
  }) : super(TransactionInitial()) {
    on<AddTransaction>((event, emit) async {
      emit(TransactionLoading());
      try {
        await addTransactionUseCase(
          description: event.description,
          value: event.value,
          date: event.date,
        );
        final transactions = await fetchTransactionsUseCase();
        emit(TransactionLoaded(transactions));
      } catch (e) {
        emit(TransactionError('Erro ao adicionar transação'));
      }
    });
    on<LoadTransactions>((event, emit) async {
      emit(TransactionLoading());
      try {
        final transactions = await fetchTransactionsUseCase();
        emit(TransactionLoaded(transactions));
      } catch (e) {
        emit(TransactionError('Erro ao carregar transações'));
      }
    });
  }
}
