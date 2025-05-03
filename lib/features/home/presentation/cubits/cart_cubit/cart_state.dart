import 'package:pickpay/features/home/domain/models/cart_item_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemModel> items;

  CartLoaded({required this.items});

  CartLoaded copyWith({List<CartItemModel>? items}) {
    return CartLoaded(items: items ?? this.items);
  }
}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}
