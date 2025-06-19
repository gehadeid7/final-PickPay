part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartError extends CartState {
  final String message;
  final CartAction? action;

  const CartError(this.message, {this.action});

  @override
  List<Object?> get props => [message, action];
}

class CartLoaded extends CartState {
  final List<CartItemModel> cartItems;
  final CartAction? action;
  final String? cartId;
  final CartItemModel? updatedItem;
  final String? message;
 final double discount;
 
  const CartLoaded(
    this.cartItems, {
    this.action,
    this.updatedItem,
    this.message,
    this.cartId,
    this.discount = 0.0,
    });

  @override
  List<Object?> get props => [
        cartItems,
        action,
        updatedItem,
        message,
        cartId,
      ];
}

enum CartAction { added, removed, updated, error }
