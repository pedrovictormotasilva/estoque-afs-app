import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final url = Uri.parse('https://api-estoque-adolfo.vercel.app/login');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'senha': password,
        }),
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        if (responseData.containsKey('accessToken')) {
          return {
            'success': true,
            'accessToken': responseData['accessToken'],
            'nome': responseData['nome'] ?? '',
          };
        } else {
          return {
            'success': false,
            'errorMessage': "accessToken não encontrado na resposta da API.",
          };
        }
      } else {
        return {
          'success': false,
          'errorMessage': "Falha ao fazer login. Verifique suas credenciais.",
        };
      }
    } catch (e) {
      return {
        'success': false,
        'errorMessage': "Conecte-se em uma rede Wi-fi para logar.",
      };
    }
  }
}
