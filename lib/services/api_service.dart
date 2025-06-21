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
  static const String baseUrl = 'http://192.168.1.8:3000/api/v1/';

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
        }
      } catch (e) {}
    }

    if (token.isEmpty) {
      token = Prefs.getString('jwt_token');
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
        return response;
      } catch (e) {
        retryCount++;
        if (retryCount > maxRetries) {
          throw Exception(
              'Network PUT request failed after $maxRetries retries: ${e.toString()}');
        }
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

    // Get file extension and mime type
    final ext = imageFile.path.split('.').last.toLowerCase();
    final mimeType = _getMimeType(ext);

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
          }
        }
      }

      // Add fields if any
      if (fields != null) {
        request.fields.addAll(fields);
      }

      // Read file bytes
      final bytes = await imageFile.readAsBytes();

      // Create multipart file with bytes
      final multipartFile = http.MultipartFile.fromBytes(
        'profileImg',
        bytes,
        filename: 'profile_${DateTime.now().millisecondsSinceEpoch}.$ext',
        contentType: MediaType.parse(mimeType),
      );
      request.files.add(multipartFile);

      // Send request with timeout
      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Request timed out after 30 seconds');
        },
      );

      // Get response body
      final responseBody = await streamedResponse.stream.bytesToString();

      if (streamedResponse.statusCode != 200) {
        final errorData = jsonDecode(responseBody);
        final errorMessage = errorData['message'] ?? 'Unknown error';
        final errorDetails = errorData['error']?['stack'] ?? '';
        throw Exception('Upload failed: $errorMessage');
      }

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
    try {
      // First check if the file exists and is readable
      if (!await imageFile.exists()) {
        throw Exception('Image file does not exist: ${imageFile.path}');
      }

      final fileSize = await imageFile.length();
      if (fileSize == 0) {
        throw Exception('Image file is empty: ${imageFile.path}');
      }

      final uploadResponse = await uploadImage(
        endpoint: BackendEndpoints.uploadUserPhoto,
        imageFile: imageFile,
        authorized: true,
      );

      final responseString = await uploadResponse.stream.bytesToString();

      // Try to parse the response even if status code is not 200
      final responseData = jsonDecode(responseString);

      // Get the profileImg from response (backend sends both profileImg and profileImgUrl)
      final uploadedFilename = responseData['profileImg'];

      if (uploadedFilename == null) {
        throw Exception(
            'Image uploaded but no filename returned. Response: $responseData');
      }

      // Use the profileImgUrl directly from the response
      final profileImageUrl = responseData['profileImgUrl'];
      if (profileImageUrl == null || profileImageUrl.isEmpty) {
        throw Exception('Backend did not return profileImgUrl');
      }

      // Update profile with the filename only, not the full URL
      final updateResponse = await put(
        endpoint: BackendEndpoints.updateMe,
        body: {
          'profileImg': uploadedFilename
        }, // Using 'profileImg' to match backend
        authorized: true,
      );

      if (updateResponse.statusCode != 200) {
        throw Exception(
            'Failed to update user profile image: ${updateResponse.body}');
      }

      return profileImageUrl;
    } catch (e, stackTrace) {
      throw Exception('uploadProfileImageAndUpdate error: ${e.toString()}');
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

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result is Map<String, dynamic>) {
          if (result.containsKey('products')) {
            if (result['products'] is List) {}
            return result['products']; // ✅ Return the actual list
          } else {
            throw Exception('Unexpected AI response format');
          }
        } else {
          throw Exception('Unexpected AI response format: not a JSON object');
        }
      } else {
        throw Exception('AI Search failed: ${response.body}');
      }
    } catch (e, stackTrace) {
      rethrow;
    }
  }

// 🔍 Unified Product Search Method
  Future<List<ProductsViewsModel>> searchProducts(String query) async {
    try {
      // Use POST method like your working searchProductsAI
      final response = await post(
        endpoint:
            BackendEndpoints.aiProductSearch, // Should be 'products/search'
        body: {
          'query': query,
          'type': 'search',
          'context': {'userHistory': [], 'popularSearches': []}
        },
        authorized: false,
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result is Map<String, dynamic>) {
          if (result.containsKey('products')) {
            final productsData = result['products'];

            if (productsData is List) {
              List<ProductsViewsModel> products = [];
              for (var productJson in productsData) {
                try {
                  if (productJson is Map<String, dynamic>) {
                    final product = ProductsViewsModel.fromJson(productJson);
                    products.add(product);
                  }
                } catch (parseError) {}
              }

              return products;
            } else {
              return [];
            }
          } else {
            return [];
          }
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e, stackTrace) {
      return [];
    }
  }

// 🔍 Search Suggestions Method
  Future<List<String>> getSearchSuggestions(String query) async {
    try {
      final response = await post(
        endpoint: BackendEndpoints.aiProductSearch,
        body: {
          'query': query,
          'type': 'suggestions', // Different type for suggestions
          'context': {'userHistory': [], 'popularSearches': []}
        },
        authorized: false,
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        if (result is Map<String, dynamic> && result.containsKey('products')) {
          final productsData = result['products'] as List;

          // Extract product titles as suggestions
          List<String> suggestions = [];
          for (var product in productsData) {
            if (product is Map<String, dynamic> &&
                product.containsKey('title')) {
              suggestions.add(product['title'].toString());
            }
          }

          return suggestions;
        }
      }

      return [];
    } catch (e) {
      return [];
    }
  }

// 🔍 Test method to debug backend response
  Future<Map<String, dynamic>> testSearchEndpoint(String query) async {
    try {
      final response = await post(
        endpoint: BackendEndpoints.aiProductSearch,
        body: {
          'query': query,
          'type': 'search',
          'context': {'userHistory': [], 'popularSearches': []}
        },
        authorized: false,
      );

      return {
        'statusCode': response.statusCode,
        'body': response.body,
        'success': response.statusCode == 200,
      };
    } catch (e) {
      return {
        'statusCode': 0,
        'body': e.toString(),
        'success': false,
      };
    }
  }

// Fetch products by category
  Future<List<ProductsViewsModel>> fetchProducts(String category) async {
    final url = Uri.parse('$baseUrl/products?category=$category');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList
            .map((jsonItem) => ProductsViewsModel.fromJson(jsonItem))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
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
      throw Exception('Error loading wishlist data: $e');
    }
  }

  // 🛒 Cart API Functions
  Future<Map<String, dynamic>> getCart() async {
    try {
      final response = await get(
        endpoint: BackendEndpoints.cart,
        authorized: true,
      );

      // Handle 404 as a valid empty cart state
      if (response.statusCode == 404) {
        return {
          'cartItems': [],
          'totalCartPrice': 0,
          'totalPriceAfterDiscount': 0,
        };
      }

      if (response.statusCode == 200) {
        // Handle empty response
        if (response.body.isEmpty || response.body == '-') {
          return {
            'cartItems': [],
            'totalCartPrice': 0,
            'totalPriceAfterDiscount': 0,
          };
        }

        final responseData = jsonDecode(response.body);
        if (responseData == null) {
          throw Exception('Invalid response format: null response');
        }

        // Handle direct cart items array
        if (responseData is List) {
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
              throw Exception('Invalid response format: null cart data');
            }

            if (!cartData.containsKey('cartItems')) {
              throw Exception(
                  'Invalid response format: missing cartItems field');
            }

            final cartItems = cartData['cartItems'];

            return cartData;
          } else if (responseData.containsKey('cartItems')) {
            return responseData;
          }
        }

        throw Exception('Unexpected response format');
      } else {
        throw Exception('Failed to get cart: ${response.body}');
      }
    } catch (e, stackTrace) {
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
      final body = {
        'productId': productId,
        'color': color,
      };

      final response = await post(
        endpoint: BackendEndpoints.cart,
        body: body,
        authorized: true,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to add item to cart: ${response.body}');
      }

      // Verify the item was added by getting the cart
      final cartData = await getCart();
      final cartItems = cartData['cartItems'] as List;
      final itemAdded = cartItems.any((item) =>
          item['product']?['_id'] == productId ||
          item['productId'] == productId);

      if (!itemAdded) {
        throw Exception('Item was not added to cart successfully');
      }
    } catch (e, stackTrace) {
      throw Exception('Error adding to cart: ${e.toString()}');
    }
  }

  Future<void> removeFromCart(String itemId) async {
    try {
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
        return;
      }

      final response = await http.delete(
        Uri.parse('$baseUrl${BackendEndpoints.removeCartItem(actualItemId)}'),
        headers: await _buildHeaders(authorized: true),
      );

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
          throw Exception('Item was not removed from cart successfully');
        }

        return;
      }

      // Handle 404 as success (item already removed)
      if (response.statusCode == 404) {
        return;
      }

      // Handle other error cases
      final errorMessage = jsonDecode(response.body)['message'] ??
          'Failed to remove item from cart';
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Error removing from cart: ${e.toString()}');
    }
  }

  Future<void> updateCartItemQuantity(String productId, int quantity) async {
    try {
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
        throw Exception('Cart item not found');
      }

      final response = await put(
        endpoint: BackendEndpoints.updateCartItem(cartItemId),
        body: {'quantity': quantity},
        authorized: true,
      );

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
    } catch (e) {
      throw Exception('Error updating cart item quantity: ${e.toString()}');
    }
  }

  Future<void> clearCart() async {
    try {
      final url = Uri.parse('$baseUrl${BackendEndpoints.cart}');

      final headers = await _buildHeaders(authorized: true);

      final response = await http.delete(url, headers: headers);

      if (response.statusCode == 204) {
        return;
      } else {
        throw Exception(
            'Failed to clear cart: ${response.statusCode} ${response.body}');
      }
    } catch (e, stackTrace) {
      throw Exception('Error clearing cart: ${e.toString()}');
    }
  }

  Future<double> applyCoupon(String couponCode) async {
    try {
      final response = await put(
        endpoint: BackendEndpoints.applyCoupon,
        body: {'coupon': couponCode},
        authorized: true,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to apply coupon: ${response.body}');
      }

      final decoded = jsonDecode(response.body);
      final data = decoded['data'];

      if (data == null) {
        throw Exception('No data in response');
      }

      final totalCartPrice = (data['totalCartPrice'] as num).toDouble();
      final totalPriceAfterDiscount =
          (data['totalPriceAfterDiscount'] as num?)?.toDouble();

      if (totalPriceAfterDiscount == null) {
        return 0.0; // لا يوجد خصم
      }

      final discount = totalCartPrice - totalPriceAfterDiscount;
      return discount;
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
        return null;
      } else {
        throw Exception('Failed to get product: ${response.body}');
      }
    } catch (e) {
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
      }
    } catch (e) {}
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

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode({'shippingAddress': shippingAddress}),
      );

      if (response.statusCode == 201) {
        final result = jsonDecode(response.body);
        return result['data'] ?? {};
      } else {
        throw Exception('Create cash order failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error creating cash order: ${e.toString()}');
    }
  }

  // ✅ Get Checkout Session
  Future<Map<String, dynamic>> getCheckoutSession(String cartId) async {
    final url =
        Uri.parse(baseUrl).resolve(BackendEndpoints.checkoutSession(cartId));

    try {
      final headers = await _buildHeaders(authorized: true);

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return result['session'] ?? {};
      } else {
        throw Exception('Checkout session failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error retrieving checkout session: ${e.toString()}');
    }
  }

  // ✅ Get All Orders
  Future<List<Map<String, dynamic>>> getAllOrders() async {
    final url = Uri.parse(baseUrl).resolve(BackendEndpoints.allOrders);

    try {
      final headers = await _buildHeaders(authorized: true);

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        final data = result['data'];
        if (data is List) {
          return List<Map<String, dynamic>>.from(data);
        }
        throw Exception('Unexpected order list format');
      } else {
        throw Exception('Failed to fetch orders: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching orders: ${e.toString()}');
    }
  }

  // ✅ Get Order Details
  Future<Map<String, dynamic>> getOrderDetails(String orderId) async {
    final url =
        Uri.parse(baseUrl).resolve(BackendEndpoints.specificOrder(orderId));

    try {
      final headers = await _buildHeaders(authorized: true);

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return result['data'] ?? {};
      } else {
        throw Exception('Failed to fetch order: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching order details: ${e.toString()}');
    }
  }

  // ✅ Mark as Paid
  Future<bool> markOrderAsPaid(String orderId) async {
    final url =
        Uri.parse(baseUrl).resolve(BackendEndpoints.markAsPaid(orderId));

    try {
      final headers = await _buildHeaders(authorized: true);

      final response = await http.put(url, headers: headers);

      if (response.statusCode == 200) {
        return true;
      }

      throw Exception('Mark as paid failed: ${response.body}');
    } catch (e) {
      throw Exception('Error marking order as paid: ${e.toString()}');
    }
  }

  // ✅ Mark as Delivered
  Future<bool> markOrderAsDelivered(String orderId) async {
    final url =
        Uri.parse(baseUrl).resolve(BackendEndpoints.markAsDelivered(orderId));

    try {
      final headers = await _buildHeaders(authorized: true);

      final response = await http.put(url, headers: headers);

      if (response.statusCode == 200) {
        return true;
      }

      throw Exception('Mark as delivered failed: ${response.body}');
    } catch (e) {
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

  Future<List<Map<String, dynamic>>> getReviewsByProduct(
      String productId) async {
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
    throw Exception('Failed to delete review: ${response.body}');
  }
}
