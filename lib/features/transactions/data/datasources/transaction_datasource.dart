import '../models/transaction_model.dart';

abstract class TransactionDataSource {
  Future<int> saveTransaction({
    required String description,
    required double value,
    required String date,
  });
  Future<List<TransactionModel>> getAllTransactions();
}
