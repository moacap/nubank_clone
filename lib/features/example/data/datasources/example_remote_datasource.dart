import 'dart:convert';
import '../../../../core/network/api_client.dart';

class ExampleRemoteDatasource {
  final ApiClient apiClient;

  ExampleRemoteDatasource(this.apiClient);

  Future<List<dynamic>> fetchItems() async {
    final response = await apiClient.get('/items');
    // Supondo que a resposta seja um JSON array
    return response.body.isNotEmpty
        ? List<dynamic>.from(jsonDecode(response.body))
        : [];
  }

  Future<dynamic> createItem(Map<String, dynamic> data) async {
    final response = await apiClient.post('/items', body: data);
    return jsonDecode(response.body);
  }
}
