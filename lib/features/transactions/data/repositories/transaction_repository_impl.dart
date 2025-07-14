import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/transaction_datasource.dart';
import '../models/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionDataSource dataSource;
  TransactionRepositoryImpl(this.dataSource);

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
  Future<List<TransactionEntity>> fetchTransactions() async {
    final models = await dataSource.getAllTransactions();
    return models;
  }
}
