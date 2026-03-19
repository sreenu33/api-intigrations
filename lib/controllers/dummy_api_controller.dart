import 'dart:convert';
import 'dart:developer';

import 'package:api_integrations/models/user_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DummyApiController extends GetxController {
   List<UserDataModel> usersData = [];
  final String api =
      "https://fakestoreapi.com/carts";
  Future<void> getAllUsers() async {
    final responce = await http.get(Uri.parse(api));
    log("responce>>>>>${responce.body}");
    if (responce.statusCode == 200) {
      final List data = jsonDecode(responce.body);
       usersData = data.map((json) => UserDataModel.fromJson(json)).toList();
      update();
    } else {
      throw Exception("Failed to load Users");
    }
  }
}
