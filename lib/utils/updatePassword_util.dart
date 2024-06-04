import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static Future<Map<String, dynamic>?> getUserInfo(String accessToken) async {
    final response = await http.get(
      Uri.parse('https://api-estoque-adolfo.vercel.app/users/me'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      print('Erro ao buscar informações do usuário: ${response.statusCode}');
      return null;
    }
  }

  static Future<bool> updatePassword(
      int userId,
      String currentPassword,
      String newPassword,
      String accessToken,
      String userName,
      String userEmail,
      ) async {
    final response = await http.put(
      Uri.parse('https://api-estoque-adolfo.vercel.app/users/$userId'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'nome': userName,
        'email': userEmail,
        'senha': newPassword, // Ajuste aqui
        'role': 2, // Ajuste aqui
      }),
    );

    return response.statusCode == 200;
  }
}
