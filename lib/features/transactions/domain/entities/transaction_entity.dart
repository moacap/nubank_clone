class TransactionEntity {
  final int? id;
  final String description;
  final double value;
  final String date;

  TransactionEntity({
    this.id,
    required this.description,
    required this.value,
    required this.date,
  });
}
