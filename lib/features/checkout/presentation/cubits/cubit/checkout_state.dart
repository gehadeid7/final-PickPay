// checkout_state.dart
part of 'checkout_cubit.dart';

abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutSuccess extends CheckoutState {
  final OrderModel order;

  CheckoutSuccess({required this.order});
}

class CheckoutError extends CheckoutState {
  final String message;

  CheckoutError({required this.message});
}
