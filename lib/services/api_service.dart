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
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';
import 'package:http_parser/http_parser.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.1.7:3000/api/v1/';

  // 🔐 Builds headers for JSON requests
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

  // 🔐 Builds headers for multipart requests (no Content-Type)
  Future<Map<String, String>> _buildMultipartHeaders({
    bool authorized = false,
  }) async {
    final Map<String, String> requestHeaders = {};

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
    int maxRetries = 2,
  }) async {
    final url = '$baseUrl$endpoint';
    final requestHeaders =
        await _buildHeaders(headers: headers, authorized: authorized);
    log('📡 GET $url');
    log('📤 Headers: $requestHeaders');

    int retryCount = 0;
    while (retryCount <= maxRetries) {
      try {
        final response = await http
            .get(Uri.parse(url), headers: requestHeaders)
            .timeout(const Duration(seconds: 30)); // Increased timeout
        return response;
      } catch (e) {
        retryCount++;
        if (retryCount > maxRetries) {
          throw Exception(
              'Error performing GET request after $maxRetries retries: ${e.toString()}');
        }
        log('⚠️ Request failed, retrying (${retryCount}/$maxRetries)...');
        await Future.delayed(
            Duration(seconds: 2 * retryCount)); // Exponential backoff
      }
    }
    throw Exception('Unexpected error in GET request');
  }

  // 🌐 POST request
  Future<http.Response> post({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    bool authorized = false,
    int maxRetries = 2,
  }) async {
    final url = '$baseUrl$endpoint';
    final requestHeaders =
        await _buildHeaders(headers: headers, authorized: authorized);
    log('📡 POST $url');
    log('📤 Headers: $requestHeaders');
    log('📤 Body: ${jsonEncode(body)}');

    int retryCount = 0;
    while (retryCount <= maxRetries) {
      try {
        final response = await http
            .post(
              Uri.parse(url),
              headers: requestHeaders,
              body: jsonEncode(body),
            )
            .timeout(const Duration(seconds: 30)); // Increased timeout
        return response;
      } catch (e) {
        retryCount++;
        if (retryCount > maxRetries) {
          throw Exception(
              'Network request failed after $maxRetries retries: ${e.toString()}');
        }
        log('⚠️ Request failed, retrying (${retryCount}/$maxRetries)...');
        await Future.delayed(
            Duration(seconds: 2 * retryCount)); // Exponential backoff
      }
    }
    throw Exception('Unexpected error in POST request');
  }

  // 🌐 PUT request
  Future<http.Response> put({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    bool authorized = false,
    int maxRetries = 2,
  }) async {
    final url = '$baseUrl$endpoint';
    final requestHeaders =
        await _buildHeaders(headers: headers, authorized: authorized);
    log('📡 PUT $url');
    log('📤 Headers: $requestHeaders');
    log('📤 Body: ${jsonEncode(body)}');

    int retryCount = 0;
    while (retryCount <= maxRetries) {
      try {
        final response = await http
            .put(
              Uri.parse(url),
              headers: requestHeaders,
              body: jsonEncode(body),
            )
            .timeout(const Duration(seconds: 30)); // Increased timeout
        log('✅ Response [${response.statusCode}]: ${response.body}');
        return response;
      } catch (e) {
        retryCount++;
        if (retryCount > maxRetries) {
          log('❌ Network error after $maxRetries retries: ${e.toString()}');
          throw Exception(
              'Network PUT request failed after $maxRetries retries: ${e.toString()}');
        }
        log('⚠️ Request failed, retrying (${retryCount}/$maxRetries)...');
        await Future.delayed(
            Duration(seconds: 2 * retryCount)); // Exponential backoff
      }
    }
    throw Exception('Unexpected error in PUT request');
  }

  // 🛒 Load products from "Appliances" category
  Future<List<ProductCard>> loadProducts() async {
    try {
      // Fetch all products, no category filtering on backend
      final response = await http
          .get(Uri.parse('${baseUrl}products'))
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final products = data['data'] as List;

        final productCards = products
            .map((productData) {
              // Filter appliances locally
              if (productData['category'] != null &&
                  productData['category']['name'].toString().toLowerCase() !=
                      'appliances') {
                return null; // Skip non-appliance product
              }

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
                originalPrice:
                    (productData['originalPrice'] as num?)?.toDouble() ??
                        (productData['price'] as num).toDouble(),
                rating:
                    (productData['ratingsAverage'] as num?)?.toDouble() ?? 0.0,
                reviewCount: productData['ratingsQuantity'] ?? 0,
              );
            })
            .whereType<ProductCard>() // Remove nulls from filtering
            .toList();

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
    print('\n=== 📤 UPLOAD IMAGE REQUEST START ===');
    print('⬆️ uploadImage: Starting upload to $url');
    print('⬆️ uploadImage: File path: ${imageFile.path}');
    print('⬆️ uploadImage: File exists: ${await imageFile.exists()}');
    print('⬆️ uploadImage: File size: ${await imageFile.length()} bytes');

    // Get file extension and mime type
    final ext = imageFile.path.split('.').last.toLowerCase();
    final mimeType = _getMimeType(ext);
    print('⬆️ uploadImage: File extension: $ext, MIME type: $mimeType');

    try {
      final request = http.MultipartRequest('POST', url);

      // Get authorization token
      String? token;
      if (authorized) {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          token = await user.getIdToken(true);
          if (token != null && token.isNotEmpty) {
            request.headers['Authorization'] = 'Bearer $token';
            print(
                '🔐 Added authorization token: Bearer ${token.substring(0, 10)}...');
          } else {
            print('⚠️ No valid token available');
          }
        }
      }

      // Add fields if any
      if (fields != null) {
        request.fields.addAll(fields);
        print('📝 Added fields: $fields');
      }

      // Read file bytes
      final bytes = await imageFile.readAsBytes();
      print('📦 Read ${bytes.length} bytes from file');

      // Create multipart file with bytes
      final multipartFile = http.MultipartFile.fromBytes(
        'profileImg',
        bytes,
        filename: 'profile_${DateTime.now().millisecondsSinceEpoch}.$ext',
        contentType: MediaType.parse(mimeType),
      );
      request.files.add(multipartFile);
      print('📎 Added multipart file with field name "profileImg"');

      // Log request details
      print('\n=== 📤 REQUEST DETAILS ===');
      print('📤 Request URL: ${request.url}');
      print('📤 Request headers: ${request.headers}');
      print('📤 Request fields: ${request.fields}');
      print(
          '📤 Request files: ${request.files.map((f) => '${f.filename} (${f.contentType})').toList()}');

      // Send request with timeout
      print('\n=== 📤 SENDING REQUEST ===');
      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          print('⚠️ Request timed out after 30 seconds');
          throw TimeoutException('Request timed out after 30 seconds');
        },
      );

      // Get response body
      final responseBody = await streamedResponse.stream.bytesToString();

      print('\n=== 📥 RESPONSE DETAILS ===');
      print('📥 Response status code: ${streamedResponse.statusCode}');
      print('📥 Response headers: ${streamedResponse.headers}');
      print('📥 Raw response body: $responseBody');

      if (streamedResponse.statusCode != 200) {
        final errorData = jsonDecode(responseBody);
        final errorMessage = errorData['message'] ?? 'Unknown error';
        final errorDetails = errorData['error']?['stack'] ?? '';
        print('\n=== ❌ UPLOAD FAILED ===');
        print('❌ Error message: $errorMessage');
        print('❌ Error details: $errorDetails');
        throw Exception('Upload failed: $errorMessage');
      }

      print('\n=== ✅ UPLOAD SUCCESSFUL ===');
      // Create new response with reset stream
      return http.StreamedResponse(
        Stream.value(responseBody.codeUnits),
        streamedResponse.statusCode,
        headers: streamedResponse.headers,
        contentLength: responseBody.length,
        request: streamedResponse.request,
        isRedirect: streamedResponse.isRedirect,
        persistentConnection: streamedResponse.persistentConnection,
        reasonPhrase: streamedResponse.reasonPhrase,
      );
    } catch (e, stackTrace) {
      print('\n=== ⛔ UPLOAD EXCEPTION ===');
      print('⛔ Error: ${e.toString()}');
      print('⛔ Stack trace: $stackTrace');
      throw Exception('Error uploading image: ${e.toString()}');
    }
  }

  // Helper to get MIME type from file extension
  String _getMimeType(String extension) {
    switch (extension.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      default:
        throw Exception('Unsupported image format. Please use JPG or PNG.');
    }
  }

  // 🖼️ Pick image, upload it, then update user profile
  Future<String> uploadProfileImageAndUpdate(File imageFile) async {
    print('\n=== 💾 PROFILE IMAGE UPDATE START ===');
    try {
      // First check if the file exists and is readable
      if (!await imageFile.exists()) {
        throw Exception('Image file does not exist: ${imageFile.path}');
      }

      final fileSize = await imageFile.length();
      if (fileSize == 0) {
        throw Exception('Image file is empty: ${imageFile.path}');
      }

      print('💾 Image file size: $fileSize bytes');

      final uploadResponse = await uploadImage(
        endpoint: BackendEndpoints.uploadUserPhoto,
        imageFile: imageFile,
        authorized: true,
      );

      print('\n=== 💾 PROCESSING UPLOAD RESPONSE ===');
      print('💾 Upload response status code: ${uploadResponse.statusCode}');

      final responseString = await uploadResponse.stream.bytesToString();
      print('💾 Raw response string: $responseString');

      // Try to parse the response even if status code is not 200
      final responseData = jsonDecode(responseString);
      print('💾 Parsed response data: $responseData');

      // Get the profileImg from response (backend sends both profileImg and profileImgUrl)
      final uploadedFilename = responseData['profileImg'];
      print('💾 Extracted filename: $uploadedFilename');

      if (uploadedFilename == null) {
        print('\n=== ❌ NO FILENAME IN RESPONSE ===');
        print('❌ Full response data: $responseData');
        throw Exception(
            'Image uploaded but no filename returned. Response: $responseData');
      }

      // Use the profileImgUrl directly from the response
      final profileImageUrl = responseData['profileImgUrl'];
      if (profileImageUrl == null || profileImageUrl.isEmpty) {
        throw Exception('Backend did not return profileImgUrl');
      }
      print('💾 Using URL from backend: $profileImageUrl');

      print('\n=== 💾 UPDATING USER PROFILE ===');
      // Update profile with the filename only, not the full URL
      final updateResponse = await put(
        endpoint: BackendEndpoints.updateMe,
        body: {
          'profileImg': uploadedFilename
        }, // Using 'profileImg' to match backend
        authorized: true,
      );

      print('💾 Update profile response status: ${updateResponse.statusCode}');
      print('💾 Update profile response body: ${updateResponse.body}');

      if (updateResponse.statusCode != 200) {
        print('\n=== ❌ PROFILE UPDATE FAILED ===');
        print('❌ Status: ${updateResponse.statusCode}');
        print('❌ Error response: ${updateResponse.body}');
        throw Exception(
            'Failed to update user profile image: ${updateResponse.body}');
      }

      print('\n=== ✅ PROFILE UPDATE SUCCESSFUL ===');
      return profileImageUrl;
    } catch (e, stackTrace) {
      print('\n=== ⛔ PROFILE UPDATE EXCEPTION ===');
      print('⛔ Error: ${e.toString()}');
      print('⛔ Stack trace: $stackTrace');
      throw Exception('uploadProfileImageAndUpdate error: ${e.toString()}');
    } finally {
      print('\n=== 💾 PROFILE IMAGE UPDATE END ===\n');
    }
  }

  Future<List<ProductsViewsModel>> fetchProducts(String category) async {
    final url = Uri.parse('$baseUrl/products?category=$category');
    print('Fetching products from $url');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        print('Fetched ${jsonList.length} products');

        // Convert JSON list to List<Product>
        return jsonList
            .map((jsonItem) => ProductsViewsModel.fromJson(jsonItem))
            .toList();
      } else {
        print('Failed to fetch products. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  Future<List<ProductsViewsModel>> getProductsByCategory(
      String category) async {
    final url = Uri.parse('$baseUrl/api/v1/products?category=$category');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body)['data'];
      return jsonList.map((json) => ProductsViewsModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products: ${response.body}');
    }
  }
}
