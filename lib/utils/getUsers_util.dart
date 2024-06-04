import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserService {
  static Future<Map<String, dynamic>?> getUserInfo(String accessToken) async {
    final url = Uri.parse('https://api-estoque-adolfo.vercel.app/users');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      try {
        final responseData = json.decode(response.body);
        print('Resposta da API: $responseData');

        Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
        int userId = decodedToken['id'];

        var user = responseData.firstWhere((user) => user['id'] == userId,
            orElse: () => null);

        if (user != null && user['nome'] is String && user['email'] is String) {
          print('Usuário encontrado: ${user['nome']} - ${user['email']} - ${user['id']}]');
          return {
            'nome': user['nome'],
            'email': user['email'],
            'id': user['id'],
          };
        } else {
          print('Nome ou email não encontrados ou não são strings.');
          return null;
        }
      } catch (e) {
        print('Erro ao decodificar resposta da API: $e');
        return null;
      }
    } else {
      print('Falha ao obter informações do usuário: ${response.statusCode}');
      return null;
    }
  }
}
