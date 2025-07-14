import 'package:flutter/material.dart';
import '../bloc/transaction_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transações')),
      body: Center(child: Text('Página de transações (feature structure)')),
    );
  }
}
