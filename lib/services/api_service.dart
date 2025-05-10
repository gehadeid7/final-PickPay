import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:pickpay/features/auth/data/models/user_model.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart'; // Import ProductCard

class ApiService {
  Future<List<ProductCard>> loadProducts() async {
    final response = await http.get(
      Uri.parse('http://192.168.1.3:3000/api/v1/products'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final products = data['data'] as List;

      return products.map((productData) {
        return ProductCard(
          id: productData['_id'],
          name: productData['title'],
          imagePaths: List<String>.from(productData['images'] ?? []),
          price: productData['price'].toDouble(),
          originalPrice: productData['originalPrice']?.toDouble() ??
              productData['price'].toDouble(),
          rating: productData['rating']?.toDouble() ?? 0.0,
          reviewCount: productData['ratingsQuantity'] ?? 0,
        );
      }).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<UserModel> syncFirebaseUserToBackend({
    required String name,
    required String email,
    required String firebaseUid,
  }) async {
    final token = await FirebaseAuth.instance.currentUser!.getIdToken();

    final response = await http.post(
      Uri.parse('http://192.168.1.3:3000/api/v1/auth/firebase/sync'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'uid': firebaseUid,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return UserModel.fromJson(data);
    } else {
      throw Exception('Failed to sync Firebase user: ${response.body}');
    }
  }
  Future<http.Response> post({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    bool authorized = false,
  }) async {
    const String baseUrl = 'http://192.168.1.4:3000/api/v1/';
    String url = '$baseUrl$endpoint';

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      ...?headers,
    };

    if (authorized) {
      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      if (token != null) {
        requestHeaders['Authorization'] = 'Bearer $token';
      }
    }

    final response = await http.post(
      Uri.parse(url),
      headers: requestHeaders,
      body: jsonEncode(body),
    );

    return response;
  }
}
