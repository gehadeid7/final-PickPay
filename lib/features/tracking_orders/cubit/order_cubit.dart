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
      if (user != null) {
        loadOrders();
      } else {
        emit(state.copyWith(orders: []));
      }
    });

    if (_auth.currentUser != null) {
      loadOrders();
    }
  }

  String? get _userId => _auth.currentUser?.uid;

  Future<void> loadOrders() async {
    if (_userId == null) {
      return;
    }

    try {
      emit(state.copyWith(isLoading: true));

      final ordersJson = await _apiService.getAllOrders();

      final ordersList = ordersJson
          .where((json) => json != null)
          .map((json) {
            try {
              return OrderModel.fromJson(json);
            } catch (e) {
              return null;
            }
          })
          .whereType<OrderModel>()
          .toList();

      for (final order in ordersList) {
      }

      emit(state.copyWith(
        orders: ordersList,
        isLoading: false,
      ));

      await Prefs.saveUserOrders(
          _userId!, ordersList.map((o) => o.toJson()).toList());

    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to load orders: $e',
        isLoading: false,
      ));
    }
  }

Future<void> addOrderFromBackend(
  String cartId,
  Map<String, dynamic> shippingAddress,
  CartCubit cartCubit,
) async {
  if (_userId == null) {
    emit(state.copyWith(error: 'User not logged in'));
    return;
  }

  try {
    final orderJson = await _apiService.createCashOrder(cartId, shippingAddress);
    if (orderJson == null) {
      emit(state.copyWith(error: 'Failed to add order: Backend returned null order data'));
      return;
    }
    final newOrder = OrderModel.fromJson(orderJson);
    final updatedOrders = List<OrderModel>.from(state.orders)..add(newOrder);
    await Prefs.saveUserOrders(_userId!, updatedOrders.map((o) => o.toJson()).toList());

    emit(state.copyWith(orders: updatedOrders));

    // 🧹 Clear cart after successful order
    await cartCubit.clearCart(force: true);
    // Ensure UI is updated after clearing
    await cartCubit.getCart();
  } catch (e) {
    emit(state.copyWith(error: 'Failed to add order: $e'));
  }
}


  Future<void> updateOrderStatus(String orderId, OrderStatus newStatus) async {
    if (_userId == null) {
      emit(state.copyWith(error: 'User not logged in'));
      return;
    }

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
    } catch (e) {
      emit(state.copyWith(error: 'Failed to update order status: $e'));
    }
  }

  Future<void> clearOrders() async {
    if (_userId == null) return;

    try {
      await Prefs.clearUserOrders(_userId!);
      emit(state.copyWith(orders: []));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to clear orders: $e'));
    }
  }

  OrderModel? getOrderById(String orderId) {
    try {
      final found = state.orders.firstWhere((order) => order.id == orderId);
      return found;
    } catch (_) {
      return null;
    }
  }

  void setError(String error) {
    emit(state.copyWith(error: error));
  }

  void clearError() {
    emit(state.copyWith(error: null));
  }

  void setLoading(bool loading) {
    emit(state.copyWith(isLoading: loading));
  }
}
