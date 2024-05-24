import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductApiService {
  static const baseUrl = 'https://api-estoque-adolfo.vercel.app/Product';

  static Future<Map<String, dynamic>> getProducts(String accessToken) async {
    final response = await http.get(
      Uri.parse('$baseUrl'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar os produtos');
    }
  }

  static Future<Map<String, dynamic>> getProductById(
      String accessToken, int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$id'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar o produto');
    }
  }

  static Future<void> updateProduct(
      String accessToken, int id, Map<String, dynamic> updatedProduct) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(updatedProduct),
    );
    if (response.statusCode != 200) {
      throw Exception('falha ao atualizar o produto');
    }
  }

  static Future<void> deleteProduct(String accessToken, int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    if (response.statusCode != 200) {
      throw Exception('falha ao deletar o produto');
    }
  }

  static Future<void> createProduct(
      String accessToken, Map<String, dynamic> newProduct) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(newProduct),
    );
    if (response.statusCode != 201) {
      throw Exception('Falha ao criar o produto');
    }
  }
}
