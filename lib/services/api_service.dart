import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pickpay/features/categories_pages/widgets/product_card.dart'; // Import ProductCard

class ApiService {
  // Fetch products from the API and return a list of ProductCard widgets
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
}
