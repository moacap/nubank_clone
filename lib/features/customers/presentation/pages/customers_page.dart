import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/customers_bloc.dart';
import 'package:nubank_clone/core/network/api_client.dart';
import '../../data/datasources/customers_remote_datasource.dart';
import '../../data/repositories/customers_repository_impl.dart';
import '../../domain/usecases/fetch_customers_usecase.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final apiClient = ApiClient(
          baseUrl:
              'https://demo.salesfarma.com.br/sincronia/api/profissional/160115',
        ); // ajuste a URL conforme necessário
        final remoteDatasource = CustomersRemoteDatasource(apiClient);
        final repository = CustomersRepositoryImpl(remoteDatasource);
        final usecase = FetchCustomersUseCase(repository);
        return CustomersBloc(usecase)..add(FetchCustomersEvent());
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Clientes')),
        body: BlocBuilder<CustomersBloc, CustomersState>(
          builder: (context, state) {
            if (state is CustomersLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CustomersLoaded) {
              return ListView.builder(
                itemCount: state.customers.length,
                itemBuilder: (context, index) {
                  final customer = state.customers[index];
                  return ListTile(
                    title: Text(customer.nome),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (customer.email != null &&
                            customer.email!.isNotEmpty)
                          Text('Email:  0{customer.email}'),
                        if (customer.celular != null &&
                            customer.celular!.isNotEmpty)
                          Text('Celular:  0{customer.celular}'),
                        if (customer.especialidade != null &&
                            customer.especialidade!.isNotEmpty)
                          Text('Especialidade:  0{customer.especialidade}'),
                      ],
                    ),
                  );
                },
              );
            } else if (state is CustomersError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
