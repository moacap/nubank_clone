import 'package:flutter/material.dart';
import '../bloc/transaction_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final descriptionController = TextEditingController();
    final valueController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Transações')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              key: const Key('description_field'),
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              key: const Key('value_field'),
              controller: valueController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Valor',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Adicionar'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
