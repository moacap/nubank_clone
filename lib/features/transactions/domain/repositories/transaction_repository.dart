import '../entities/transaction_entity.dart';

abstract class TransactionRepository {
  Future<int> addTransaction({
    required String description,
    required double value,
    required String date,
  });
  Future<List<TransactionEntity>> fetchTransactions();
}
