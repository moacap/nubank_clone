class Customer {
  final String nome;
  final String? email;
  final String? celular;
  final String? especialidade;

  Customer({required this.nome, this.email, this.celular, this.especialidade});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      nome: json['NOME'] ?? '',
      email: json['MERE_EMAIL'],
      celular: json['CELULAR'],
      especialidade: json['MERE_ESP1'],
    );
  }
}
