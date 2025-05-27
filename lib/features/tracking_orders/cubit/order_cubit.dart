import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/core/services/shared_preferences_singletone.dart';
import '../models/order_model.dart';
import 'order_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderCubit extends Cubit<OrderState> {
  final _auth = FirebaseAuth.instance;

  OrderCubit() : super(const OrderState()) {
    // Listen to auth state changes
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        loadOrders(); // Load orders when user logs in
      } else {
        emit(state.copyWith(orders: [])); // Clear orders when user logs out
      }
    });

    // Initial load if user is already logged in
    if (_auth.currentUser != null) {
      loadOrders();
    }
  }

  String? get _userId => _auth.currentUser?.uid;

  Future<void> loadOrders() async {
    if (_userId == null) return;

    try {
      emit(state.copyWith(isLoading: true));
      final orders = Prefs.getUserOrders(_userId!);

      if (orders != null) {
        final ordersList =
            orders.map((order) => OrderModel.fromJson(order)).toList();
        emit(state.copyWith(orders: ordersList, isLoading: false));
      } else {
        emit(state.copyWith(orders: [], isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to load orders: $e',
        isLoading: false,
      ));
    }
  }

  Future<void> _saveOrders(List<OrderModel> orders) async {
    if (_userId == null) return;

    try {
      final ordersList = orders.map((order) => order.toJson()).toList();
      await Prefs.saveUserOrders(_userId!, ordersList);
    } catch (e) {
      emit(state.copyWith(error: 'Failed to save orders: $e'));
    }
  }

  Future<void> addOrder(OrderModel order) async {
    if (_userId == null) {
      emit(state.copyWith(error: 'User not logged in'));
      return;
    }

    try {
      final currentOrders = List<OrderModel>.from(state.orders);
      currentOrders.add(order);
      await _saveOrders(currentOrders);
      emit(state.copyWith(orders: currentOrders));
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
      final updatedOrders = state.orders.map((order) {
        if (order.id == orderId) {
          return order.copyWith(
            status: newStatus,
            deliveredAt:
                newStatus == OrderStatus.delivered ? DateTime.now() : null,
          );
        }
        return order;
      }).toList();

      await _saveOrders(updatedOrders);
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
      return state.orders.firstWhere((order) => order.id == orderId);
    } catch (e) {
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
