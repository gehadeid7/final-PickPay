import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'dart:developer' as dev;

class CartItemModel {
  final ProductsViewsModel product;
  final int quantity;

  CartItemModel({
    required this.product,
    required this.quantity,
  });

  CartItemModel copyWith({int? quantity}) {
    return CartItemModel(
      product: product,
      quantity: quantity ?? this.quantity,
    );
  }

  // Convert CartItemModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
    };
  }

  // Create CartItemModel from JSON
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    try {
      if (json == null) {
        throw Exception('Cart item data is null');
      }

      // Handle both cart item and product formats
      final productData = json['product'] ?? json;
      if (productData == null) {
        throw Exception('Product data is null');
      }

      // Get quantity from cart item or default to 1
      final quantity = json['quantity'] ?? 1;
      if (quantity == null) {
        throw Exception('Quantity is null');
      }

      // Ensure product data has required fields
      if (productData['_id'] == null && productData['id'] == null) {
        throw Exception('Product ID is missing');
      }

      // Create product model from the data
      // Ensure imagePaths is always null if no image is available
      List<String>? imagePaths;
      if (productData['images'] != null) {
        if (productData['images'] is List) {
          imagePaths = (productData['images'] as List)
              .where((img) => img != null && img.toString().isNotEmpty)
              .map((img) => img.toString())
              .toList();
        } else if (productData['images'] is String && productData['images'].toString().isNotEmpty) {
          imagePaths = [productData['images'].toString()];
        }
      }
      if ((imagePaths == null || imagePaths.isEmpty || (imagePaths.length == 1 && imagePaths[0].isEmpty)) && productData['imageCover'] != null && productData['imageCover'].toString().isNotEmpty) {
        imagePaths = [productData['imageCover'].toString()];
      }
      if (imagePaths == null || imagePaths.isEmpty || (imagePaths.length == 1 && imagePaths[0].isEmpty)) {
        imagePaths = null; // Let the UI handle the placeholder
      }

      final product = ProductsViewsModel.fromJson({
        ...productData,
        'id': productData['_id'] ?? productData['id'],
        'title': productData['title'] ?? productData['name'] ?? 'Unnamed Product',
        'price': productData['price'] ?? 0.0,
        'imagePaths': imagePaths,
        'category': productData['category'],
        'subcategory': productData['subcategory'],
        'brand': productData['brand'],
        'color': productData['color'],
        'aboutThisItem': productData['aboutThisItem'],
        'deliveryDate': productData['deliveryDate'],
        'deliveryTimeLeft': productData['deliveryTimeLeft'],
        'deliveryLocation': productData['deliveryLocation'],
        'inStock': productData['inStock'],
        'shipsFrom': productData['shipsFrom'],
        'soldBy': productData['soldBy'],
      });

      return CartItemModel(
        product: product,
        quantity: quantity is int ? quantity : int.parse(quantity.toString()),
      );
    } catch (e, stackTrace) {
      dev.log('Error creating CartItemModel: $e\n$stackTrace', name: 'CartItemModel', error: e);
      rethrow;
    }
  }
}
