import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/example_bloc.dart';

class ExamplePage extends StatelessWidget {
  const ExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExampleBloc(
        // Passe o usecase real aqui
        RepositoryProvider.of(context),
      )..add(FetchItemsEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Exemplo API')),
        body: BlocBuilder<ExampleBloc, ExampleState>(
          builder: (context, state) {
            if (state is ExampleLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ExampleLoaded) {
              return ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  return ListTile(title: Text(item.toString()));
                },
              );
            } else if (state is ExampleError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
