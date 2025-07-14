import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  final Map<String, String> defaultHeaders;

  ApiClient({required this.baseUrl, this.defaultHeaders = const {}});

  Future<http.Response> get(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: {...defaultHeaders, ...?headers},
    );
    _checkError(response);
    return response;
  }

  Future<http.Response> post(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        ...defaultHeaders,
        ...?headers,
        'Content-Type': 'application/json',
      },
      body: body != null ? jsonEncode(body) : null,
    );
    _checkError(response);
    return response;
  }

  void _checkError(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'Erro na requisição: ${response.statusCode} - ${response.body}',
      );
    }
  }
}
