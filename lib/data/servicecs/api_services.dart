import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServicesUser {
  static const String baseUrl = "https://jsonplaceholder.typicode.com";
  Future<List<dynamic>> fetchUsers() async {
    final responce = await http.get(Uri.parse("$baseUrl/users"));
    if (responce.statusCode == 200) {
      return jsonDecode(responce.body);
    } else {
      throw Exception("Failed to load users");
    }
  }
}
