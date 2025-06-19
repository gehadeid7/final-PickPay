import 'package:equatable/equatable.dart';
import '../models/order_model.dart';

class OrderState extends Equatable {
  final List<OrderModel> orders;
  final bool isLoading;
  final String? error;

  const OrderState({
    this.orders = const [],
    this.isLoading = false,
    this.error,
  });

  OrderState copyWith({
    List<OrderModel>? orders,
    bool? isLoading,
    String? error,
  }) {
    return OrderState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  List<OrderModel> get pendingOrders =>
      orders.where((order) => order.status == OrderStatus.pending || order.status == OrderStatus.paid).toList();
  List<OrderModel> get deliveredOrders =>
      orders.where((order) => order.status == OrderStatus.delivered).toList();

  @override
  List<Object?> get props => [orders, isLoading, error];
}
