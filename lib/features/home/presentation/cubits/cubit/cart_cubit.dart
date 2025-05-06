import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/features/home/domain/models/cart_item_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartLoaded([])); // Start with empty cart

  List<CartItemModel> get _items {
    if (state is CartLoaded) {
      return (state as CartLoaded).items;
    }
    return [];
  }

  void addToCart(CartItemModel newItem) {
    final currentItems = List<CartItemModel>.from(_items); // Create fresh copy
    final index = currentItems
        .indexWhere((item) => item.product.id == newItem.product.id);

    if (index != -1) {
      // Product exists - update quantity
      final updatedItem = currentItems[index].copyWith(
        quantity: currentItems[index].quantity + newItem.quantity,
      );
      currentItems[index] = updatedItem;
    } else {
      // New product - add to cart
      currentItems.add(newItem);
    }

    // Emit new state with all items
    emit(CartLoaded(List<CartItemModel>.from(currentItems),
        action: CartAction.added));
  }

  void removeFromCart(String productId) {
    final updatedItems =
        _items.where((item) => item.product.id != productId).toList();
    emit(CartLoaded(updatedItems, action: CartAction.removed));
  }

  void updateQuantity(String productId, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(productId);
      return;
    }

    final currentItems = _items;
    final index =
        currentItems.indexWhere((item) => item.product.id == productId);

    if (index != -1) {
      final updatedItems = List<CartItemModel>.from(currentItems)
        ..[index] = currentItems[index].copyWith(quantity: newQuantity);
      emit(CartLoaded(updatedItems));
    }
  }

  void clearCart() {
    emit(CartLoaded([]));
  }
}
