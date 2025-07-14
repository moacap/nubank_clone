import '../dao/transaction_dao.dart';
import 'package:drift/drift.dart';

abstract class TransactionDataSource {
  Future<int> saveTransaction({
    required String description,
    required double value,
    required String date,
  });
  Future<List<Transaction>> getAllTransactions();
}

class TransactionDataSourceDrift implements TransactionDataSource {
  final AppDatabase db;
  TransactionDataSourceDrift(this.db);

  @override
  Future<int> saveTransaction({
    required String description,
    required double value,
    required String date,
  }) {
    return db.insertTransaction(
      TransactionsCompanion(
        description: Value(description),
        value: Value(value),
        date: Value(date),
      ),
    );
  }

  @override
  Future<List<Transaction>> getAllTransactions() {
    return db.getAllTransactions();
  }
}
