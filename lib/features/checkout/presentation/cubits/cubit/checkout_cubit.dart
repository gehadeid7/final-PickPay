// features/checkout/presentation/cubit/checkout_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/features/cart/cart_cubits/cart_cubit.dart';
import 'package:pickpay/features/checkout/domain/models/checkout_model.dart';
import 'package:pickpay/features/cart/cart_item_model.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutData(total: 0));

  void updateTotal(double total) {
    final currentState = state;
    if (currentState is CheckoutData) {
      emit(currentState.copyWith(total: total));
    }
  }

  void applyCoupon({required double discount, required String couponCode}) {
    final currentState = state;
    if (currentState is CheckoutData) {
      final newTotal = currentState.total - discount;
      emit(currentState.copyWith(
        discount: discount,
        totalAfterDiscount: newTotal,
        couponCode: couponCode,
      ));
    }
  }

  Future<void> placeOrder({
    required List<CartItemModel> items,
    required double total,
    required ShippingInfo shippingInfo,
    required PaymentInfo paymentInfo,
    required CartCubit cartCubit,
  }) async {
    emit(CheckoutLoading());

    try {
      await Future.delayed(const Duration(seconds: 2));

      final orderId = 'ORD-${DateTime.now().millisecondsSinceEpoch}';

      final order = OrderModel(
        id: orderId,
        date: DateTime.now(),
        items: items,
        total: total,
        shippingInfo: shippingInfo,
        paymentInfo: paymentInfo,
      );

      emit(CheckoutSuccess(order: order));
    } catch (e) {
      emit(CheckoutError(message: 'Failed to place order: ${e.toString()}'));
    }
  }
}
