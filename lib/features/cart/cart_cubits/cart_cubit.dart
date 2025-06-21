import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pickpay/features/cart/cart_item_model.dart';
import 'package:pickpay/services/api_service.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final ApiService _apiService;
  final _messageController = StreamController<String>.broadcast();
  bool _isOperationInProgress = false;
  final Map<String, ProductsViewsModel> _productCache = {};
  final Map<String, Completer<void>> _pendingOperations = {};
  final Map<String, CartItemModel> _cartItemCache = {};
  bool _isSyncing = false;

  CartCubit()
      : _apiService = ApiService(),
        super(CartInitial()) {
    getCart();
  }

  Stream<String> get messageStream => _messageController.stream;

  void _showMessage(String message) {
    _messageController.add(message);
  }

  List<CartItemModel> get _items {
    if (state is CartLoaded) {
      return (state as CartLoaded).cartItems;
    }
    return [];
  }

  Future<void> _syncCartWithServer() async {
    if (_isSyncing) return;

    try {
      _isSyncing = true;
      final serverCart = await _apiService.getCart();
      final String? cartId = serverCart['_id'];
      final List<dynamic> serverItems = serverCart['cartItems'] ?? [];
      final serverCartItems =
          serverItems.map((item) => CartItemModel.fromJson(item)).toList();

      // Update cache
      _cartItemCache.clear();
      for (var item in serverCartItems) {
        _cartItemCache[item.product.id] = item;
        _productCache[item.product.id] = item.product;
      }

      // Only update UI if there are actual changes
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        if (!_areItemsEqual(currentState.cartItems, serverCartItems) ||
            currentState.cartId != cartId) {
          _updateUIState(serverCartItems, cartId: cartId);
        }
      } else {
        _updateUIState(serverCartItems, cartId: cartId);
      }
    } catch (e) {
      // Handle 404 as a valid empty cart state
      if (e.toString().contains('404') ||
          e.toString().contains('no cart for this user')) {
        _updateUIState([]);
        _productCache.clear();
        return;
      }
      rethrow;
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> getCart() async {
    try {
      emit(CartLoading());
      try {
        final response = await _apiService.getCart();
        final String? cartId = response['_id'];
        final List<dynamic> items = response['cartItems'] ?? [];
        final Map<String, CartItemModel> uniqueItems = {};
        for (var item in items) {
          try {
            // Always fetch the latest product details by ID
            final productId = item['product']?['_id'] ??
                item['product']?['id'] ??
                item['productId'];
            if (productId == null) continue;
            final fullProduct = await _getProductDetails(productId);
            final quantity = item['quantity'] ?? 1;
            final cartItem = CartItemModel(
              product: fullProduct,
              quantity:
                  quantity is int ? quantity : int.parse(quantity.toString()),
            );
            uniqueItems[productId] = cartItem;
            _productCache[productId] = fullProduct;
          } catch (e) {
            continue;
          }
        }
        final cartItems = uniqueItems.values.toList();
        _updateUIState(cartItems, cartId: cartId);
      } catch (e) {
        // Handle 404 as a valid empty cart state
        if (e.toString().contains('404') ||
            e.toString().contains('no cart for this user')) {
          _updateUIState([]);
          _productCache.clear();
          return;
        }
        rethrow;
      }
    } catch (e, stackTrace) {
      emit(CartError('Failed to load cart: $e'));
    }
  }

  bool _areItemsEqual(List<CartItemModel> items1, List<CartItemModel> items2) {
    if (items1.length != items2.length) return false;

    for (int i = 0; i < items1.length; i++) {
      final item1 = items1[i];
      final item2 = items2[i];

      if (item1.product.id != item2.product.id ||
          item1.quantity != item2.quantity) {
        return false;
      }
    }
    return true;
  }

  Future<void> _waitForPendingOperation(String operationKey) async {
    if (_pendingOperations.containsKey(operationKey)) {
      await _pendingOperations[operationKey]?.future;
    }
  }

  Future<void> addToCart(String productId, String color) async {
    final operationKey = 'add_$productId';
    if (_isOperationInProgress) {
      await _waitForPendingOperation(operationKey);
      return;
    }
    try {
      _isOperationInProgress = true;

      // Validate product ID
      if (productId.isEmpty) {
        _showToast('Invalid product ID', isError: true);
        return;
      }

      // Get current cart state
      final currentState = state;
      if (currentState is CartLoaded) {
        try {
          // Get product details from cache or server
          final product =
              _productCache[productId] ?? await _getProductDetails(productId);

          // Find existing item
          final existingItemIndex = currentState.cartItems
              .indexWhere((item) => item.product.id == productId);

          // Store current state for potential rollback
          final previousItems =
              List<CartItemModel>.from(currentState.cartItems);

          List<CartItemModel> updatedItems;
          if (existingItemIndex != -1) {
            // Update quantity if item exists
            updatedItems = List<CartItemModel>.from(currentState.cartItems);
            updatedItems[existingItemIndex] = CartItemModel(
              product: updatedItems[existingItemIndex].product,
              quantity: updatedItems[existingItemIndex].quantity + 1,
            );
            _updateUIState(updatedItems,
                action: CartAction.updated, message: 'Quantity updated');
          } else {
            // Add new item
            final newItem = CartItemModel(
              product: product,
              quantity: 1,
            );
            updatedItems = [...currentState.cartItems, newItem];
            _updateUIState(updatedItems, action: CartAction.added);
          }

          // Add to server and sync immediately
          try {
            await _apiService.addToCart(productId, color);
            await _syncCartWithServer();
            _showToast('Product added to cart');
          } catch (e) {
            _updateUIState(previousItems);
            _showToast('Failed to add item to cart', isError: true);
          }
        } catch (e) {
          _showToast('Failed to get product details', isError: true);
          return;
        }
      } else {
        await getCart();
        await addToCart(productId, color);
      }
    } catch (e, stackTrace) {
      emit(CartError('Failed to add item to cart: ${e.toString()}'));
      _showToast('Failed to add item to cart', isError: true);
    } finally {
      _isOperationInProgress = false;
    }
  }

  Future<void> removeFromCart(String productId,
      {bool skipConfirmation = false}) async {
    final operationKey = 'remove_$productId';
    if (_isOperationInProgress) {
      await _waitForPendingOperation(operationKey);
      return;
    }

    try {
      _isOperationInProgress = true;

      // Show confirmation dialog if not skipped
      if (!skipConfirmation) {
        final shouldRemove = await _showConfirmationDialog();
        if (!shouldRemove) {
          return;
        }
      }

      // Get current state
      final currentState = state;
      if (currentState is CartLoaded) {
        // Store the current items for potential rollback
        final previousItems = List<CartItemModel>.from(currentState.cartItems);

        // Find the item to remove
        final itemToRemove = currentState.cartItems.firstWhere(
          (item) => item.product.id == productId,
          orElse: () => CartItemModel(
            product: ProductsViewsModel(id: '', title: '', price: 0),
            quantity: 0,
          ),
        );

        if (itemToRemove.product.id == '') {
          _showToast('Item not found in cart', isError: true);
          return;
        }

        // Optimistically update UI immediately
        final updatedItems = currentState.cartItems
            .where((item) => item.product.id != productId)
            .toList();
        emit(CartLoaded(updatedItems, action: CartAction.removed));

        // Remove from server and sync immediately
        try {
          await _apiService.removeFromCart(productId);
          await _syncCartWithServer();
          _cartItemCache.remove(productId);
          _productCache.remove(productId);
          _showToast('Product removed from cart');
        } catch (e) {
          _updateUIState(previousItems);
          _showToast('Failed to remove item', isError: true);
        }
      }
    } catch (e, stackTrace) {
      emit(CartError('Failed to remove item from cart: ${e.toString()}'));
      _showToast('Failed to remove item from cart', isError: true);
    } finally {
      _isOperationInProgress = false;
    }
  }

  Future<void> updateCartItemQuantity(String productId, int quantity) async {
    final operationKey = 'update_${productId}_$quantity';
    if (_isOperationInProgress) {
      await _waitForPendingOperation(operationKey);
      return;
    }

    try {
      _isOperationInProgress = true;

      // If quantity is 0 or less, remove the item instead
      if (quantity <= 0) {
        await removeFromCart(productId, skipConfirmation: true);
        return;
      }

      // Get current state
      final currentState = state;
      if (currentState is CartLoaded) {
        // Store the current items for potential rollback
        final previousItems = List<CartItemModel>.from(currentState.cartItems);

        // Find the item to update
        final itemToUpdate = currentState.cartItems.firstWhere(
          (item) => item.product.id == productId,
          orElse: () => CartItemModel(
            product: ProductsViewsModel(id: '', title: '', price: 0),
            quantity: 0,
          ),
        );

        if (itemToUpdate.product.id == '') {
          _showToast('Item not found in cart', isError: true);
          return;
        }

        // Optimistically update UI immediately
        final updatedItems = currentState.cartItems.map((item) {
          if (item.product.id == productId) {
            return CartItemModel(
              product: item.product,
              quantity: quantity,
            );
          }
          return item;
        }).toList();

        // Update UI state without loading indicator
        emit(CartLoaded(updatedItems, action: CartAction.updated));

        // Update on server and sync immediately
        try {
          await _apiService.updateCartItemQuantity(productId, quantity);
          await _syncCartWithServer();
          _showToast('Quantity updated');
        } catch (e) {
          _updateUIState(previousItems);
          _showToast('Failed to update quantity', isError: true);
        }
      }
    } catch (e, stackTrace) {
      _showMessage('Failed to update item quantity');
    } finally {
      _isOperationInProgress = false;
    }
  }

  Future<bool> _showConfirmationDialog() async {
    try {
      final result = await showDialog<bool>(
        context: navigatorKey.currentContext!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Remove Item'),
            content: const Text(
                'Are you sure you want to remove this item from your cart?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: const Text('Remove'),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          );
        },
      );
      return result ?? false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _showClearCartConfirmationDialog() async {
    try {
      final result = await showDialog<bool>(
        context: navigatorKey.currentContext!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Clear Cart'),
            content: const Text(
                'Are you sure you want to remove all items from your cart?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: const Text('Clear'),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          );
        },
      );
      return result ?? false;
    } catch (e) {
      return false;
    }
  }

  // Add navigator key for showing dialogs
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  void _showToast(String message, {bool isError = false}) {
    // Intentionally left blank to prevent duplicate notifications.
  }

  Future<void> clearCart({bool force = false}) async {
    if (_isOperationInProgress) {
      return;
    }

    try {
      _isOperationInProgress = true;

      if (!force) {
        final shouldClear = await _showClearCartConfirmationDialog();
        if (!shouldClear) {
          return;
        }
      }

      emit(CartLoading());

      try {
        await _apiService.clearCart();
      } catch (e, st) {
        final errorString = e.toString();
        if (errorString.contains('There is no cart for this user')) {
          return;
        }
        emit(CartError('Failed to clear cart: ${e.toString()}',
            action: CartAction.error));
        _showToast('Failed to clear cart', isError: true);
        return;
      }

      _cartItemCache.clear();
      _productCache.clear();

      emit(CartLoaded([], action: CartAction.removed, message: 'Cart cleared'));
      await getCart(); // Force refresh from backend to update UI
    } catch (e, stackTrace) {
      emit(CartError('Failed to clear cart: ${e.toString()}',
          action: CartAction.error));
      _showToast('Failed to clear cart', isError: true);
    } finally {
      _isOperationInProgress = false;
    }
  }

  Future<double> applyCoupon(String couponCode) async {
    try {
      emit(CartLoading());

      // نفترض إن هذه الدالة ترجع الخصم مثلاً 50.0
      final discount = await _apiService.applyCoupon(couponCode);

      await getCart();

      // Get the current cartId if available
      String? currentCartId;
      if (state is CartLoaded) {
        currentCartId = (state as CartLoaded).cartId;
      }

      emit(CartLoaded(
        _items,
        message: 'Coupon applied successfully',
        discount: discount,
        cartId: currentCartId,
      ));
      _showToast('Coupon applied successfully');

      return discount;
    } catch (e) {
      emit(CartError('Failed to apply coupon: ${e.toString()}',
          action: CartAction.error));
      _showToast('Failed to apply coupon', isError: true);

      // نرجع 0 في حالة الفشل أو نرمي الخطأ زي ما تحب
      rethrow;
    }
  }

  @override
  Future<void> close() {
    _messageController.close();
    return super.close();
  }

  // Helper method to get product details with caching
  Future<ProductsViewsModel> _getProductDetails(String productId) async {
    try {
      // Check cache first
      if (_productCache.containsKey(productId)) {
        return _productCache[productId]!;
      }

      // Try to get product details with retry
      int retryCount = 0;
      const maxRetries = 2;

      while (retryCount < maxRetries) {
        try {
          final productData = await _apiService.getProductById(productId);
          if (productData == null) {
            throw Exception('Product not found or no longer available');
          }

          final product = ProductsViewsModel.fromJson(productData);
          // Cache the product
          _productCache[productId] = product;
          return product;
        } catch (e) {
          retryCount++;

          if (retryCount == maxRetries) {
            if (e.toString().contains('404') ||
                e.toString().contains('not found')) {
              throw Exception('Product is no longer available');
            }
            rethrow;
          }
          // Wait before retrying with exponential backoff
          await Future.delayed(Duration(milliseconds: 500 * (1 << retryCount)));
        }
      }

      throw Exception(
          'Failed to get product details after $maxRetries attempts');
    } catch (e) {
      throw Exception('Failed to get product details: $e');
    }
  }

  // Add method to handle UI updates more efficiently
  void _updateUIState(
    List<CartItemModel> items, {
    CartAction? action,
    String? message,
    String? cartId, // ✅ new param
  }) {
    try {
      if (items.isEmpty) {
        emit(CartLoaded([], action: action, message: message, cartId: cartId));
      } else {
        if (state is CartLoaded) {
          final currentState = state as CartLoaded;
          if (_areItemsEqual(currentState.cartItems, items) &&
              currentState.cartId == cartId) {
            return;
          }
        }
        emit(CartLoaded(items,
            action: action, message: message, cartId: cartId));
      }
    } catch (e) {
      // Handle 404 as a valid empty cart state
      if (e.toString().contains('404') ||
          e.toString().contains('no cart for this user')) {
        emit(CartLoaded([], action: action, message: message, cartId: cartId));
        _productCache.clear();
        return;
      }
      rethrow;
    }
  }
}

class CartBlocProvider extends StatelessWidget {
  final Widget child;

  const CartBlocProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartCubit>(
      create: (context) => CartCubit(),
      child: child,
    );
  }
}
