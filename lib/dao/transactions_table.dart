import 'package:drift/drift.dart';

class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text()();
  RealColumn get value => real()();
  TextColumn get date => text()();
}
