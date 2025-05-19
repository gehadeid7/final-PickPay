import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pickpay/features/cart/cart_item_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartLoaded([]));

  List<CartItemModel> get _items {
    if (state is CartLoaded) {
      return (state as CartLoaded).items;
    }
    return [];
  }

  void addToCart(CartItemModel newItem) {
    final currentItems = List<CartItemModel>.from(_items);
    final index = currentItems.indexWhere(
      (item) => item.product.id == newItem.product.id,
    );

    if (index != -1) {
      // Product exists - update quantity
      final updatedItem = currentItems[index].copyWith(
        quantity: currentItems[index].quantity + newItem.quantity,
      );
      currentItems[index] = updatedItem;
      emit(CartLoaded(
        List.from(currentItems),
        action: CartAction.updated,
        updatedItem: updatedItem,
      ));
    } else {
      // New product - add to cart
      currentItems.add(newItem);
      emit(CartLoaded(
        List.from(currentItems),
        action: CartAction.added,
        addedItem: newItem,
      ));
    }
  }

  void removeFromCart(String productId) {
    final currentItems = List<CartItemModel>.from(_items);
    final removedItem = currentItems.firstWhere(
      (item) => item.product.id == productId,
      orElse: () => throw Exception('Item not found'),
    );

    final updatedItems =
        currentItems.where((item) => item.product.id != productId).toList();
    emit(CartLoaded(
      updatedItems,
      action: CartAction.removed,
      removedItem: removedItem,
    ));
  }

  void updateQuantity(String productId, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(productId);
      return;
    }

    final currentItems = List<CartItemModel>.from(_items);
    final index = currentItems.indexWhere(
      (item) => item.product.id == productId,
    );

    if (index != -1) {
      final updatedItem = currentItems[index].copyWith(
        quantity: newQuantity,
      );
      final updatedItems = List<CartItemModel>.from(currentItems)
        ..[index] = updatedItem;
      emit(CartLoaded(
        updatedItems,
        action: CartAction.updated,
        updatedItem: updatedItem,
      ));
    }
  }

  void clearCart() {
    emit(CartLoaded([]));
  }
}
