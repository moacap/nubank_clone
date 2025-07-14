import '../../data/repositories/example_repository_impl.dart';

class FetchItemsUseCase {
  final ExampleRepositoryImpl repository;

  FetchItemsUseCase(this.repository);

  Future<List<dynamic>> call() async {
    return await repository.fetchItems();
  }
}
