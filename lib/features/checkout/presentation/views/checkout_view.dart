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

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});
  static const routeName = 'checkout';

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  static const double shippingFee = 30.0; // Shipping fee in EGP
  final _formKey = GlobalKey<FormState>();
  final _shippingFormKey = GlobalKey<ShippingInfoFormState>();
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
    final subtotal = items.fold<double>(
      0,
      (sum, item) => sum + item.product.price * item.quantity,
    );
    final total = subtotal + shippingFee;
    final checkoutCubit = context.read<CheckoutCubit>();
    checkoutCubit.updateTotal(total);

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
            final checkoutState = context.read<CheckoutCubit>().state;
            double? discount;
            double? totalAfterDiscount;
            if (checkoutState is CheckoutData) {
              discount = checkoutState.discount;
              totalAfterDiscount = checkoutState.totalAfterDiscount;
            }
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderConfirmationView(
                      order: state.order,
                      discount: discount,
                      totalAfterDiscount: totalAfterDiscount),
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
                BlocBuilder<CheckoutCubit, CheckoutState>(
                  builder: (context, state) {
                    final baseTotal = subtotal + shippingFee;
                    final totalToShow = (state is CheckoutData &&
                            state.totalAfterDiscount != null)
                        ? state.totalAfterDiscount!
                        : baseTotal;

                    return _buildOrderSummary(items, subtotal, shippingFee,
                        totalToShow, theme, state);
                  },
                ),
                const SizedBox(height: 30),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: _buildSectionTitle('Shipping Information', theme),
                ),
                ShippingInfoForm(
                  key: _shippingFormKey,
                  onSaved: (info) {
                    setState(() {
                      _shippingInfo = info;
                    });
                  },
                ),
                if (_shippingInfo.name.isNotEmpty ||
                    _shippingInfo.address.isNotEmpty)
                  Card(
                    margin: const EdgeInsets.only(top: 16),
                    child: ListTile(
                      title: Text('Shipping To: \\${_shippingInfo.name}'),
                      subtitle: Text(
                        '\\${_shippingInfo.address}, \\${_shippingInfo.city}, \\${_shippingInfo.state}, \\${_shippingInfo.zipCode}\nPhone: \\${_shippingInfo.phone}\nEmail: \\${_shippingInfo.email}',
                      ),
                    ),
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
                  onApply: (code) async {
                    try {
                      final cartCubit = context.read<CartCubit>();
                      final checkoutCubit = context.read<CheckoutCubit>();

                      final discount = await cartCubit.applyCoupon(code);

                      if (discount > 0) {
                        checkoutCubit.applyCoupon(
                            discount: discount, couponCode: code);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Promo code "$code" applied successfully! You saved EGP ${discount.toStringAsFixed(2)}'),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      } else {
                        // Handle case where coupon is valid but no discount applied
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Promo code "$code" applied but no discount was available'),
                            backgroundColor: Colors.orange,
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      }
                    } catch (e) {
                      String errorMessage = 'Failed to apply promo code';

                      // Handle specific error cases
                      if (e.toString().contains('Invalid coupon') ||
                          e.toString().contains('Coupon not found')) {
                        errorMessage =
                            'Invalid promo code. Please check and try again.';
                      } else if (e.toString().contains('Expired') ||
                          e.toString().contains('expired')) {
                        errorMessage =
                            'This promo code has expired. Please try another code.';
                      } else if (e.toString().contains('Already used') ||
                          e.toString().contains('already applied')) {
                        errorMessage = 'This promo code has already been used.';
                      } else if (e.toString().contains('Minimum order') ||
                          e.toString().contains('minimum amount')) {
                        errorMessage =
                            'This promo code requires a minimum order amount.';
                      } else {
                        errorMessage =
                            'Failed to apply promo code: ${e.toString()}';
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(errorMessage),
                          backgroundColor: Theme.of(context).colorScheme.error,
                          duration: const Duration(seconds: 4),
                        ),
                      );
                    }
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
                              ? null
                              : () async {
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
                                  // Always get the latest shipping info from the form
                                  setState(() {
                                    _shippingInfo = _shippingFormKey
                                            .currentState
                                            ?.getCurrentInfo() ??
                                        _shippingInfo;
                                  });
                                  _processCheckout(context, items, subtotal);
                                },
                          buttonText: state is CheckoutLoading
                              ? 'Processing...'
                              : 'Place Order (EGP ${state is CheckoutData ? (state.totalAfterDiscount ?? state.total).toStringAsFixed(2) : total.toStringAsFixed(2)})',
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
    List<CartItemModel> items,
    double subtotal,
    double shippingFee,
    double total,
    ThemeData theme,
    CheckoutState state,
  ) {
    double? discount;
    if (state is CheckoutData) {
      discount = state.discount;
    }

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
                    'Subtotal',
                    style: TextStyles.bold16.copyWith(
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                ),
                Text(
                  'EGP ${subtotal.toStringAsFixed(2)}',
                  style: TextStyles.bold16.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Shipping',
                    style: TextStyles.regular13.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                Text(
                  '+ EGP ${shippingFee.toStringAsFixed(2)}',
                  style: TextStyles.regular13.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            if (discount != null && discount > 0) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          'Discount',
                          style: TextStyles.regular13.copyWith(
                            color: theme.colorScheme.error,
                          ),
                        ),
                        if (state is CheckoutData &&
                            state.couponCode != null) ...[
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.error.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              state.couponCode!,
                              style: TextStyles.semiBold11.copyWith(
                                color: theme.colorScheme.error,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Text(
                    '- EGP ${discount.toStringAsFixed(2)}',
                    style: TextStyles.regular13.copyWith(
                      color: theme.colorScheme.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
            const Divider(height: 24),
            Row(
              children: [
                Expanded(
                  child: Text(
                    discount != null && discount > 0
                        ? 'Total After Discount'
                        : 'Total',
                    style: TextStyles.bold16.copyWith(
                      color: theme.colorScheme.primary,
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
            if (discount != null && discount > 0) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: theme.colorScheme.error.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.savings_outlined,
                      size: 16,
                      color: theme.colorScheme.error,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'You saved EGP ${discount.toStringAsFixed(2)}!',
                        style: TextStyles.bold13.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Future<void> _processCheckout(
    BuildContext context,
    List<CartItemModel> items,
    double subtotal,
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
    final checkoutState = context.read<CheckoutCubit>().state;
    final totalToSend = checkoutState is CheckoutData
        ? (checkoutState.totalAfterDiscount ?? checkoutState.total)
        : subtotal + shippingFee;

    try {
      await checkoutCubit.placeOrder(
        items: items,
        total: totalToSend,
        shippingInfo: _shippingInfo,
        paymentInfo: paymentInfo,
        cartCubit: context.read<CartCubit>(),
      );

      final cartState = cartCubit.state;
      if (cartState is CartLoaded && cartState.cartId != null) {
        final cartId = cartState.cartId!;
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
        await orderCubit.loadOrders();
      }
    } catch (e) {
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
  String? _successMessage;
  bool _isLoading = false;
  bool _isApplied = false;

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
        _successMessage = null;
      });
      return;
    }

    setState(() {
      _error = null;
      _successMessage = null;
      _isLoading = true;
    });

    try {
      await widget.onApply(code);
      setState(() {
        _isApplied = true;
        _successMessage = 'Promo code applied successfully!';
      });

      // Clear success message after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _successMessage = null;
          });
        }
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isApplied = false;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _clearPromoCode() {
    _promoController.clear();
    setState(() {
      _error = null;
      _successMessage = null;
      _isApplied = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Enhanced background colors for both modes
    final textFieldBgColor = isDarkMode
        ? theme.colorScheme.surfaceVariant.withOpacity(0.8)
        : theme.colorScheme.surfaceVariant.withOpacity(0.4);

    final focusedBorderColor =
        _isApplied ? Colors.green : theme.colorScheme.primary;
    final unfocusedBorderColor = _isApplied
        ? Colors.green.withOpacity(0.5)
        : (isDarkMode
            ? theme.dividerColor.withOpacity(0.3)
            : theme.dividerColor.withOpacity(0.2));

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
                color: _isApplied ? Colors.green : theme.colorScheme.primary,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _promoController,
                  enabled: !_isApplied,
                  decoration: InputDecoration(
                    hintText:
                        _isApplied ? 'Promo code applied' : 'Enter promo code',
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
                              _isApplied ? Icons.check_circle : Icons.clear,
                              color: _isApplied
                                  ? Colors.green
                                  : theme.colorScheme.onSurface
                                      .withOpacity(0.5),
                            ),
                            onPressed: _isApplied ? null : _clearPromoCode,
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
                  onPressed: _isLoading || _isApplied ? null : _applyPromo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _isApplied ? Colors.green : theme.colorScheme.primary,
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
                      : _isApplied
                          ? const Icon(Icons.check, size: 20)
                          : const Text('Apply'),
                ),
              ),
            ],
          ),
          if (_error != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: theme.colorScheme.error.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 16,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _error!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (_successMessage != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.green.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 16,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _successMessage!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
