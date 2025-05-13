import 'dart:convert';
import 'dart:developer';
import 'dart:io'; // For handling network errors
import 'dart:async'; // For TimeoutException
import 'package:dartz/dartz.dart'; // For Either, Right, Left
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:pickpay/core/errors/failures.dart';
import 'package:pickpay/core/utils/backend_endpoints.dart';
import 'package:pickpay/features/auth/data/models/user_model.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.1.4:3000/api/v1/';

  // Method to perform a GET request
  Future<http.Response> get({
    required String endpoint,
  }) async {
    final url = '$baseUrl$endpoint';
    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 15));
      return response;
    } catch (e) {
      throw Exception('Error performing GET request: ${e.toString()}');
    }
  }

  // Method to perform a POST request
  Future<http.Response> post({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    bool authorized = false,
  }) async {
    final url = '$baseUrl$endpoint';

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

    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: requestHeaders,
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } catch (e) {
      throw Exception('Network request failed: ${e.toString()}');
    }
  }

  // ✅ Method to perform a PUT request
  Future<http.Response> put({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    bool authorized = false,
  }) async {
    final url = '$baseUrl$endpoint';

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

    try {
      final response = await http
          .put(
            Uri.parse(url),
            headers: requestHeaders,
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } catch (e) {
      throw Exception('Network PUT request failed: ${e.toString()}');
    }
  }

  // Load Products with error handling
  Future<List<ProductCard>> loadProducts() async {
    try {
      final response = await http
          .get(Uri.parse('${baseUrl}products'))
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final products = data['data'] as List;

        return products.map((productData) {
          return ProductCard(
            id: productData['_id'],
            name: productData['title'],
            imagePaths: List<String>.from(productData['images'] ?? []),
            price: productData['price'].toDouble(),
            originalPrice: productData['originalPrice']?.toDouble() ?? productData['price'].toDouble(),
            rating: productData['rating']?.toDouble() ?? 0.0,
            reviewCount: productData['ratingsQuantity'] ?? 0,
          );
        }).toList();
      } else {
        final message = jsonDecode(response.body)['message'] ?? 'Unknown error occurred';
        throw Exception('Failed to load products: $message');
      }
    } on TimeoutException {
      throw Exception('Request timed out. Please try again later.');
    } on SocketException {
      throw Exception('No internet connection. Please check your network.');
    } catch (e) {
      throw Exception('Error loading products: ${e.toString()}');
    }
  }

  // Sync Firebase user to backend
  Future<UserModel> syncFirebaseUserToBackend({
    required String name,
    required String email,
    required String firebaseUid,
  }) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();

      final response = await http.post(
        Uri.parse('${baseUrl}auth/firebase/sync'),
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
    } catch (e) {
      throw Exception('Error syncing Firebase user: ${e.toString()}');
    }
  }

  // Forgot Password
  Future<http.Response> forgotPassword(String email) async {
    return await post(
      endpoint: 'auth/forgotPassword',
      body: {'email': email},
    );
  }

  // Reset Password using the generic PUT method
  Future<http.Response> resetPassword({
    required String token,
    required String password,
    required String passwordConfirm,
  }) async {
    return await put(
      endpoint: 'auth/resetPassword/$token',
      body: {
        'password': password,
        'passwordConfirm': passwordConfirm,
      },
    );
  }

  // Refresh Firebase token
  Future<String?> refreshToken() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final refreshedToken = await user?.getIdToken(true);
      return refreshedToken;
    } catch (e) {
      throw Exception('Error refreshing token: ${e.toString()}');
    }
  }

  // Check if user exists
  Future<Either<Failure, bool>> checkUserExists(String email) async {
    try {
      final methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.isNotEmpty) {
        return right(true);
      }

      final response = await ApiService().post(
        endpoint: BackendEndpoints.checkUserExists,
        body: {'email': email},
      );

      final data = jsonDecode(response.body);
      final exists = data['exists'] == true;

      return right(exists);
    } catch (e) {
      log('Check user exists error: $e');
      return left(ServerFailure('فشل التحقق من وجود المستخدم: ${e.toString()}'));
    }
  }
}
