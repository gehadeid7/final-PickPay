// features/checkout/presentation/cubit/checkout_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/features/cart/cart_cubits/cart_cubit.dart';
import 'package:pickpay/features/checkout/domain/models/checkout_model.dart';
import 'package:pickpay/features/cart/cart_item_model.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

Future<void> placeOrder({
  required List<CartItemModel> items,
  required double total,
  required ShippingInfo shippingInfo,
  required PaymentInfo paymentInfo,
  required CartCubit cartCubit, 
}) async {
  emit(CheckoutLoading());

  try {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    // Generate a random order ID
    final orderId = 'ORD-${DateTime.now().millisecondsSinceEpoch}';

    // Create the order
    final order = OrderModel(
      id: orderId,
      date: DateTime.now(),
      items: items,
      total: total,
      shippingInfo: shippingInfo,
      paymentInfo: paymentInfo,
    );

    // ✅ امسح السلة بعد نجاح الطلب
    await cartCubit.clearCart(force: true);

    emit(CheckoutSuccess(order: order));
  } catch (e) {
    emit(CheckoutError(message: 'Failed to place order: ${e.toString()}'));
  }
}

}
