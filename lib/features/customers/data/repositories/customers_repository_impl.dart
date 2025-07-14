import '../datasources/customers_remote_datasource.dart';
import '../../domain/entities/customer.dart';

class CustomersRepositoryImpl {
  final CustomersRemoteDatasource remoteDatasource;

  CustomersRepositoryImpl(this.remoteDatasource);

  Future<List<Customer>> fetchCustomers() async {
    return await remoteDatasource.fetchCustomers();
  }

  Future<dynamic> createCustomer(Map<String, dynamic> data) async {
    return await remoteDatasource.createCustomer(data);
  }
}
