// productService.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  static Future<Map<int, int>> getProductCounts(String accessToken) async {
    final response = await http.get(
      Uri.parse('https://api-estoque-adolfo.vercel.app/Product'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final products = data['Company'];
      final productCounts = <int, int>{};

      for (var product in products) {
        final categoryId = product['categoryId'];
        if (productCounts.containsKey(categoryId)) {
          productCounts[categoryId] = productCounts[categoryId]! + 1;
        } else {
          productCounts[categoryId] = 1;
        }
      }

      return productCounts;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
