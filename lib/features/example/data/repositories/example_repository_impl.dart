import '../datasources/example_remote_datasource.dart';

class ExampleRepositoryImpl {
  final ExampleRemoteDatasource remoteDatasource;

  ExampleRepositoryImpl(this.remoteDatasource);

  Future<List<dynamic>> fetchItems() async {
    return await remoteDatasource.fetchItems();
  }

  Future<dynamic> createItem(Map<String, dynamic> data) async {
    return await remoteDatasource.createItem(data);
  }
}
