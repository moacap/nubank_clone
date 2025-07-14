import 'package:drift/drift.dart';
import 'package:drift_sqflite/drift_sqflite.dart';
import 'transactions_table.dart';

part 'transaction_dao.g.dart';

@DriftDatabase(tables: [Transactions])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
    : super(SqfliteQueryExecutor.inDatabaseFolder(path: 'nubank_clone.db'));

  @override
  int get schemaVersion => 1;

  // DAO methods
  Future<int> insertTransaction(TransactionsCompanion entry) =>
      into(transactions).insert(entry);
  Future<List<Transaction>> getAllTransactions() => select(transactions).get();
}
