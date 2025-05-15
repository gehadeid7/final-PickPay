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
  static const String baseUrl = 'http://192.168.1.7:3000/api/v1/';

  // Method to perform a GET request
  Future<http.Response> get({
    required String endpoint,
  }) async {
    final url = '$baseUrl$endpoint';
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 15));
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
      // 1. Get all categories
      final categoriesResponse = await http
          .get(Uri.parse('${baseUrl}categories'))
          .timeout(const Duration(seconds: 15));

      if (categoriesResponse.statusCode != 200) {
        throw Exception('Failed to load categories');
      }

      final categoriesData = jsonDecode(categoriesResponse.body);
      final categories = categoriesData['data'] as List;
      log('Categories loaded: ${categories.length}');

      // 2. Find the Appliances category
      final appliancesCategory = categories.firstWhere(
        (category) => category['name'] == 'Appliances',
        orElse: () => throw Exception('Appliances category not found'),
      );
      log('Found Appliances category with ID: ${appliancesCategory['_id']}');

      // 3. Use the ObjectId to fetch products
      final productsUrl =
          '${baseUrl}products?category=${appliancesCategory['_id']}';
      log('Fetching products from: $productsUrl');

      final response = await http
          .get(Uri.parse(productsUrl))
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log('Products response: ${response.body}');

        final products = data['data'] as List;
        log('Number of products found: ${products.length}');

        if (products.isEmpty) {
          log('No products found for Appliances category');
          return [];
        }

        // Log each product's details
        log('=== Product Details ===');
        for (var product in products) {
          log('ID: ${product['_id']}');
          log('Title: ${product['title']}');
          log('Brand: ${product['brand']}');
          log('Price: ${product['price']}');
          log('-------------------');
        }
        log('=====================');

        final productCards = products.map((productData) {
          log('Processing product: ${productData['title']}');

          // Handle image URLs - ensure they're absolute URLs
          List<String> imagePaths = [];
          if (productData['images'] != null) {
            imagePaths = (productData['images'] as List).map((img) {
              if (img.toString().startsWith('http')) {
                return img.toString();
              }
              return '${baseUrl}products/$img';
            }).toList();
          }

          // If no images, use the imageCover
          if (imagePaths.isEmpty && productData['imageCover'] != null) {
            String coverImage = productData['imageCover'];
            if (!coverImage.startsWith('http')) {
              coverImage = '${baseUrl}products/$coverImage';
            }
            imagePaths = [coverImage];
          }

          return ProductCard(
            id: productData['_id'],
            name: productData['title'],
            imagePaths: imagePaths,
            price: (productData['price'] as num).toDouble(),
            originalPrice: (productData['originalPrice'] as num?)?.toDouble() ??
                (productData['price'] as num).toDouble(),
            rating: (productData['ratingsAverage'] as num?)?.toDouble() ?? 0.0,
            reviewCount: productData['ratingsQuantity'] ?? 0,
          );
        }).toList();

        log('Successfully created ${productCards.length} ProductCard objects');
        return productCards;
      } else {
        final message =
            jsonDecode(response.body)['message'] ?? 'Unknown error occurred';
        log('Error response: ${response.body}');
        throw Exception('Failed to load products: $message');
      }
    } on TimeoutException {
      log('Request timed out');
      throw Exception('Request timed out. Please try again later.');
    } on SocketException {
      log('No internet connection');
      throw Exception('No internet connection. Please check your network.');
    } catch (e) {
      log('Error in loadProducts: $e');
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
      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      if (token == null) {
        throw Exception('Token is null. User is not authenticated.');
      }

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

// ✅ Forgot Password (ensures user is synced with backend)
  Future<http.Response> forgotPassword(String email) async {
    try {
      // Check Firebase sign-in methods to ensure user exists
      final methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.isEmpty) {
        throw Exception("No Firebase user found with this email.");
      }

      // Get Firebase user (currently signed in)
      final firebaseUser = FirebaseAuth.instance.currentUser;

      if (firebaseUser == null || firebaseUser.email != email) {
        throw Exception("User not authenticated with this email.");
      }

      final idToken = await firebaseUser.getIdToken();

      // Sync user to backend if necessary
      await syncFirebaseUserToBackend(
        name: firebaseUser.displayName ?? 'No Name',
        email: firebaseUser.email!,
        firebaseUid: firebaseUser.uid,
      );

      // Call backend forgot password endpoint
      final response = await post(
        endpoint: 'auth/forgotPassword',
        body: {'email': email},
        authorized: false,
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to send reset code: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error in forgotPassword: ${e.toString()}');
    }
  }

  // ✅ Reset Password (after user verifies code)
  Future<http.Response> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      final response = await put(
        endpoint: 'auth/resetPassword',
        body: {
          'email': email,
          'newPassword': newPassword,
        },
        authorized: false,
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Reset password failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error in resetPassword: ${e.toString()}');
    }
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
      return left(
          ServerFailure('فشل التحقق من وجود المستخدم: ${e.toString()}'));
    }
  }
}
