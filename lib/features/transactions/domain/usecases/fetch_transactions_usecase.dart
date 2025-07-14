import '../repositories/transaction_repository.dart';
import '../entities/transaction_entity.dart';

class FetchTransactionsUseCase {
  final TransactionRepository repository;
  FetchTransactionsUseCase(this.repository);

  Future<List<TransactionEntity>> call() {
    return repository.fetchTransactions();
  }
}
