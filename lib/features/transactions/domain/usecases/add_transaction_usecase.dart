import '../repositories/transaction_repository.dart';

class AddTransactionUseCase {
  final TransactionRepository repository;
  AddTransactionUseCase(this.repository);

  Future<int> call({
    required String description,
    required double value,
    required String date,
  }) {
    return repository.addTransaction(
      description: description,
      value: value,
      date: date,
    );
  }
}
