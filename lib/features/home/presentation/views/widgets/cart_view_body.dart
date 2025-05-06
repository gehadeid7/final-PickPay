import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/core/utils/app_colors.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/core/widgets/custom_app.dart';
import 'package:pickpay/core/widgets/custom_button.dart';
import 'package:pickpay/features/home/presentation/cubits/cubit/cart_cubit.dart';

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

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
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
                                  errorBuilder: (context, error, stackTrace) =>
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
                                    "Price: \EGP ${item.product.price?.toStringAsFixed(2) ?? '0.00'}",
                                    style: TextStyles.semiBold13.copyWith(
                                        color: AppColors.primaryColor)),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 32,
                                      width: 32,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 183, 183, 183),
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
                                        onPressed: () {
                                          final newQty = item.quantity - 1;
                                          context
                                              .read<CartCubit>()
                                              .updateQuantity(
                                                  item.product.id, newQty);
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text("${item.quantity}",
                                        style: TextStyles.bold16),
                                    const SizedBox(width: 10),
                                    Container(
                                      height: 32,
                                      width: 32,
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
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors.redAccent),
                            onPressed: () {
                              context
                                  .read<CartCubit>()
                                  .removeFromCart(item.product.id);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total: \EGP ${totalPrice.toStringAsFixed(2)}",
                      style: TextStyles.bold19.copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: CustomButton(onPressed: () {}, buttonText: 'Checkout'),
              )
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
