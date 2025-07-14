import '../datasource/transaction_datasource.dart';
import '../dao/transaction_dao.dart';
import 'package:drift/drift.dart';

abstract class TransactionRepository {
  Future<int> addTransaction({
    required String description,
    required double value,
    required String date,
  });
  Future<List<Transaction>> fetchTransactions();
}

class TransactionRepositoryDrift implements TransactionRepository {
  final TransactionDataSource dataSource;
  TransactionRepositoryDrift(this.dataSource);

  @override
  Future<int> addTransaction({
    required String description,
    required double value,
    required String date,
  }) {
    return dataSource.saveTransaction(
      description: description,
      value: value,
      date: date,
    );
  }

  @override
  Future<List<Transaction>> fetchTransactions() {
    return dataSource.getAllTransactions();
  }
}
