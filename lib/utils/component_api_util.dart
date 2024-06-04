import 'dart:convert';
import 'package:http/http.dart' as http;

class ComponentApiService {
  static const String baseUrl = 'https://api-estoque-adolfo.vercel.app/components';

  static Future<List<dynamic>> getComponents(String accessToken) async {
    final url = Uri.parse(baseUrl);
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load components');
    }
  }

  static Future<void> createComponent(String accessToken, String nomeComponent) async {
    final url = Uri.parse('$baseUrl/create');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: json.encode({
        'nome_component': nomeComponent,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create component');
    }
  }

  static Future<void> deleteComponent(String accessToken, int idComponent) async {
    final url = Uri.parse('$baseUrl/$idComponent');
    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete component');
    }
  }
}
