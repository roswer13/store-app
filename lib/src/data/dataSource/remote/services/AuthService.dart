import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:store_app/src/data/api/ApiConfig.dart';
import 'package:store_app/src/domain/models/AuthResponse.dart';
import 'package:store_app/src/domain/utils/Resource.dart';

class Authservice {
  Future<Resource> login(String email, String password) async {
    try {
      print('Attempting to login with email: $email and password: $password');
      Uri uri = Uri.http(Apiconfig.apiCommerce, '/auth/login');

      Map<String, String> headers = {'Content-Type': 'application/json'};

      String body = json.encode({'email': email, 'password': password});

      final response = await http.post(uri, headers: headers, body: body);
      final data = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        AuthResponse authResponse = AuthResponse.fromJson(data);
        return Success<AuthResponse>(authResponse);
      } else {
        return Error(data['message'] ?? 'Login failed');
      }
    } catch (e) {
      // Handle error
      print('Error during login: $e');
      return Error('An error occurred during login: ${e.toString()}');
    }
  }
}
