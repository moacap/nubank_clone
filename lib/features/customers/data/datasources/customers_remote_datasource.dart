import 'dart:convert';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/customer.dart';

class CustomersRemoteDatasource {
  final ApiClient apiClient;

  CustomersRemoteDatasource(this.apiClient);

  Future<List<Customer>> fetchCustomers() async {
    final response = await apiClient.get('/');
    if (response.body.isNotEmpty) {
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map((e) => Customer.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  Future<dynamic> createCustomer(Map<String, dynamic> data) async {
    final response = await apiClient.post('/', body: data);
    return jsonDecode(response.body);
  }
}
