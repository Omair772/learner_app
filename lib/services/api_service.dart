import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://jsonplaceholder.typicode.com';

  // جلب البيانات من API
  Future<List<dynamic>> getItems() async {
    final response = await http.get(
      Uri.parse('$baseUrl/posts'),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception(
      'Failed to load data',
    );
  }

  // جلب عنصر واحد
  Future<Map<String, dynamic>> getItem(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/posts/$id'),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception(
      'Failed to load item',
    );
  }

  // إرسال بيانات إلى API
  Future<Map<String, dynamic>> createItem({
    required String title,
    required String body,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/posts'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'title': title,
        'body': body,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    }

    throw Exception(
      'Failed to create item',
    );
  }
}