// features/checkout/presentation/cubit/checkout_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/features/cart/cart_cubits/cart_cubit.dart';
import 'package:pickpay/features/checkout/domain/models/checkout_model.dart';
import 'package:pickpay/features/cart/cart_item_model.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutData(total: 0));

  void updateTotal(double newTotal) {
    final currentState = state;
    if (currentState is CheckoutData) {
      double? newTotalAfterDiscount;
      // If a discount was already applied, recalculate the total after discount
      if (currentState.discount != null && currentState.discount! > 0) {
        newTotalAfterDiscount = newTotal - currentState.discount!;
      }

      emit(
        currentState.copyWith(
          total: newTotal,
          totalAfterDiscount: newTotalAfterDiscount,
        ),
      );
    } else {
      // For any other state, just initialize with the new total.
      emit(CheckoutData(total: newTotal));
    }
  }

  void applyCoupon({required double discount, required String couponCode}) {
    final currentState = state;
    if (currentState is CheckoutData) {
      final newTotal = currentState.total - discount;
      emit(currentState.copyWith(
        discount: discount,
        totalAfterDiscount: newTotal > 0 ? newTotal : 0,
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
