// // lib/features/categories_pages/services/product_service.dart
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../models/product_model.dart'; // import the product model

// class ProductService {
//   // Fetch products from your backend API
//   Future<List<ProductsViewsModel>> fetchProducts() async {
//     final url =
//         'https://your-backend-endpoint/products'; // Replace with your actual API endpoint

//     try {
//       final response = await http.get(Uri.parse(url));

//       if (response.statusCode == 200) {
//         List<dynamic> data = json.decode(response.body);
//         return data
//             .map((productJson) => ProductsViewsModel.fromJson(productJson))
//             .toList();
//       } else {
//         throw Exception('Failed to load products');
//       }
//     } catch (e) {
//       throw Exception('Failed to load products: $e');
//     }
//   }
// }
