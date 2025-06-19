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

class CheckoutData extends CheckoutState {
  final double total;
  final double? discount;
  final double? totalAfterDiscount;
  final String? couponCode;

  CheckoutData({
    required this.total,
    this.discount,
    this.totalAfterDiscount,
    this.couponCode,
  });

  CheckoutData copyWith({
    double? total,
    double? discount,
    double? totalAfterDiscount,
    String? couponCode,
  }) {
    return CheckoutData(
      total: total ?? this.total,
      discount: discount ?? this.discount,
      totalAfterDiscount: totalAfterDiscount ?? this.totalAfterDiscount,
      couponCode: couponCode ?? this.couponCode,
    );
  }
}
