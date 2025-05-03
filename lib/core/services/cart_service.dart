import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io'; // Import for Platform check

class CartService {
  // Dynamically determine the base URL based on the platform
  static String getBaseUrl() {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:3000/api/v1/cart'; // Android Emulator
    } else if (Platform.isIOS) {
      return 'http://localhost:3000/api/v1/cart'; // iOS Simulator
    } else {
      return 'http://192.168.1.4:3000/api/v1/cart'; // Replace with your local IP
    }
  }

  // Add product to cart
  static Future<List<dynamic>> addToCart(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return []; // If no token, return an empty list

    final baseUrl = getBaseUrl(); // Get the correct base URL

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'productId': productId}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        // Assuming the response body returns the updated cart items
        final List<dynamic> updatedItems = jsonDecode(response.body);
        return updatedItems; // Return the updated cart items
      } catch (e) {
        print("Error decoding response: $e");
        return [];
      }
    } else {
      print("Failed to add to cart: ${response.body}");
      return [];
    }
  }
}
