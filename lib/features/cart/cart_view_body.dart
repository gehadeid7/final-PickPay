// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/core/utils/app_colors.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/core/widgets/custom_button.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';
import 'package:pickpay/features/checkout/presentation/views/checkout_view.dart';
import 'package:pickpay/features/cart/cart_cubits/cart_cubit.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: 'Your Cart',
        onBackPressed: () {
          Navigator.pushNamed(context, '/main-navigation');
        },
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartLoaded && state.action != null) {
            switch (state.action!) {
              case CartAction.added:
                _showMessage(
                    context, "Product added to cart", CartAction.added);
                break;
              case CartAction.removed:
                _showMessage(
                    context, "Product removed from cart", CartAction.removed);
                break;
              case CartAction.updated:
                _showMessage(
                    context, "Product quantity updated", CartAction.updated);
                break;
            }
          }
        },
        builder: (context, state) {
          if (state is CartInitial ||
              (state is CartLoaded && state.items.isEmpty)) {
            return Center(
              child: Text(
                "Your cart is empty.",
                style: TextStyle(
                  fontSize: 18,
                  color: isDarkMode ? Colors.grey[400] : Colors.grey,
                ),
              ),
            );
          }

          final cartItems = (state as CartLoaded).items;
          final totalPrice = cartItems.fold<double>(
            0,
            (sum, item) => sum + (item.product.price ?? 0) * item.quantity,
          );
          final totalItems = cartItems.fold<int>(
            0,
            (sum, item) => sum + item.quantity,
          );

          return Column(
            children: [
              // Cart Header with item count
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      totalItems == 1
                          ? "You have 1 item in your cart"
                          : "You have $totalItems items in your cart",
                      style: TextStyles.semiBold16.copyWith(
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
                indent: 16,
                endIndent: 16,
                color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
              ),

              // Product List
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailView(product: item.product),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              isDarkMode ? theme.cardTheme.color : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 82, 82, 82)
                                  // ignore: deprecated_member_use
                                  .withOpacity(isDarkMode ? 0.1 : 0.05),
                              spreadRadius: 6,
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          border: Border.all(
                            color: isDarkMode
                                ? Colors.grey.shade700
                                : Colors.grey.shade200,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Image
                            if (item.product.imagePaths != null &&
                                item.product.imagePaths!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    item.product.imagePaths![0],
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                      width: 80,
                                      height: 80,
                                      color: isDarkMode
                                          ? Colors.grey[800]
                                          : Colors.grey.shade200,
                                      child: Icon(
                                        Icons.image_not_supported,
                                        color: isDarkMode
                                            ? Colors.grey[400]
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.product.title ?? "Unnamed Product",
                                    style: TextStyles.bold16.copyWith(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Price: EGP ${item.product.price?.toStringAsFixed(2) ?? '0.00'}",
                                    style: TextStyles.semiBold13.copyWith(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: IconButton(
                                    icon: Icon(Icons.delete,
                                        color: Colors.redAccent),
                                    onPressed: () {
                                      context
                                          .read<CartCubit>()
                                          .removeFromCart(item.product.id);
                                    },
                                  ),
                                ),
                                Row(
                                  children: [
                                    // Decrease quantity button
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: item.quantity > 1
                                            ? (isDarkMode
                                                ? Colors.grey[700]
                                                : const Color(0xFFB7B7B7))
                                            : Colors.grey.shade400,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            offset: const Offset(0, 2),
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                      child: IconButton(
                                        icon: const Icon(Icons.remove),
                                        iconSize: 16,
                                        color: Colors.white,
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        onPressed: item.quantity > 1
                                            ? () {
                                                final newQty =
                                                    item.quantity - 1;
                                                context
                                                    .read<CartCubit>()
                                                    .updateQuantity(
                                                        item.product.id,
                                                        newQty);
                                              }
                                            : null,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "${item.quantity}",
                                      style: TextStyles.bold16.copyWith(
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    // Increase quantity button
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            offset: const Offset(0, 2),
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                      child: IconButton(
                                        icon: const Icon(Icons.add),
                                        iconSize: 16,
                                        color: Colors.white,
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        onPressed: () {
                                          final newQty = item.quantity + 1;
                                          context
                                              .read<CartCubit>()
                                              .updateQuantity(
                                                  item.product.id, newQty);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 8),
              // Total and Checkout Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isDarkMode ? Colors.grey.shade700 : Colors.white,
                    ),
                    color: isDarkMode
                        ? Colors.grey[800]!.withOpacity(0.5)
                        : const Color.fromARGB(83, 217, 217, 217),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyles.bold16.copyWith(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      children: [
                        const TextSpan(text: "Subtotal"),
                        const WidgetSpan(child: SizedBox(width: 20)),
                        TextSpan(
                          text: "EGP ${totalPrice.toStringAsFixed(2)}",
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(CheckoutView.routeName);
                  },
                  buttonText: 'Checkout',
                ),
              ),
              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }

  void _showMessage(BuildContext context, String message, CartAction action) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    Color backgroundColor;
    Icon icon;

    switch (action) {
      case CartAction.added:
        backgroundColor = Colors.green.shade600;
        icon = const Icon(Icons.check_circle, color: Colors.white, size: 20);
        break;
      case CartAction.removed:
        backgroundColor = Colors.red.shade600;
        icon = const Icon(Icons.delete, color: Colors.white, size: 20);
        break;
      case CartAction.updated:
        backgroundColor = Colors.blue.shade600;
        icon = const Icon(Icons.update, color: Colors.white, size: 20);
        break;
    }

    // Create an OverlayEntry for the centered message
    OverlayEntry? overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon,
                const SizedBox(width: 12),
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Insert the overlay
    Overlay.of(context).insert(overlayEntry);

    // Remove the overlay after 3 seconds
    Future.delayed(const Duration(seconds: 1), () {
      overlayEntry?.remove();
    });
  }
}
