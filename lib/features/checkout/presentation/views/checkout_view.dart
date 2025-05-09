import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/core/utils/app_colors.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/core/widgets/custom_app.dart';
import 'package:pickpay/core/widgets/custom_button.dart';
import 'package:pickpay/features/checkout/domain/models/checkout_model.dart';
import 'package:pickpay/features/checkout/presentation/cubits/cubit/checkout_cubit.dart';
import 'package:pickpay/features/checkout/presentation/views/widgets/order_conformation.dart';
import 'package:pickpay/features/checkout/presentation/views/widgets/payment_section.dart';
import 'package:pickpay/features/checkout/presentation/views/widgets/shipping_section.dart';
import 'package:pickpay/features/home/domain/models/cart_item_model.dart';
import 'package:pickpay/features/home/presentation/cubits/cart_cubits/cart_cubit.dart';

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
    final cartCubit = context.read<CartCubit>();
    final cartState = cartCubit.state;

    if (cartState is! CartLoaded || cartState.items.isEmpty) {
      return Scaffold(
        appBar: buildAppBar(context: context, title: 'Checkout'),
        body: const Center(
          child: Text('Your cart is empty'),
        ),
      );
    }

    final items = cartState.items;
    final total = items.fold<double>(
      0,
      (sum, item) => sum + (item.product.price ?? 0) * item.quantity,
    );

    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Checkout'),
      body: BlocListener<CheckoutCubit, CheckoutState>(
        listener: (context, state) {
          if (state is CheckoutSuccess) {
            // Clear cart on successful checkout
            cartCubit.clearCart();

            // Navigate to order confirmation
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => OrderConfirmationView(order: state.order),
              ),
            );
          } else if (state is CheckoutError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
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
                // Order Summary
                _buildSectionTitle('Order Summary'),
                _buildOrderSummary(items, total),
                const SizedBox(height: 24),

                // Shipping Information
                _buildSectionTitle('Shipping Information'),
                ShippingInfoForm(
                  onSaved: (info) => _shippingInfo = info,
                ),
                const SizedBox(height: 24),

                // Payment Method
                _buildSectionTitle('Payment Method'),
                PaymentMethodSelector(
                  onMethodSelected: (method) => _paymentMethod = method,
                  onCardDetailsSaved: (number, expiry, cvv) {
                    _cardNumber = number;
                    _expiryDate = expiry;
                    _cvv = cvv;
                  },
                ),
                const SizedBox(height: 32),

                // Checkout Button
                BlocBuilder<CheckoutCubit, CheckoutState>(
                  builder: (context, state) {
                    return CustomButton(
                      onPressed: state is CheckoutLoading
                          ? () {} // Empty function instead of null
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyles.bold16.copyWith(color: AppColors.primaryColor),
      ),
    );
  }

  Widget _buildOrderSummary(List<CartItemModel> items, double total) {
    return Card(
      color: const Color.fromARGB(255, 243, 243, 243),
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
                          style: TextStyles.regular13,
                        ),
                      ),
                      Text(
                        'EGP ${(item.product.price * item.quantity).toStringAsFixed(2)}',
                        style: TextStyles.semiBold11,
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
                    style: TextStyles.bold16,
                  ),
                ),
                Text(
                  'EGP ${total.toStringAsFixed(2)}',
                  style: TextStyles.bold16.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _processCheckout(
    BuildContext context,
    List<CartItemModel> items,
    double total,
  ) {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    // Simulate payment processing
    final paymentInfo = PaymentInfo(
      method: _paymentMethod,
      cardLastFour: _cardNumber.length > 4
          ? _cardNumber.substring(_cardNumber.length - 4)
          : '0000',
      transactionId: 'TXN-${DateTime.now().millisecondsSinceEpoch}',
    );

    context.read<CheckoutCubit>().placeOrder(
          items: items,
          total: total,
          shippingInfo: _shippingInfo,
          paymentInfo: paymentInfo,
        );
  }
}
