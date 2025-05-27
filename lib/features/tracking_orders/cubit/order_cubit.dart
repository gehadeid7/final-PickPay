import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/order_model.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(const OrderState());

  void addOrder(OrderModel order) {
    final currentOrders = List<OrderModel>.from(state.orders);
    currentOrders.add(order);
    emit(state.copyWith(orders: currentOrders));
  }

  void updateOrderStatus(String orderId, OrderStatus newStatus) {
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

    emit(state.copyWith(orders: updatedOrders));
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
