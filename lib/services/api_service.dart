import 'dart:convert';
import 'dart:developer';
import 'dart:io'; // For handling network errors
import 'dart:async'; // For TimeoutException
import 'package:dartz/dartz.dart'; // For Either, Right, Left
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:pickpay/core/errors/failures.dart'; // Ensure ServerFailure is here
import 'package:pickpay/core/utils/backend_endpoints.dart';
import 'package:pickpay/features/auth/data/models/user_model.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.1.7:3000/api/v1/';

  // Method to perform a GET request
  Future<http.Response> get({
    required String endpoint,
  }) async {
    String url = '$baseUrl$endpoint';
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 15));
      return response;
    } catch (e) {
      throw Exception('Error performing GET request: ${e.toString()}');
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
            originalPrice: productData['originalPrice']?.toDouble() ??
                productData['price'].toDouble(),
            rating: productData['rating']?.toDouble() ?? 0.0,
            reviewCount: productData['ratingsQuantity'] ?? 0,
          );
        }).toList();
      } else {
        final message =
            jsonDecode(response.body)['message'] ?? 'Unknown error occurred';
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

  // Sync Firebase user to backend with error handling
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

  // Generic POST request with authorization and error handling
  Future<http.Response> post({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    bool authorized = false,
  }) async {
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

    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: requestHeaders,
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 15)); // Timeout after 15 seconds

      return response;
    } catch (e) {
      throw Exception('Network request failed: ${e.toString()}');
    }
  }

  // Forgot Password with error handling
  Future<http.Response> forgotPassword(String email) async {
    return await post(
      endpoint: 'auth/forgotPassword',
      body: {'email': email},
    );
  }

  // Reset Password with error handling
  Future<http.Response> resetPassword({
    required String token,
    required String password,
    required String passwordConfirm,
  }) async {
    final url = '${baseUrl}auth/resetPassword/$token';

    try {
      return await http
          .put(
            Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'password': password,
              'passwordConfirm': passwordConfirm,
            }),
          )
          .timeout(const Duration(seconds: 15)); // Timeout after 15 seconds
    } catch (e) {
      throw Exception('Error resetting password: ${e.toString()}');
    }
  }

  // Handling Token Expiration
  Future<String?> refreshToken() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final refreshedToken = await user?.getIdToken(true); // Refresh token
      return refreshedToken;
    } catch (e) {
      throw Exception('Error refreshing token: ${e.toString()}');
    }
  }

  // Check if User Exists (with error handling)
  Future<Either<Failure, bool>> checkUserExists(String email) async {
    try {
      // Check in Firebase
      final methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.isNotEmpty) {
        return right(true);
      }

      // Check in backend
      final response = await ApiService().post(
        endpoint: BackendEndpoints.checkUserExists,
        body: {'email': email},
      );

      final data = jsonDecode(response.body);
      final exists = data['exists'] == true;

      return right(exists);
    } catch (e) {
      log('Check user exists error: $e');
      return left(
          ServerFailure('فشل التحقق من وجود المستخدم: ${e.toString()}'));
    }
  }
}
