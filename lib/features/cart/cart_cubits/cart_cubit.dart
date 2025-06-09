import 'dart:async';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pickpay/features/cart/cart_item_model.dart';
import 'package:pickpay/services/api_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bloc/bloc.dart';
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

  CartCubit() : _apiService = ApiService(), super(CartInitial()) {
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
      dev.log('Syncing cart with server...', name: 'CartCubit');
      final serverCart = await _apiService.getCart();
      
      final List<dynamic> serverItems = serverCart['cartItems'] ?? [];
      final serverCartItems = serverItems.map((item) => CartItemModel.fromJson(item)).toList();
      
      // Update cache
      _cartItemCache.clear();
      for (var item in serverCartItems) {
          _cartItemCache[item.product.id] = item;
          _productCache[item.product.id] = item.product;
      }
      
      // Only update UI if there are actual changes
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        if (!_areItemsEqual(currentState.cartItems, serverCartItems)) {
          _updateUIState(serverCartItems);
        }
      }
    } catch (e) {
      dev.log('Error syncing cart: $e', name: 'CartCubit', error: e);
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> getCart() async {
    try {
      dev.log('[CartCubit] Getting cart data...', name: 'CartCubit');
      emit(CartLoading());
      try {
        final response = await _apiService.getCart();
        dev.log('[CartCubit] Cart response: $response', name: 'CartCubit');
        // Remove null check for response, as it can't be null
        final String? cartId = response['_id'];
        final List<dynamic> items = response['cartItems'] ?? [];
        // Ensure no duplicate items by using a Map
        final Map<String, CartItemModel> uniqueItems = {};
        for (var item in items) {
          try {
            // Always fetch the latest product details by ID
            final productId = item['product']?['_id'] ?? item['product']?['id'] ?? item['productId'];
            if (productId == null) continue;
            final fullProduct = await _getProductDetails(productId);
            final quantity = item['quantity'] ?? 1;
            final cartItem = CartItemModel(
              product: fullProduct,
              quantity: quantity is int ? quantity : int.parse(quantity.toString()),
            );
            uniqueItems[productId] = cartItem;
            _productCache[productId] = fullProduct;
          } catch (e) {
            dev.log('Error processing cart item: $e', name: 'CartCubit', error: e);
            continue;
          }
        }
        final cartItems = uniqueItems.values.toList();
        dev.log('Processed cart items: [32m${cartItems.length}[0m', name: 'CartCubit');
        _updateUIState(cartItems, cartId: cartId);
      } catch (e) {
        // Handle 404 as a valid empty cart state
        if (e.toString().contains('404') || e.toString().contains('no cart for this user')) {
          dev.log('No cart exists for user, initializing empty cart', name: 'CartCubit');
          _updateUIState([]);
          _productCache.clear();
          return;
        }
        rethrow;
      }
    } catch (e, stackTrace) {
      dev.log('Error getting cart: $e\n$stackTrace', name: 'CartCubit', error: e);
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
      dev.log('Adding product $productId to cart with color $color', name: 'CartCubit');

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
          final product = _productCache[productId] ?? await _getProductDetails(productId);
          
          // Find existing item
          final existingItemIndex = currentState.cartItems.indexWhere(
            (item) => item.product.id == productId
          );

          // Store current state for potential rollback
          final previousItems = List<CartItemModel>.from(currentState.cartItems);

          List<CartItemModel> updatedItems;
          if (existingItemIndex != -1) {
            // Update quantity if item exists
            updatedItems = List<CartItemModel>.from(currentState.cartItems);
            updatedItems[existingItemIndex] = CartItemModel(
              product: updatedItems[existingItemIndex].product,
              quantity: updatedItems[existingItemIndex].quantity + 1,
            );
            _updateUIState(updatedItems, action: CartAction.updated);
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
            dev.log('Error adding to server: $e', name: 'CartCubit', error: e);
            _updateUIState(previousItems);
            _showToast('Failed to add item to cart', isError: true);
          }
        } catch (e) {
          dev.log('Error getting product details: $e', name: 'CartCubit', error: e);
          _showToast('Failed to get product details', isError: true);
          return;
        }
      } else {
        await getCart();
        await addToCart(productId, color);
      }
    } catch (e, stackTrace) {
      dev.log('Error in addToCart: $e\n$stackTrace', name: 'CartCubit', error: e);
      emit(CartError('Failed to add item to cart: ${e.toString()}'));
      _showToast('Failed to add item to cart', isError: true);
    } finally {
      _isOperationInProgress = false;
    }
  }

  Future<void> removeFromCart(String productId, {bool skipConfirmation = false}) async {
    final operationKey = 'remove_$productId';
    if (_isOperationInProgress) {
      await _waitForPendingOperation(operationKey);
      return;
    }
    
    try {
      _isOperationInProgress = true;
      dev.log('Removing product $productId from cart', name: 'CartCubit');
      
      // Show confirmation dialog if not skipped
      if (!skipConfirmation) {
        final shouldRemove = await _showConfirmationDialog();
        if (!shouldRemove) {
          dev.log('User cancelled removal', name: 'CartCubit');
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
          dev.log('Item not found in cart: $productId', name: 'CartCubit');
          _showToast('Item not found in cart', isError: true);
          return;
        }

        // Optimistically update UI immediately
        final updatedItems = currentState.cartItems.where((item) => item.product.id != productId).toList();
        emit(CartLoaded(updatedItems, action: CartAction.removed));

        // Remove from server and sync immediately
        try {
          await _apiService.removeFromCart(productId);
          await _syncCartWithServer();
          _cartItemCache.remove(productId);
          _productCache.remove(productId);
          _showToast('Product removed from cart');
        } catch (e) {
          dev.log('Error removing from server: $e', name: 'CartCubit', error: e);
          _updateUIState(previousItems);
          _showToast('Failed to remove item', isError: true);
        }
      }
    } catch (e, stackTrace) {
      dev.log('Error in removeFromCart: $e\n$stackTrace', name: 'CartCubit', error: e);
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
      dev.log('Updating quantity for product $productId to $quantity', name: 'CartCubit');
      
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
          dev.log('Item not found in cart: $productId', name: 'CartCubit');
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
          dev.log('Error updating cart item on server: $e', name: 'CartCubit', error: e);
          _updateUIState(previousItems);
          _showToast('Failed to update quantity', isError: true);
        }
      }
    } catch (e, stackTrace) {
      dev.log('Error updating cart item quantity: $e\n$stackTrace', name: 'CartCubit', error: e);
      emit(CartError('Failed to update item quantity: ${e.toString()}'));
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
            content: const Text('Are you sure you want to remove this item from your cart?'),
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
      dev.log('Error showing confirmation dialog: $e', name: 'CartCubit', error: e);
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
            content: const Text('Are you sure you want to remove all items from your cart?'),
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
      dev.log('Error showing clear cart confirmation dialog: $e', name: 'CartCubit', error: e);
      return false;
    }
  }

  // Add navigator key for showing dialogs
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void _showToast(String message, {bool isError = false}) {
    try {
      // Cancel any existing toast
      Fluttertoast.cancel();
      
      // Use a more efficient toast configuration
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: isError ? Colors.red : Colors.green,
        textColor: Colors.white,
        fontSize: 14.0,
        timeInSecForIosWeb: 1,
        webPosition: "center",
        webBgColor: isError ? "red" : "green",
      );
    } catch (e) {
      dev.log('Error showing toast: $e', name: 'CartCubit', error: e);
    }
  }

Future<void> clearCart({bool force = false}) async {
  if (_isOperationInProgress) {
    dev.log('[CartCubit] clearCart: Operation already in progress, skipping.', name: 'CartCubit');
    return;
  }

  try {
    _isOperationInProgress = true;
    dev.log('[CartCubit] clearCart: Start (force: $force)', name: 'CartCubit');

    if (!force) {
      dev.log('[CartCubit] clearCart: Showing confirmation dialog', name: 'CartCubit');
      final shouldClear = await _showClearCartConfirmationDialog();
      dev.log('[CartCubit] clearCart: Confirmation dialog result: $shouldClear', name: 'CartCubit');
      if (!shouldClear) {
        dev.log('[CartCubit] clearCart: User cancelled cart clearing', name: 'CartCubit');
        return;
      }
    }

    emit(CartLoading());
    dev.log('[CartCubit] clearCart: Emitted CartLoading()', name: 'CartCubit');

    try {
      dev.log('[CartCubit] clearCart: Calling _apiService.clearCart()', name: 'CartCubit');
      await _apiService.clearCart();
      dev.log('[CartCubit] clearCart: Successfully cleared cart on backend', name: 'CartCubit');
    } catch (e, st) {
      final errorString = e.toString();
      if (errorString.contains('There is no cart for this user')) {
        dev.log('[CartCubit] clearCart: Cart already empty on backend. Treating as success.', name: 'CartCubit');
      } else {
        dev.log('[CartCubit] clearCart: Error clearing server: $e', name: 'CartCubit', error: e, stackTrace: st);
        emit(CartError('Failed to clear cart: ${e.toString()}', action: CartAction.error));
        _showToast('Failed to clear cart', isError: true);
        return;
      }
    }

    _cartItemCache.clear();
    _productCache.clear();
    dev.log('[CartCubit] clearCart: Cleared in-memory cart cache', name: 'CartCubit');

    emit(CartLoaded([], action: CartAction.removed, message: 'Cart cleared'));
    dev.log('[CartCubit] clearCart: Emitted CartLoaded([]) after clear', name: 'CartCubit');
    _showToast('Cart cleared');
  } catch (e, stackTrace) {
    dev.log('[CartCubit] clearCart: Unexpected error: $e', name: 'CartCubit', error: e, stackTrace: stackTrace);
    emit(CartError('Failed to clear cart: ${e.toString()}', action: CartAction.error));
    _showToast('Failed to clear cart', isError: true);
  } finally {
    _isOperationInProgress = false;
    dev.log('[CartCubit] clearCart: Finished. _isOperationInProgress set to false.', name: 'CartCubit');
  }
}

  Future<void> applyCoupon(String couponCode) async {
    try {
      emit(CartLoading());
      await _apiService.applyCoupon(couponCode);
      await getCart();
      emit(CartLoaded(_items, message: 'Coupon applied successfully'));
      _showToast('Coupon applied successfully');
    } catch (e) {
      dev.log('Error applying coupon: $e', name: 'CartCubit', error: e);
      emit(CartError('Failed to apply coupon: ${e.toString()}', action: CartAction.error));
      _showToast('Failed to apply coupon', isError: true);
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
        dev.log('Using cached product details for $productId', name: 'CartCubit');
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
          dev.log('Attempt $retryCount failed: $e', name: 'CartCubit', error: e);
          
          if (retryCount == maxRetries) {
            if (e.toString().contains('404') || e.toString().contains('not found')) {
              throw Exception('Product is no longer available');
            }
            rethrow;
          }
          // Wait before retrying with exponential backoff
          await Future.delayed(Duration(milliseconds: 500 * (1 << retryCount)));
        }
      }
      
      throw Exception('Failed to get product details after $maxRetries attempts');
    } catch (e) {
      dev.log('Error getting product details: $e', name: 'CartCubit', error: e);
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
        emit(CartLoaded([], action: action, message: message));
      } else {
        // Ensure we're not emitting the same state
        if (state is CartLoaded) {
          final currentState = state as CartLoaded;
          if (_areItemsEqual(currentState.cartItems, items)) {
            return; // Don't emit if items haven't changed
          }
        }
emit(CartLoaded(items, action: action, message: message, cartId: cartId));
      }
    } catch (e) {
      dev.log('Error updating UI state: $e', name: 'CartCubit', error: e);
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
