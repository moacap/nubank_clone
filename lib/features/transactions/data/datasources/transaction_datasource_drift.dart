import 'package:drift/drift.dart';
import '../../domain/entities/transaction_entity.dart';
import 'transaction_datasource.dart';
import '../models/transaction_model.dart';
import '../../../../dao/transaction_dao.dart';

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
  Future<List<TransactionModel>> getAllTransactions() async {
    final result = await db.getAllTransactions();
    return result
        .map(
          (t) => TransactionModel(
            id: t.id,
            description: t.description,
            value: t.value,
            date: t.date,
          ),
        )
        .toList();
  }
}
