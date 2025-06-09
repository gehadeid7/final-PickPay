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

  final _scrollController = ScrollController();
  String? _errorSummary;

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.remove_shopping_cart,
                  size: 64, color: theme.colorScheme.primary.withOpacity(0.2)),
              const SizedBox(height: 16),
              Text(
                'Your cart is empty',
                style: TextStyles.bold16.copyWith(
                  color: theme.colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Add items to your cart to start checkout.',
                style: TextStyles.regular13.copyWith(
                  color: theme.colorScheme.onBackground.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final items = cartState.cartItems;
    final total = items.fold<double>(
      0,
      (sum, item) => sum + item.product.price * item.quantity,
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
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_errorSummary != null)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline,
                            color: theme.colorScheme.error),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _errorSummary!,
                            style: TextStyle(color: theme.colorScheme.error),
                          ),
                        ),
                      ],
                    ),
                  ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: _buildSectionTitle('Order Summary', theme),
                ),
                _buildOrderSummary(items, total, theme),
                const SizedBox(height: 30),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: _buildSectionTitle('Shipping Information', theme),
                ),
                ShippingInfoForm(
                  onSaved: (info) => _shippingInfo = info,
                ),
                const SizedBox(height: 24),
                Divider(
                    thickness: 1, color: theme.dividerColor.withOpacity(0.15)),
                const SizedBox(height: 24),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: _buildSectionTitle('Payment Method', theme),
                ),
                PaymentMethodSelector(
                  onMethodSelected: (method) => _paymentMethod = method,
                  onCardDetailsSaved: (number, expiry, cvv) {
                    _cardNumber = number;
                    _expiryDate = expiry;
                    _cvv = cvv;
                  },
                ),
                const SizedBox(height: 15),
                PromoCodeSection(
                  onApply: (code) {
                    // Handle the promo code logic here
                    // For example, show a snackbar for now
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Promo code "$code" applied!')),
                    );
                  },
                ),
                const SizedBox(height: 32),
                BlocBuilder<CheckoutCubit, CheckoutState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomButton(
                          onPressed: state is CheckoutLoading
                              ? () {}
                              : () async {
                                  // Auto-trim all text fields before validation
                                  FocusScope.of(context).unfocus();
                                  _errorSummary = null;
                                  bool valid =
                                      _formKey.currentState!.validate();
                                  if (!valid) {
                                    setState(() {
                                      _errorSummary =
                                          'Please fill all required fields correctly.';
                                    });
                                    await Future.delayed(
                                        const Duration(milliseconds: 100));
                                    _scrollController.animateTo(0,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut);
                                    return;
                                  }
                                  _formKey.currentState!.save();
                                  _processCheckout(context, items, total);
                                },
                          buttonText: state is CheckoutLoading
                              ? 'Processing...'
                              : 'Place Order (EGP ${total.toStringAsFixed(2)})',
                        ),
                        if (state is CheckoutLoading)
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: LinearProgressIndicator(minHeight: 3),
                          ),
                      ],
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
        cartCubit: context.read<CartCubit>(),
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
        // No UI message shown if cart not available for checkout
      }
    } catch (e) {
      print('❌ Error during checkout: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Checkout failed: $e')),
      );
    }
  }
}

class PromoCodeSection extends StatefulWidget {
  final Function(String) onApply;
  final String? initialCode;

  const PromoCodeSection({
    super.key,
    required this.onApply,
    this.initialCode,
  });

  @override
  State<PromoCodeSection> createState() => _PromoCodeSectionState();
}

class _PromoCodeSectionState extends State<PromoCodeSection> {
  final _promoController = TextEditingController();
  String? _error;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialCode != null) {
      _promoController.text = widget.initialCode!;
    }
  }

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  Future<void> _applyPromo() async {
    final code = _promoController.text.trim();

    if (code.isEmpty) {
      setState(() {
        _error = 'Please enter a promo code';
      });
      return;
    }

    setState(() {
      _error = null;
      _isLoading = true;
    });

    try {
      await widget.onApply(code);
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Enhanced background colors for both modes
    final textFieldBgColor = isDarkMode
        ? theme.colorScheme.surfaceVariant.withOpacity(0.8)
        : theme.colorScheme.surfaceVariant.withOpacity(0.4);

    final focusedBorderColor = theme.colorScheme.primary;
    final unfocusedBorderColor = isDarkMode
        ? theme.dividerColor.withOpacity(0.3)
        : theme.dividerColor.withOpacity(0.2);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Promo Code',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.local_offer_outlined,
                size: 18,
                color: theme.colorScheme.primary,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _promoController,
                  decoration: InputDecoration(
                    hintText: 'Enter promo code',
                    hintStyle: TextStyle(
                      color:
                          theme.hintColor.withOpacity(isDarkMode ? 0.6 : 0.7),
                    ),
                    errorText: _error,
                    errorMaxLines: 2,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: unfocusedBorderColor,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: unfocusedBorderColor,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: focusedBorderColor,
                        width: 1.5,
                      ),
                    ),
                    filled: true,
                    fillColor: textFieldBgColor,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    suffixIcon: _promoController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(
                              Icons.clear,
                              color:
                                  theme.colorScheme.onSurface.withOpacity(0.5),
                            ),
                            onPressed: () {
                              _promoController.clear();
                              setState(() {
                                _error = null;
                              });
                            },
                          )
                        : null,
                  ),
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                  onSubmitted: (_) => _applyPromo(),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _applyPromo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    elevation: 0,
                    shadowColor: Colors.transparent,
                  ),
                  child: _isLoading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: theme.colorScheme.onPrimary,
                          ),
                        )
                      : const Text('Apply'),
                ),
              ),
            ],
          ),
          if (_error != null) ...[
            const SizedBox(height: 8),
            Text(
              _error!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
