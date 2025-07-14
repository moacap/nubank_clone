import '../../domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  TransactionModel({
    int? id,
    required String description,
    required double value,
    required String date,
  }) : super(id: id, description: description, value: value, date: date);

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as int?,
      description: map['description'] as String,
      value: map['value'] as double,
      date: map['date'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'description': description, 'value': value, 'date': date};
  }
}
