import 'dart:convert';

import 'package:api_integrations/models/products_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<List<ProductsModel>> getProducts() async {
    const String url = "https://fakestoreapi.com/products";
    final responce = await http.get(Uri.parse(url));
    if (responce.statusCode == 200) {
      final List data = jsonDecode(responce.body);
      return data.map((json) => ProductsModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }

  static const String baseUrl = "https://fakestoreapi.com";

  // POST: Create Product
  Future<ProductsModel> createProduct(ProductsModel product) async {
    final response = await http.post(
      Uri.parse('$baseUrl/products'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ProductsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to create product");
    }
  }
}
