import '../../data/repositories/customers_repository_impl.dart';
import '../entities/customer.dart';

class FetchCustomersUseCase {
  final CustomersRepositoryImpl repository;

  FetchCustomersUseCase(this.repository);

  Future<List<Customer>> call() async {
    return await repository.fetchCustomers();
  }
}
