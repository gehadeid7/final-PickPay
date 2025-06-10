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
      final productId = productData['_id'] ?? productData['id'];
      // Local mapping for productId to category if missing
      final Map<String, String> productCategoryMap = {
        // Example: '68252918a68b49cb06164210': 'appliances',
        // Add more mappings as needed
      };
      String? category = productData['category'];
      if ((category == null || category == 'unknown') && productId != null) {
        category = productCategoryMap[productId] ?? 'unknown';
      }
      if (productId == null) {
        throw Exception('Product ID is missing');
      }

      // Always use local asset path for image, ignore backend category
      // Example: assets/appliances/product{productId}/1.png
      // You can change 'appliances' to another default if needed
      String assetCategory = 'appliances'; // or any default category
      String assetProductId = productId.toString();
      String assetPath = 'assets/' + assetCategory + '/product' + assetProductId + '/1.png';
      List<String> imagePaths = [assetPath];

      final product = ProductsViewsModel.fromJson({
        ...productData,
        'id': productId,
        'title': productData['title'] ?? productData['name'] ?? 'Unnamed Product',
        'price': productData['price'] ?? 0.0,
        'imagePaths': imagePaths,
        'category': assetCategory,
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
