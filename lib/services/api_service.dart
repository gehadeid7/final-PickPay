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
  static const String baseUrl = 'http://192.168.1.4:3000/api/v1/';

  Future<Map<String, String>> _buildHeaders({
    Map<String, String>? headers,
    bool authorized = false,
  }) async {
    final Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      ...?headers,
    };

    if (authorized) {
      String token = await _getFirebaseToken();
      if (token.isNotEmpty) {
        requestHeaders['Authorization'] = 'Bearer $token';
        log('🔐 Sending token in header: Bearer $token');
      } else {
        log('⚠️ No Firebase token found to send!');
      }
    }

    return requestHeaders;
  }

  // 🔐 Builds headers for multipart requests (no Content-Type)
  // ignore: unused_element
  Future<Map<String, String>> _buildMultipartHeaders({
    bool authorized = false,
  }) async {
    final Map<String, String> requestHeaders = {};

    if (authorized) {
      String token = await _getFirebaseToken();
      if (token.isNotEmpty) {
        requestHeaders['Authorization'] = 'Bearer $token';
        log('🔐 Sending token in header: Bearer $token');
      } else {
        log('⚠️ No Firebase token found to send!');
      }
    }

    return requestHeaders;
  }

  // 🔄 Helper to fetch fresh Firebase token or fallback to cache
  Future<String> _getFirebaseToken() async {
    String token = '';
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        token = await user.getIdToken(true) ?? '';
        if (token.isNotEmpty) {
          await Prefs.setString('jwt_token', token);
          log('🔐 Token refreshed and saved automatically');
        }
      } catch (e) {
        log('❌ Failed to refresh Firebase token: $e');
      }
    }

    if (token.isEmpty) {
      token = Prefs.getString('jwt_token');
      log('🔐 Using cached token from prefs');
    }

    return token;
  }

  // 🌐 GET request
  Future<http.Response> get({
    required String endpoint,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
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
    log('🔍 Endpoint raw value: "$endpoint"'); // <-- أضف هذا السطر لفحص endpoint

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

// Load products
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
                category: productData['category']?['name']?.toString(),
              );
            })
            .where((card) => card != null) // Remove nulls from filtering
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
    String? gender,
    String? dob,
    int? age,
    String? address,
    String? phone,
  }) async {
    try {
      final headers = await _buildHeaders(authorized: true);

      final body = {
        'name': name,
        'email': email,
        'uid': firebaseUid,
        'profileImg': photoUrl,
        'gender': gender,
        'dob': dob,
        'age': age,
        'address': address,
        'phone': phone,
      };

      // ازالة القيم null حتى لا ترسل في البودي
      body.removeWhere((key, value) => value == null);

      final response = await http.post(
        Uri.parse('${baseUrl}auth/firebase/sync'),
        headers: headers,
        body: jsonEncode(body),
      );

      log('🔄 syncFirebaseUserToBackend response status: ${response.statusCode}');
      log('🔄 syncFirebaseUserToBackend response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        return UserModel.fromJson(data);
      } else {
        throw Exception('Failed to sync Firebase user: ${response.body}');
      }
    } catch (e) {
      log('❌ Error syncing Firebase user: $e');
      throw Exception('Error syncing Firebase user: ${e.toString()}');
    }
  }

  // Forgot password
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

  // Reset password
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

  // Token management
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

  // Upload image to server (used for profile image)
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

  // Pick image, upload it, then update user profile
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

  // 🔍 AI Product Search
  Future<List<dynamic>> searchProductsAI(String query) async {
    try {
      final response = await post(
        endpoint: BackendEndpoints.aiProductSearch,
        body: {'query': query},
        authorized: false,
      );

      print('📥 Response status code: ${response.statusCode}');
      print('📥 Response body: ${response.body}');

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print('📦 Parsed response type: ${result.runtimeType}');
        if (result is Map<String, dynamic>) {
          print('📦 Response keys: ${result.keys.toList()}');
          if (result.containsKey('products')) {
            print('📦 products field type: ${result['products'].runtimeType}');
            if (result['products'] is List) {
              print(
                  '📦 Number of products: ${(result['products'] as List).length}');
            }
            return result['products']; // ✅ Return the actual list
          } else {
            print('⚠️ Warning: "products" key not found in response.');
            throw Exception('Unexpected AI response format');
          }
        } else {
          throw Exception('Unexpected AI response format: not a JSON object');
        }
      } else {
        print('❌ AI Search failed with status: ${response.statusCode}');
        throw Exception('AI Search failed: ${response.body}');
      }
    } catch (e, stackTrace) {
      print('❌ Error during AI product search: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    try {
      final response = await get(
        endpoint: BackendEndpoints.aiProductSearch, // 'products/search'
        queryParameters: {'query': query}, // <-- changed 'q' to 'query'
        authorized: false,
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        // Adjust this depending on your backend's response structure
        if (result is Map<String, dynamic> && result.containsKey('data')) {
          final data = result['data'];
          if (data is List) {
            return List<Map<String, dynamic>>.from(data);
          }
        } else if (result is List) {
          return List<Map<String, dynamic>>.from(result);
        }
        throw Exception('Unexpected search response format');
      } else {
        throw Exception('Search failed: [${response.body}]');
      }
    } catch (e) {
      throw Exception('Error during product search: ${e.toString()}');
    }
  }

// Fetch products by category
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

  // إضافة منتج إلى قائمة الرغبات
  Future<http.Response> addProductToWishlist(String productId) async {
    final uri = Uri.parse('$baseUrl${BackendEndpoints.wishlist}');
    final headers = await _buildHeaders(authorized: true);
    final body = jsonEncode({'productId': productId});

    final response = await http.post(uri, headers: headers, body: body);
    return response;
  }

  // حذف منتج من قائمة الرغبات
  Future<http.Response> removeProductFromWishlist(String productId) async {
    final uri =
        Uri.parse('$baseUrl${BackendEndpoints.removeFromWishlist(productId)}');
    final headers = await _buildHeaders(authorized: true);

    final response = await http.delete(uri, headers: headers);
    return response;
  }

  // جلب قائمة الرغبات للمستخدم الحالي
  Future<List<dynamic>> getLoggedUserWishlist() async {
    try {
      final uri = Uri.parse('$baseUrl${BackendEndpoints.wishlist}');
      final headers = await _buildHeaders(authorized: true);

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Handle different response formats
        if (responseData is Map<String, dynamic>) {
          if (responseData.containsKey('data')) {
            final data = responseData['data'];
            if (data is List) {
              return data;
            } else if (data is Map) {
              return [data];
            }
          } else if (responseData.containsKey('wishlist')) {
            final wishlist = responseData['wishlist'];
            if (wishlist is List) {
              return wishlist;
            } else if (wishlist is Map) {
              return [wishlist];
            }
          }
          return [];
        } else if (responseData is List) {
          return responseData;
        }

        return [];
      } else if (response.statusCode == 404) {
        // Return empty list for no wishlist
        return [];
      } else {
        throw Exception('Failed to fetch wishlist: ${response.statusCode}');
      }
    } catch (e) {
      log('Error loading wishlist data: $e', name: 'ApiService', error: e);
      throw Exception('Error loading wishlist data: $e');
    }
  }

  // 🛒 Cart API Functions
  Future<Map<String, dynamic>> getCart() async {
    try {
      log('🛒 Getting cart data...', name: 'ApiService');
      final response = await get(
        endpoint: BackendEndpoints.cart,
        authorized: true,
      );

      log('🛒 Cart response status: ${response.statusCode}',
          name: 'ApiService');
      log('🛒 Cart response body: ${response.body}', name: 'ApiService');

      // Handle 404 as a valid empty cart state
      if (response.statusCode == 404) {
        log('ℹ️ No cart exists for user, returning empty cart',
            name: 'ApiService');
        return {
          'cartItems': [],
          'totalCartPrice': 0,
          'totalPriceAfterDiscount': 0,
        };
      }

      if (response.statusCode == 200) {
        // Handle empty response
        if (response.body.isEmpty || response.body == '-') {
          log('ℹ️ Empty cart response, returning empty cart',
              name: 'ApiService');
          return {
            'cartItems': [],
            'totalCartPrice': 0,
            'totalPriceAfterDiscount': 0,
          };
        }

        final responseData = jsonDecode(response.body);
        if (responseData == null) {
          log('❌ Invalid response format: null response', name: 'ApiService');
          throw Exception('Invalid response format: null response');
        }

        // Handle direct cart items array
        if (responseData is List) {
          log('ℹ️ Response is a list of cart items', name: 'ApiService');
          return {
            'cartItems': responseData,
            'totalCartPrice': 0,
            'totalPriceAfterDiscount': 0,
          };
        }

        // Handle data wrapper
        if (responseData is Map<String, dynamic>) {
          if (responseData.containsKey('data')) {
            final cartData = responseData['data'];
            if (cartData == null) {
              log('❌ Invalid response format: null cart data',
                  name: 'ApiService');
              throw Exception('Invalid response format: null cart data');
            }

            if (!cartData.containsKey('cartItems')) {
              log('❌ Invalid response format: missing cartItems field',
                  name: 'ApiService');
              throw Exception(
                  'Invalid response format: missing cartItems field');
            }

            final cartItems = cartData['cartItems'];
            log('🛒 Found ${cartItems.length} items in cart',
                name: 'ApiService');
            log('🛒 Cart items: $cartItems', name: 'ApiService');

            return cartData;
          } else if (responseData.containsKey('cartItems')) {
            log('ℹ️ Response contains direct cartItems field',
                name: 'ApiService');
            return responseData;
          }
        }

        log('❌ Unexpected response format: $responseData', name: 'ApiService');
        throw Exception('Unexpected response format');
      } else {
        log('❌ Failed to get cart: ${response.body}', name: 'ApiService');
        throw Exception('Failed to get cart: ${response.body}');
      }
    } catch (e, stackTrace) {
      log('❌ Error getting cart: $e\n$stackTrace',
          name: 'ApiService', error: e);
      // If it's a 404 error, return empty cart
      if (e.toString().contains('404')) {
        return {
          'cartItems': [],
          'totalCartPrice': 0,
          'totalPriceAfterDiscount': 0,
        };
      }
      throw Exception('Error getting cart: ${e.toString()}');
    }
  }

  Future<void> addToCart(String productId, String color) async {
    try {
      log('🛒 Adding product to cart: productId=$productId, color=$color',
          name: 'ApiService');

      final body = {
        'productId': productId,
        'color': color,
      };

      log('🛒 Add to cart request body: $body', name: 'ApiService');

      final response = await post(
        endpoint: BackendEndpoints.cart,
        body: body,
        authorized: true,
      );

      log('🛒 Add to cart response status: ${response.statusCode}',
          name: 'ApiService');
      log('🛒 Add to cart response body: ${response.body}', name: 'ApiService');

      if (response.statusCode != 200) {
        log('❌ Failed to add item to cart: ${response.body}',
            name: 'ApiService');
        throw Exception('Failed to add item to cart: ${response.body}');
      }

      // Verify the item was added by getting the cart
      final cartData = await getCart();
      final cartItems = cartData['cartItems'] as List;
      final itemAdded = cartItems.any((item) =>
          item['product']?['_id'] == productId ||
          item['productId'] == productId);

      if (!itemAdded) {
        log('⚠️ Item was not found in cart after adding', name: 'ApiService');
        throw Exception('Item was not added to cart successfully');
      }

      log('✅ Successfully added product to cart', name: 'ApiService');
    } catch (e, stackTrace) {
      log('❌ Error adding to cart: $e\n$stackTrace',
          name: 'ApiService', error: e);
      throw Exception('Error adding to cart: ${e.toString()}');
    }
  }

  Future<void> removeFromCart(String itemId) async {
    try {
      log('🛒 Removing item from cart: $itemId', name: 'ApiService');

      // First check if item exists in cart
      final cartData = await getCart();
      final cartItems = cartData['cartItems'] as List;

      // Find the actual cart item ID
      String? actualItemId;
      for (var item in cartItems) {
        if (item['_id'] == itemId ||
            item['id'] == itemId ||
            item['product']?['_id'] == itemId ||
            item['productId'] == itemId) {
          actualItemId = item['_id'];
          break;
        }
      }

      if (actualItemId == null) {
        log('ℹ️ Item not found in cart, treating as success',
            name: 'ApiService');
        return;
      }

      final response = await http.delete(
        Uri.parse('$baseUrl${BackendEndpoints.removeCartItem(actualItemId)}'),
        headers: await _buildHeaders(authorized: true),
      );

      log('🛒 Remove from cart response status: ${response.statusCode}',
          name: 'ApiService');
      log('🛒 Remove from cart response body: ${response.body}',
          name: 'ApiService');

      // Handle both 200 and 204 as success
      if (response.statusCode == 200 || response.statusCode == 204) {
        // Verify the item was actually removed
        final updatedCartData = await getCart();
        final updatedCartItems = updatedCartData['cartItems'] as List;

        // Check if the item still exists using all possible ID formats
        final itemStillExists = updatedCartItems.any((item) =>
            item['_id'] == actualItemId ||
            item['id'] == actualItemId ||
            item['product']?['_id'] == itemId ||
            item['productId'] == itemId);

        if (itemStillExists) {
          log('⚠️ Item still exists in cart after removal attempt',
              name: 'ApiService');
          throw Exception('Item was not removed from cart successfully');
        }

        log('✅ Successfully removed item from cart', name: 'ApiService');
        return;
      }

      // Handle 404 as success (item already removed)
      if (response.statusCode == 404) {
        log('ℹ️ Item not found in cart (already removed)', name: 'ApiService');
        return;
      }

      // Handle other error cases
      final errorMessage = jsonDecode(response.body)['message'] ??
          'Failed to remove item from cart';
      throw Exception(errorMessage);
    } catch (e) {
      log('❌ Error removing from cart: $e', name: 'ApiService', error: e);
      throw Exception('Error removing from cart: ${e.toString()}');
    }
  }

  Future<void> updateCartItemQuantity(String productId, int quantity) async {
    try {
      log('🛒 Updating cart item quantity: productId=$productId, quantity=$quantity',
          name: 'ApiService');

      // First get the cart to find the actual cart item ID
      final cartData = await getCart();
      final cartItems = cartData['cartItems'] as List;

      // Find the actual cart item ID
      String? cartItemId;
      for (var item in cartItems) {
        if (item['product']?['_id'] == productId ||
            item['productId'] == productId) {
          cartItemId = item['_id'];
          break;
        }
      }

      if (cartItemId == null) {
        log('⚠️ Cart item not found for product: $productId',
            name: 'ApiService');
        throw Exception('Cart item not found');
      }

      final response = await put(
        endpoint: BackendEndpoints.updateCartItem(cartItemId),
        body: {'quantity': quantity},
        authorized: true,
      );

      log('🛒 Update quantity response status: ${response.statusCode}',
          name: 'ApiService');
      log('🛒 Update quantity response body: ${response.body}',
          name: 'ApiService');

      if (response.statusCode != 200) {
        final errorMessage = jsonDecode(response.body)['message'] ??
            'Failed to update cart item quantity';
        throw Exception(errorMessage);
      }

      // Verify the update was successful
      final updatedCartData = await getCart();
      final updatedCartItems = updatedCartData['cartItems'] as List;
      final updatedItem = updatedCartItems.firstWhere(
        (item) => item['_id'] == cartItemId,
        orElse: () => null,
      );

      if (updatedItem == null || updatedItem['quantity'] != quantity) {
        throw Exception('Failed to verify quantity update');
      }

      log('✅ Successfully updated cart item quantity', name: 'ApiService');
    } catch (e) {
      log('❌ Error updating cart item quantity: $e',
          name: 'ApiService', error: e);
      throw Exception('Error updating cart item quantity: ${e.toString()}');
    }
  }

  Future<void> clearCart() async {
    try {
      print('clearCart: Starting DELETE request to clear cart.');

      final url = Uri.parse('$baseUrl${BackendEndpoints.cart}');
      print('clearCart: URL = $url');

      final headers = await _buildHeaders(authorized: true);
      print('clearCart: Headers = $headers');

      final response = await http.delete(url, headers: headers);

      print('clearCart: Response status code = ${response.statusCode}');
      print('clearCart: Response body = ${response.body}');

      if (response.statusCode == 204) {
        print('clearCart: Cart cleared successfully.');
        return;
      } else {
        print('clearCart: Failed to clear cart. Throwing exception.');
        throw Exception(
            'Failed to clear cart: ${response.statusCode} ${response.body}');
      }
    } catch (e, stackTrace) {
      print('clearCart: Exception caught - ${e.toString()}');
      print('clearCart: Stack trace:\n$stackTrace');
      throw Exception('Error clearing cart: ${e.toString()}');
    }
  }

  Future<void> applyCoupon(String couponCode) async {
    try {
      final response = await put(
        endpoint: BackendEndpoints.applyCoupon,
        body: {'coupon': couponCode},
        authorized: true,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to apply coupon: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error applying coupon: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>?> getProductById(String id) async {
    try {
      final response = await get(
        endpoint: BackendEndpoints.getProductById(id),
        authorized: true,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is Map && data.containsKey('data')) {
          return data['data'];
        }
        return data;
      } else if (response.statusCode == 404) {
        log('Product not found: $id', name: 'ApiService');
        return null;
      } else {
        log('Error getting product: ${response.statusCode} - ${response.body}',
            name: 'ApiService');
        throw Exception('Failed to get product: ${response.body}');
      }
    } catch (e) {
      log('Error in getProductById: $e', name: 'ApiService', error: e);
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> processVoiceSearch(
      String voiceText) async {
    try {
      final url = Uri.parse(baseUrl).resolve('voice-search');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'text': voiceText,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = data['results'];

        if (results is List) {
          return results.whereType<Map<String, dynamic>>().toList();
        }
      } else {
        print('Voice search API error: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Voice search network error: $e');
    }
    return [];
  }

  // ✅ Create Cash Order
  Future<Map<String, dynamic>> createCashOrder(
    String cartId,
    Map<String, dynamic> shippingAddress,
  ) async {
    final url =
        Uri.parse(baseUrl).resolve(BackendEndpoints.createCashOrder(cartId));

    try {
      final headers = await _buildHeaders(authorized: true);

      print('\n🟡 [CREATE ORDER] Sending request...');
      print('➡️ POST $url');
      print('🧾 Headers: $headers');
      print('📦 Body: ${jsonEncode({'shippingAddress': shippingAddress})}');

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode({'shippingAddress': shippingAddress}),
      );

      print('📬 Status Code: ${response.statusCode}');
      print('📨 Response: ${response.body}');

      if (response.statusCode == 201) {
        final result = jsonDecode(response.body);
        print('✅ [CREATE ORDER] Success: ${result['data']}');
        return result['data'] ?? {};
      } else {
        print('❌ [CREATE ORDER] Failed: ${response.body}');
        throw Exception('Create cash order failed: ${response.body}');
      }
    } catch (e) {
      print('🔥 [CREATE ORDER] Error: $e');
      throw Exception('Error creating cash order: ${e.toString()}');
    }
  }

  // ✅ Get Checkout Session
  Future<Map<String, dynamic>> getCheckoutSession(String cartId) async {
    final url =
        Uri.parse(baseUrl).resolve(BackendEndpoints.checkoutSession(cartId));

    try {
      final headers = await _buildHeaders(authorized: true);

      print('\n🟡 [CHECKOUT SESSION] Getting session...');
      print('➡️ GET $url');
      print('🧾 Headers: $headers');

      final response = await http.get(url, headers: headers);

      print('📬 Status Code: ${response.statusCode}');
      print('📨 Response: ${response.body}');

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print('✅ [CHECKOUT SESSION] Success');
        return result['session'] ?? {};
      } else {
        print('❌ [CHECKOUT SESSION] Failed: ${response.body}');
        throw Exception('Checkout session failed: ${response.body}');
      }
    } catch (e) {
      print('🔥 [CHECKOUT SESSION] Error: $e');
      throw Exception('Error retrieving checkout session: ${e.toString()}');
    }
  }

  // ✅ Get All Orders
  Future<List<Map<String, dynamic>>> getAllOrders() async {
    final url = Uri.parse(baseUrl).resolve(BackendEndpoints.allOrders);

    try {
      final headers = await _buildHeaders(authorized: true);

      print('\n🟡 [GET ALL ORDERS] Fetching...');
      print('➡️ GET $url');
      print('🧾 Headers: $headers');

      final response = await http.get(url, headers: headers);

      print('📬 Status Code: ${response.statusCode}');
      print('📨 Response: ${response.body}');

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print('✅ [GET ALL ORDERS] Success');
        final data = result['data'];
        if (data is List) {
          return List<Map<String, dynamic>>.from(data);
        }
        throw Exception('Unexpected order list format');
      } else {
        print('❌ [GET ALL ORDERS] Failed: ${response.body}');
        throw Exception('Failed to fetch orders: ${response.body}');
      }
    } catch (e) {
      print('🔥 [GET ALL ORDERS] Error: $e');
      throw Exception('Error fetching orders: ${e.toString()}');
    }
  }

  // ✅ Get Order Details
  Future<Map<String, dynamic>> getOrderDetails(String orderId) async {
    final url =
        Uri.parse(baseUrl).resolve(BackendEndpoints.specificOrder(orderId));

    try {
      final headers = await _buildHeaders(authorized: true);

      print('\n🟡 [ORDER DETAILS] Fetching...');
      print('➡️ GET $url');
      print('🧾 Headers: $headers');

      final response = await http.get(url, headers: headers);

      print('📬 Status Code: ${response.statusCode}');
      print('📨 Response: ${response.body}');

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print('✅ [ORDER DETAILS] Success');
        return result['data'] ?? {};
      } else {
        print('❌ [ORDER DETAILS] Failed: ${response.body}');
        throw Exception('Failed to fetch order: ${response.body}');
      }
    } catch (e) {
      print('🔥 [ORDER DETAILS] Error: $e');
      throw Exception('Error fetching order details: ${e.toString()}');
    }
  }

  // ✅ Mark as Paid
  Future<bool> markOrderAsPaid(String orderId) async {
    final url =
        Uri.parse(baseUrl).resolve(BackendEndpoints.markAsPaid(orderId));

    try {
      final headers = await _buildHeaders(authorized: true);

      print('\n🟡 [MARK AS PAID] Updating...');
      print('➡️ PUT $url');
      print('🧾 Headers: $headers');

      final response = await http.put(url, headers: headers);

      print('📬 Status Code: ${response.statusCode}');
      print('📨 Response: ${response.body}');

      if (response.statusCode == 200) {
        print('✅ [MARK AS PAID] Success');
        return true;
      }

      print('❌ [MARK AS PAID] Failed: ${response.body}');
      throw Exception('Mark as paid failed: ${response.body}');
    } catch (e) {
      print('🔥 [MARK AS PAID] Error: $e');
      throw Exception('Error marking order as paid: ${e.toString()}');
    }
  }

  // ✅ Mark as Delivered
  Future<bool> markOrderAsDelivered(String orderId) async {
    final url =
        Uri.parse(baseUrl).resolve(BackendEndpoints.markAsDelivered(orderId));

    try {
      final headers = await _buildHeaders(authorized: true);

      print('\n🟡 [MARK AS DELIVERED] Updating...');
      print('➡️ PUT $url');
      print('🧾 Headers: $headers');

      final response = await http.put(url, headers: headers);

      print('📬 Status Code: ${response.statusCode}');
      print('📨 Response: ${response.body}');

      if (response.statusCode == 200) {
        print('✅ [MARK AS DELIVERED] Success');
        return true;
      }

      print('❌ [MARK AS DELIVERED] Failed: ${response.body}');
      throw Exception('Mark as delivered failed: ${response.body}');
    } catch (e) {
      print('🔥 [MARK AS DELIVERED] Error: $e');
      throw Exception('Error marking order as delivered: ${e.toString()}');
    }
  }
  Future<http.Response> createReview({
  required String productId,
  required double rating,
  required String review,
}) async {
  return await post(
    endpoint: BackendEndpoints.getReviewsByProduct(productId),
    body: {
      'ratings': rating, 
      'content': review, 
      'product': productId,
    },
    authorized: true,
  );
}
Future<List<Map<String, dynamic>>> getReviewsByProduct(String productId) async {
  final response = await get(
    endpoint: BackendEndpoints.getReviewsByProduct(productId),
    authorized: false,
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return List<Map<String, dynamic>>.from(data['data']);
  } else {
    throw Exception('Failed to fetch reviews: ${response.body}');
  }
}
Future<http.Response> updateReview({
  required String reviewId,
  double? rating,
  String? review,
}) async {
  final Map<String, dynamic> body = {};
  if (rating != null) body['rating'] = rating;
  if (review != null) body['review'] = review;

  return await put(
    endpoint: BackendEndpoints.updateReview(reviewId),
    body: body,
    authorized: true,
  );
}
Future<http.Response> deleteReview(String reviewId) async {
  if (reviewId.isEmpty) {
    throw Exception('Review ID is missing');
  }
  final url = '$baseUrl${BackendEndpoints.deleteReview(reviewId)}';
  final headers = await _buildHeaders(authorized: true);
  final response = await http.delete(Uri.parse(url), headers: headers);

  if (response.statusCode == 204) return response;
  // Log the URL and response for debugging
  print('❌ DELETE $url');
  print('❌ Response [${response.statusCode}]: ${response.body}');
  throw Exception('Failed to delete review: ${response.body}');
}
}
