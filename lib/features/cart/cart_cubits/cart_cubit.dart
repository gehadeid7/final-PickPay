import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/services/shared_preferences_singletone.dart';
import 'package:pickpay/features/cart/cart_item_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  late final StreamSubscription<User?> _authSubscription;

  CartCubit() : super(CartLoaded([])) {
    // Listen to auth state changes
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        // User logged in - load their cart
        _loadCartData();
      } else {
        // User logged out - clear current cart
        emit(CartLoaded([]));
      }
    });
    // Initial load of cart data
    _loadCartData();
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }

  List<CartItemModel> get _items {
    if (state is CartLoaded) {
      return (state as CartLoaded).items;
    }
    return [];
  }

  String get _cartKey {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return ''; // Return empty if no user
    return '${kCartData}_${user.uid}';
  }

  // Load cart data from shared preferences
  Future<void> _loadCartData() async {
    try {
      final key = _cartKey;
      if (key.isEmpty) {
        emit(CartLoaded([]));
        return;
      }

      final cartJson = Prefs.getString(key);
      if (cartJson.isNotEmpty) {
        final List<dynamic> cartList = jsonDecode(cartJson);
        final items =
            cartList.map((item) => CartItemModel.fromJson(item)).toList();
        emit(CartLoaded(items));
      } else {
        emit(CartLoaded([]));
      }
    } catch (e) {
      print('Error loading cart data: $e');
      emit(CartLoaded([]));
    }
  }

  // Save cart data to shared preferences
  Future<void> _saveCartData(List<CartItemModel> items) async {
    try {
      final key = _cartKey;
      if (key.isEmpty) return; // Don't save if no user

      final cartList = items.map((item) => item.toJson()).toList();
      final cartJson = jsonEncode(cartList);
      await Prefs.setString(key, cartJson);
    } catch (e) {
      print('Error saving cart data: $e');
    }
  }

  void addToCart(CartItemModel newItem) {
    if (_cartKey.isEmpty) return; // Don't add if no user

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
    // Save cart data after modification
    _saveCartData(currentItems);
  }

  void removeFromCart(String productId) {
    if (_cartKey.isEmpty) return; // Don't remove if no user

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
    // Save cart data after modification
    _saveCartData(updatedItems);
  }

  void updateQuantity(String productId, int newQuantity) {
    if (_cartKey.isEmpty) return; // Don't update if no user

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
      // Save cart data after modification
      _saveCartData(updatedItems);
    }
  }

  void clearCart() {
    final key = _cartKey;
    if (key.isEmpty) return; // Don't clear if no user

    emit(CartLoaded([]));
    // Clear cart data from storage
    Prefs.remove(key);
  }
}
