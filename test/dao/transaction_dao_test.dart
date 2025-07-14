import 'package:flutter_test/flutter_test.dart';
import 'package:nubank_clone/dao/transaction_dao.dart';
import 'package:nubank_clone/dao/transactions_table.dart';
import 'package:drift/drift.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late AppDatabase db;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });
  setUp(() {
    db = AppDatabase();
  });

  tearDown(() async {
    await db.close();
  });

  group('AppDatabase (DAO Drift)', () {
    test(
      'insertTransaction e getAllTransactions devem funcionar corretamente',
      () async {
        final entry = TransactionsCompanion(
          description: const Value('Teste'),
          value: const Value(99.99),
          date: const Value('2025-07-14T12:00:00'),
        );
        final id = await db.insertTransaction(entry);
        expect(id, isNonZero);
        final all = await db.getAllTransactions();
        expect(all, isNotEmpty);
        expect(all.first.description, 'Teste');
        expect(all.first.value, 99.99);
        expect(all.first.date, '2025-07-14T12:00:00');
      },
    );
  });
}
