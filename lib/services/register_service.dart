import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' show Client;

class RegisterService extends GetxService {
  Client client = Client();

  Future<dynamic> register(
    String name,
    String email,
    String password,
    String password_confirmation,
  ) async {
    try {
      final response = await client.post(
        Uri.parse('http://127.0.0.1:8000/api/register'),
        body: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': password_confirmation,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return throw Exception(e);
    }
  }
}
