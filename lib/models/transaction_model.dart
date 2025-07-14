class TransactionModel {
  final int? id;
  final String description;
  final double value;
  final DateTime date;

  TransactionModel({
    this.id,
    required this.description,
    required this.value,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'value': value,
      'date': date.toIso8601String(),
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      description: map['description'],
      value: map['value'],
      date: DateTime.parse(map['date']),
    );
  }
}
