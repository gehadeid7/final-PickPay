import 'package:pickpay/features/categories_pages/models/product_model.dart';

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
      'product': product.toJson(), // Make sure ProductsViewsModel has toJson()
      'quantity': quantity,
    };
  }

  // Create CartItemModel from JSON
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      product: ProductsViewsModel.fromJson(
          json['product']), // Make sure ProductsViewsModel has fromJson()
      quantity: json['quantity'],
    );
  }
}
