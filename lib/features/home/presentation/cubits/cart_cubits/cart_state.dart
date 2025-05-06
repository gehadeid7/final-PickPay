part of 'cart_cubit.dart';

abstract class CartState {
  const CartState();
}

class CartInitial extends CartState {
  CartInitial();
}

class CartLoaded extends CartState {
  final List<CartItemModel> items;
  final CartAction? action;

  CartLoaded(this.items, {this.action});
}

enum CartAction { added, removed }
