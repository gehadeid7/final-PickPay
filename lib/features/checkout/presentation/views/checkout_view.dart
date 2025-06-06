import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/core/widgets/custom_button.dart';
import 'package:pickpay/features/checkout/domain/models/checkout_model.dart';
import 'package:pickpay/features/checkout/presentation/cubits/cubit/checkout_cubit.dart';
import 'package:pickpay/features/checkout/presentation/views/widgets/order_conformation.dart';
import 'package:pickpay/features/checkout/presentation/views/widgets/payment_section.dart';
import 'package:pickpay/features/checkout/presentation/views/widgets/shipping_section.dart';
import 'package:pickpay/features/cart/cart_item_model.dart';
import 'package:pickpay/features/cart/cart_cubits/cart_cubit.dart';
import 'package:pickpay/features/cart/cart_view.dart';
import 'package:pickpay/features/tracking_orders/cubit/order_cubit.dart';
import 'package:pickpay/features/tracking_orders/models/order_model.dart'
    as tracking;

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});
  static const routeName = 'checkout';

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final _formKey = GlobalKey<FormState>();
  late ShippingInfo _shippingInfo;
  String _paymentMethod = 'Credit Card';
  String _cardNumber = '';
  // ignore: unused_field
  String _expiryDate = '';
  // ignore: unused_field
  String _cvv = '';

  @override
  void initState() {
    super.initState();
    _shippingInfo = ShippingInfo(
      name: '',
      address: '',
      city: '',
      state: '',
      zipCode: '',
      phone: '',
      email: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cartCubit = context.read<CartCubit>();
    final cartState = cartCubit.state;

    if (cartState is! CartLoaded || cartState.cartItems.isEmpty) {
      return Scaffold(
        appBar: buildAppBar(
          context: context,
          title: 'Checkout',
          onBackPressed: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (ModalRoute.of(context)?.settings.name != CartView.routeName) {
                Navigator.pushReplacementNamed(context, CartView.routeName);
              }
            });
          },
        ),
        body: Center(
          child: Text(
            'Your cart is empty',
            style: TextStyles.regular13.copyWith(
              color: theme.colorScheme.onBackground,
            ),
          ),
        ),
      );
    }

    final items = cartState.cartItems;
    final total = items.fold<double>(
      0,
      (sum, item) => sum + (item.product.price ?? 0) * item.quantity,
    );

    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: 'Checkout',
        onBackPressed: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, CartView.routeName);
          });
        },
      ),
      backgroundColor: theme.colorScheme.background,
      body: BlocListener<CheckoutCubit, CheckoutState>(
        listener: (context, state) {
          if (state is CheckoutSuccess) {
            cartCubit.clearCart();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      OrderConfirmationView(order: state.order),
                ),
              );
            });
          } else if (state is CheckoutError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: theme.colorScheme.error,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Order Summary', theme),
                _buildOrderSummary(items, total, theme),
                const SizedBox(height: 24),
                _buildSectionTitle('Shipping Information', theme),
                ShippingInfoForm(
                  onSaved: (info) => _shippingInfo = info,
                ),
                const SizedBox(height: 24),
                _buildSectionTitle('Payment Method', theme),
                PaymentMethodSelector(
                  onMethodSelected: (method) => _paymentMethod = method,
                  onCardDetailsSaved: (number, expiry, cvv) {
                    _cardNumber = number;
                    _expiryDate = expiry;
                    _cvv = cvv;
                  },
                ),
                const SizedBox(height: 32),
                BlocBuilder<CheckoutCubit, CheckoutState>(
                  builder: (context, state) {
                    return CustomButton(
                      onPressed: state is CheckoutLoading
                          ? () {}
                          : () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                _processCheckout(context, items, total);
                              }
                            },
                      buttonText: state is CheckoutLoading
                          ? 'Processing...'
                          : 'Place Order (EGP ${total.toStringAsFixed(2)})',
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyles.bold16.copyWith(
          // ignore: deprecated_member_use
          color: theme.colorScheme.onBackground,
        ),
      ),
    );
  }

  Widget _buildOrderSummary(
      List<CartItemModel> items, double total, ThemeData theme) {
    return Card(
      color: theme.cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ...items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${item.product.title} x ${item.quantity}',
                          style: TextStyles.regular13.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      Text(
                        'EGP ${(item.product.price * item.quantity).toStringAsFixed(2)}',
                        style: TextStyles.semiBold11.copyWith(
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                )),
            const Divider(height: 24),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Total',
                    style: TextStyles.bold16.copyWith(
                      // ignore: deprecated_member_use
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                ),
                Text(
                  'EGP ${total.toStringAsFixed(2)}',
                  style: TextStyles.bold16.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

Future<void> _processCheckout(
  BuildContext context,
  List<CartItemModel> items,
  double total,
) async {
  if (!_formKey.currentState!.validate()) return;
  _formKey.currentState!.save();

  final checkoutCubit = context.read<CheckoutCubit>();
  final orderCubit = context.read<OrderCubit>();
  final cartCubit = context.read<CartCubit>();

  final paymentInfo = PaymentInfo(
    method: _paymentMethod,
    cardLastFour: _cardNumber.length > 4
        ? _cardNumber.substring(_cardNumber.length - 4)
        : '0000',
    transactionId: 'TXN-${DateTime.now().millisecondsSinceEpoch}',
  );

  try {
    await checkoutCubit.placeOrder(
      items: items,
      total: total,
      shippingInfo: _shippingInfo,
      paymentInfo: paymentInfo,
    );

    final cartState = cartCubit.state;
    if (cartState is CartLoaded && cartState.cartId != null) {
      final cartId = cartState.cartId!;

      // تأكيد نجاح الإرسال إلى الباك إند
      await orderCubit.addOrderFromBackend(
        cartId,
        {
          'name': _shippingInfo.name,
          'address': _shippingInfo.address,
          'city': _shippingInfo.city,
          'state': _shippingInfo.state,
          'zipCode': _shippingInfo.zipCode,
          'phone': _shippingInfo.phone,
          'email': _shippingInfo.email,
        },
          cartCubit,
      );

      print('✅ Order sent to backend successfully.');

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cart not available for checkout.')),
      );
    }
  } catch (e) {
    print('❌ Error during checkout: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Checkout failed: $e')),
    );
  }
}

}