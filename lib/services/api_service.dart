import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:pickpay/core/errors/failures.dart';
import 'package:pickpay/core/services/shared_preferences_singletone.dart';
import 'package:pickpay/core/utils/backend_endpoints.dart';
import 'package:pickpay/features/auth/data/models/user_model.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';
import 'package:http_parser/http_parser.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.1.7:3000/api/v1/';

  // 🔐 Builds headers with optional Firebase token
  Future<Map<String, String>> _buildHeaders({
    Map<String, String>? headers,
    bool authorized = false,
  }) async {
    final Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      ...?headers,
    };

    if (authorized) {
      final user = FirebaseAuth.instance.currentUser;
      String token = '';

      if (user != null) {
        token = await user.getIdToken(true) ?? '';
        if (token.isNotEmpty) {
          await Prefs.setString('jwt_token', token);
          log('🔐 Token refreshed and saved automatically');
        }
      }

      if (token.isEmpty) {
        token = Prefs.getString('jwt_token');
        log('🔐 Using cached token from prefs');
      }

      if (token.isNotEmpty) {
        requestHeaders['Authorization'] = 'Bearer $token';
        log('🔐 Sending token in header: Bearer $token');
      } else {
        log('⚠️ No token found to send!');
      }
    }

    return requestHeaders;
  }

  // 🌐 GET request
  Future<http.Response> get({
    required String endpoint,
    Map<String, String>? headers,
    bool authorized = false,
  }) async {
    final url = '$baseUrl$endpoint';
    final requestHeaders =
        await _buildHeaders(headers: headers, authorized: authorized);
    log('📡 GET $url');
    log('📤 Headers: $requestHeaders');
    try {
      final response = await http
          .get(Uri.parse(url), headers: requestHeaders)
          .timeout(const Duration(seconds: 15));
      return response;
    } catch (e) {
      throw Exception('Error performing GET request: ${e.toString()}');
    }
  }

  // 🌐 POST request
  Future<http.Response> post({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    bool authorized = false,
  }) async {
    final url = '$baseUrl$endpoint';
    final requestHeaders =
        await _buildHeaders(headers: headers, authorized: authorized);
    log('📡 POST $url');
    log('📤 Headers: $requestHeaders');
    log('📤 Body: ${jsonEncode(body)}');
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

  // 🌐 PUT request
  Future<http.Response> put({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    bool authorized = false,
  }) async {
    final url = '$baseUrl$endpoint';
    final requestHeaders =
        await _buildHeaders(headers: headers, authorized: authorized);
    log('📡 PUT $url');
    log('📤 Headers: $requestHeaders');
    log('📤 Body: ${jsonEncode(body)}');
    try {
      final response = await http
          .put(
            Uri.parse(url),
            headers: requestHeaders,
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 15));
      log('✅ Response [${response.statusCode}]: ${response.body}');
      return response;
    } catch (e) {
      log('❌ Network error: ${e.toString()}');
      throw Exception('Network PUT request failed: ${e.toString()}');
    }
  }

  // 🛒 Load products from "Appliances" category
  Future<List<ProductCard>> loadProducts() async {
    try {
      final categoriesResponse = await http
          .get(Uri.parse('${baseUrl}categories'))
          .timeout(const Duration(seconds: 15));

      if (categoriesResponse.statusCode != 200) {
        throw Exception('Failed to load categories');
      }

      final categoriesData = jsonDecode(categoriesResponse.body);
      final categories = categoriesData['data'] as List;
      log('Categories loaded: ${categories.length}');

      final appliancesCategory = categories.firstWhere(
        (category) => category['name'] == 'Appliances',
        orElse: () => throw Exception('Appliances category not found'),
      );
      log('Found Appliances category with ID: ${appliancesCategory['_id']}');

      final productsUrl =
          '${baseUrl}products?category=${appliancesCategory['_id']}';
      log('Fetching products from: $productsUrl');

      final response = await http
          .get(Uri.parse(productsUrl))
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final products = data['data'] as List;

        final productCards = products.map((productData) {
          List<String> imagePaths = [];
          if (productData['images'] != null) {
            imagePaths = (productData['images'] as List).map((img) {
              if (img.toString().startsWith('http')) {
                return img.toString();
              }
              return '${baseUrl}products/$img';
            }).toList();
          }

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

        return productCards;
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

  // 🔄 Sync Firebase user to backend
  Future<UserModel> syncFirebaseUserToBackend({
    required String name,
    required String email,
    required String firebaseUid,
    String? photoUrl,
  }) async {
    try {
      String token = Prefs.getString('jwt_token');
      if (token.isEmpty) {
        token = await FirebaseAuth.instance.currentUser?.getIdToken() ?? '';
        if (token.isNotEmpty) {
          await Prefs.setString('jwt_token', token);
        }
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
          'photoUrl': photoUrl,
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

  // 🔐 Forgot password
  Future<http.Response> forgotPassword(String email) async {
    try {
      final methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.isEmpty) {
        throw Exception("No Firebase user found with this email.");
      }

      final firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser == null || firebaseUser.email != email) {
        throw Exception("User not authenticated with this email.");
      }

      final idToken = await firebaseUser.getIdToken();

      await syncFirebaseUserToBackend(
        name: firebaseUser.displayName ?? 'No Name',
        email: firebaseUser.email!,
        firebaseUid: firebaseUser.uid,
        photoUrl: firebaseUser.photoURL,
      );

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

  // 🔐 Reset password
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

  // 🔁 Refresh Firebase token
  Future<String?> refreshToken() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return null;

      final refreshedToken = await user.getIdToken(true);
      if (refreshedToken != null) {
        await Prefs.setString('jwt_token', refreshedToken);
      }
      return refreshedToken;
    } catch (e) {
      return null;
    }
  }

  // ✅ Check if user exists
  Future<Either<Failure, bool>> checkUserExists(String email) async {
    try {
      final methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.isNotEmpty) {
        return right(true);
      }

      final response = await post(
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

  // 📤 Upload image to server (used for profile image)
  Future<http.StreamedResponse> uploadImage({
    required String endpoint,
    required File imageFile,
    Map<String, String>? fields,
    bool authorized = false,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    print('⬆️ uploadImage: Starting upload to $url');
    print('⬆️ uploadImage: File path: ${imageFile.path}');
    if (fields != null) {
      print('⬆️ uploadImage: Additional fields: $fields');
    }

    final request = http.MultipartRequest('POST', url);

    final headers = await _buildHeaders(authorized: authorized);
    print('⬆️ uploadImage: Headers: $headers');
    request.headers.addAll(headers);

    if (fields != null) {
      request.fields.addAll(fields);
    }

    final multipartFile = await http.MultipartFile.fromPath(
      'profileImg',
      imageFile.path,
      contentType: MediaType('image', 'jpeg'),
    );
    request.files.add(multipartFile);
    print('⬆️ uploadImage: Added multipart file with field name "profileImg"');

    try {
      final streamedResponse =
          await request.send().timeout(const Duration(seconds: 30));
      print(
          '⬆️ uploadImage: Request sent, status code: ${streamedResponse.statusCode}');
      return streamedResponse;
    } catch (e) {
      print('⛔ uploadImage: Exception occurred - ${e.toString()}');
      throw Exception('Error uploading image: ${e.toString()}');
    }
  }

// 🖼️ Pick image, upload it, then update user profile
  Future<String> uploadProfileImageAndUpdate(File imageFile) async {
    print('💾 uploadProfileImageAndUpdate: Starting process...');
    try {
      final uploadResponse = await uploadImage(
        endpoint: BackendEndpoints.uploadUserPhoto,
        imageFile: imageFile,
        authorized: true,
      );

      print(
          '💾 uploadProfileImageAndUpdate: Upload response status code: ${uploadResponse.statusCode}');

      if (uploadResponse.statusCode == 200) {
        final responseString = await uploadResponse.stream.bytesToString();
        print(
            '💾 uploadProfileImageAndUpdate: Upload response string: $responseString');

        final responseData = jsonDecode(responseString);

        final uploadedFilename = responseData['profileImg'];
        print(
            '💾 uploadProfileImageAndUpdate: Received profileImg from backend: $uploadedFilename');

        if (uploadedFilename == null) {
          throw Exception('Image uploaded but no filename returned');
        }

        final profileImageUrl =
            'http://192.168.1.7:3000/uploads/users/$uploadedFilename';
        print(
            '💾 uploadProfileImageAndUpdate: Full Image URL: $profileImageUrl');

        final updateResponse = await put(
          endpoint: BackendEndpoints.updateMe,
          body: {'profileImg': uploadedFilename},
          authorized: true,
        );

        print(
            '💾 uploadProfileImageAndUpdate: Update profile response status: ${updateResponse.statusCode}');
        print(
            '💾 uploadProfileImageAndUpdate: Update profile response body: ${updateResponse.body}');

        if (updateResponse.statusCode != 200) {
          throw Exception(
              'Failed to update user profile image: ${updateResponse.body}');
        }

        print(
            '💾 uploadProfileImageAndUpdate: Profile image updated successfully.');
        return profileImageUrl;
      } else {
        final error = await uploadResponse.stream.bytesToString();
        print(
            '⛔ uploadProfileImageAndUpdate: Image upload failed with response: $error');
        throw Exception('Image upload failed: $error');
      }
    } catch (e) {
      print('⛔ uploadProfileImageAndUpdate: Exception - ${e.toString()}');
      throw Exception('uploadProfileImageAndUpdate error: ${e.toString()}');
    }
  }
}
