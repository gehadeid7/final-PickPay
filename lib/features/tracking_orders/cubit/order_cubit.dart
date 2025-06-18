import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pickpay/core/services/shared_preferences_singletone.dart';
import 'package:pickpay/features/cart/cart_cubits/cart_cubit.dart';
import 'package:pickpay/services/api_service.dart';
import '../models/order_model.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final _auth = FirebaseAuth.instance;
  final ApiService _apiService = ApiService();

  OrderCubit() : super(const OrderState()) {
    _auth.authStateChanges().listen((User? user) {
      print('🔄 [Auth Change] User is ${user != null ? 'logged in' : 'logged out'}');
      if (user != null) {
        loadOrders();
      } else {
        emit(state.copyWith(orders: []));
        print('🧹 [Auth Change] Orders cleared');
      }
    });

    if (_auth.currentUser != null) {
      print('✅ [Init] User is logged in. Loading orders...');
      loadOrders();
    } else {
      print('❌ [Init] No user logged in.');
    }
  }

  String? get _userId => _auth.currentUser?.uid;

  // Added extensive logging to debug the loadOrders method
  Future<void> loadOrders() async {
    if (_userId == null) {
      print('❌ [LOAD ORDERS] User ID is null. Aborting loadOrders.');
      return;
    }

    print('📦 [LOAD ORDERS] Started for user $_userId');

    try {
      emit(state.copyWith(isLoading: true));
      print('🔄 [LOAD ORDERS] State updated to loading.');

      final ordersJson = await _apiService.getAllOrders();
      print('📥 [LOAD ORDERS] API response received: $ordersJson');

      final ordersList = ordersJson.map((json) => OrderModel.fromJson(json)).toList();
      print('📋 [LOAD ORDERS] Parsed orders list: $ordersList');

      // Debug print for each order
      for (final order in ordersList) {
        print('[DEBUG] Order: id=${order.id}, userId=${order.userId}, status=${order.status}, createdAt=${order.createdAt}');
      }

      emit(state.copyWith(
        orders: ordersList,
        isLoading: false,
      ));
      print('✅ [LOAD ORDERS] State updated with orders.');

      await Prefs.saveUserOrders(
          _userId!, ordersList.map((o) => o.toJson()).toList());
      print('✅ [LOAD ORDERS] Orders saved to preferences.');

      print('✅ [LOAD ORDERS] Loaded ${ordersList.length} orders');
      print('✅ [LOAD ORDERS] Pending: ${state.pendingOrders.length}, Delivered: ${state.deliveredOrders.length}');
    } catch (e) {
      print('❌ [LOAD ORDERS] Failed: $e');
      emit(state.copyWith(
        error: 'Failed to load orders: $e',
        isLoading: false,
      ));
      print('❌ [LOAD ORDERS] State updated with error.');
    }
  }

Future<void> addOrderFromBackend(
  String cartId,
  Map<String, dynamic> shippingAddress,
  CartCubit cartCubit, // <--- add this parameter
) async {
  if (_userId == null) {
    print('❌ [ADD ORDER] User not logged in');
    emit(state.copyWith(error: 'User not logged in'));
    return;
  }

  print('📦 [ADD ORDER] Creating order for cartId: $cartId');

  try {
    final orderJson = await _apiService.createCashOrder(cartId, shippingAddress);
    final newOrder = OrderModel.fromJson(orderJson);

    final updatedOrders = List<OrderModel>.from(state.orders)..add(newOrder);
    await Prefs.saveUserOrders(_userId!, updatedOrders.map((o) => o.toJson()).toList());

    emit(state.copyWith(orders: updatedOrders));
    print('✅ [ADD ORDER] Order added successfully');

    // 🧹 Clear cart after successful order
    await cartCubit.clearCart(force: true);
    // Ensure UI is updated after clearing
    await cartCubit.getCart();
  } catch (e) {
    print('❌ [ADD ORDER] Failed: $e');
    emit(state.copyWith(error: 'Failed to add order: $e'));
  }
}


  Future<void> updateOrderStatus(String orderId, OrderStatus newStatus) async {
    if (_userId == null) {
      print('❌ [UPDATE ORDER] User not logged in');
      emit(state.copyWith(error: 'User not logged in'));
      return;
    }

    print('🔁 [UPDATE ORDER] Updating order $orderId to $newStatus');

    try {
      if (newStatus == OrderStatus.paid) {
        await _apiService.markOrderAsPaid(orderId);
      } else if (newStatus == OrderStatus.delivered) {
        await _apiService.markOrderAsDelivered(orderId);
      }

      final updatedOrders = state.orders.map((order) {
        if (order.id == orderId) {
          return order.copyWith(
            status: newStatus,
            deliveredAt: newStatus == OrderStatus.delivered ? DateTime.now() : null,
          );
        }
        return order;
      }).toList();

      await Prefs.saveUserOrders(_userId!, updatedOrders.map((o) => o.toJson()).toList());
      emit(state.copyWith(orders: updatedOrders));

      print('✅ [UPDATE ORDER] Order $orderId updated to $newStatus');
    } catch (e) {
      print('❌ [UPDATE ORDER] Failed: $e');
      emit(state.copyWith(error: 'Failed to update order status: $e'));
    }
  }

  Future<void> clearOrders() async {
    if (_userId == null) return;

    print('🧹 [CLEAR ORDERS] Clearing orders for user $_userId');

    try {
      await Prefs.clearUserOrders(_userId!);
      emit(state.copyWith(orders: []));
      print('✅ [CLEAR ORDERS] Cleared');
    } catch (e) {
      print('❌ [CLEAR ORDERS] Failed: $e');
      emit(state.copyWith(error: 'Failed to clear orders: $e'));
    }
  }

  OrderModel? getOrderById(String orderId) {
    try {
      final found = state.orders.firstWhere((order) => order.id == orderId);
      print('🔍 [GET ORDER] Found order $orderId');
      return found;
    } catch (_) {
      print('❌ [GET ORDER] Order $orderId not found');
      return null;
    }
  }

  void setError(String error) {
    print('⚠️ [SET ERROR] $error');
    emit(state.copyWith(error: error));
  }

  void clearError() {
    print('✅ [CLEAR ERROR]');
    emit(state.copyWith(error: null));
  }

  void setLoading(bool loading) {
    print('🔄 [SET LOADING] $loading');
    emit(state.copyWith(isLoading: loading));
  }
}
