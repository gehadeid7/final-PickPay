import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/core/utils/app_colors.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/core/widgets/custom_app.dart';
import 'package:pickpay/core/widgets/custom_button.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';
import 'package:pickpay/features/checkout/presentation/views/checkout_view.dart';
import 'package:pickpay/features/home/presentation/cubits/cart_cubits/cart_cubit.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Your Cart'),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartLoaded) {
            if (state.action == CartAction.added) {
              _showMessage(context, "Product added to cart");
            } else if (state.action == CartAction.removed) {
              _showMessage(context, "Product removed from cart");
            }
          }
        },
        builder: (context, state) {
          if (state is CartInitial ||
              (state is CartLoaded && state.items.isEmpty)) {
            return const Center(
              child: Text(
                "Your cart is empty.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
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
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, thickness: 1, indent: 16, endIndent: 16),

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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
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
                                      color: Colors.grey.shade200,
                                      child:
                                          const Icon(Icons.image_not_supported),
                                    ),
                                  ),
                                ),
                              ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.product.title ?? "Unnamed Product",
                                      style: TextStyles.bold16),
                                  const SizedBox(height: 4),
                                  Text(
                                      "Price: EGP ${item.product.price?.toStringAsFixed(2) ?? '0.00'}",
                                      style: TextStyles.semiBold13.copyWith(
                                          color: AppColors.primaryColor)),
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
                                    icon: const Icon(Icons.delete,
                                        color: Colors.redAccent),
                                    onPressed: () {
                                      context
                                          .read<CartCubit>()
                                          .removeFromCart(item.product.id);
                                    },
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 183, 183, 183),
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        // ignore: deprecated_member_use
                                        color: Colors.black.withOpacity(0.2),
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
                                    onPressed: () {
                                      final newQty = item.quantity - 1;
                                      context.read<CartCubit>().updateQuantity(
                                          item.product.id, newQty);
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text("${item.quantity}",
                                    style: TextStyles.bold16),
                                const SizedBox(width: 10),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        // ignore: deprecated_member_use
                                        color: Colors.black.withOpacity(0.2),
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
                                      context.read<CartCubit>().updateQuantity(
                                          item.product.id, newQty);
                                    },
                                  ),
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
                    color: const Color.fromARGB(83, 217, 217, 217),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyles.bold16.copyWith(
                        color: const Color.fromARGB(255, 69, 69, 69),
                      ),
                      children: [
                        const TextSpan(text: "Subtotal"),
                        const WidgetSpan(child: SizedBox(width: 20)),
                        TextSpan(
                          text: "EGP ${totalPrice.toStringAsFixed(2)}",
                          style: const TextStyle(color: Colors.black),
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
                    buttonText: 'Checkout'),
              ),
              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }
}
