// ignore_for_file: deprecated_member_use

import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/core/utils/app_colors.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/core/widgets/custom_button.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';
import 'package:pickpay/features/checkout/presentation/views/checkout_view.dart';
import 'package:pickpay/features/cart/cart_cubits/cart_cubit.dart';
import 'package:pickpay/features/cart/cart_item_model.dart';

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
        actions: [
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state is CartLoaded && state.cartItems.isNotEmpty) {
                return IconButton(
                  icon: const Icon(Icons.delete_sweep),
                  onPressed: () => context.read<CartCubit>().clearCart(),
                  tooltip: 'Clear Cart',
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          try {
            if (state is CartError) {
              _showMessage(context, state.message, CartAction.error);
              dev.log('Cart Error: ${state.message}', name: 'CartView');
            } else if (state is CartLoaded && state.message != null) {
              _showMessage(
                  context, state.message!, state.action ?? CartAction.updated);
              dev.log('Cart Action: ${state.action} - ${state.message}',
                  name: 'CartView');
            }
          } catch (e, stackTrace) {
            dev.log('Error in cart listener: $e\n$stackTrace',
                name: 'CartView', error: e);
          }
        },
        builder: (context, state) {
          try {
            if (state is CartLoading) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Updating cart...'),
                  ],
                ),
              );
            }

            if (state is CartError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48,
                      color: isDarkMode ? Colors.red[300] : Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: TextStyle(
                        color: isDarkMode ? Colors.red[300] : Colors.red,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () => context.read<CartCubit>().getCart(),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is CartInitial ||
                (state is CartLoaded && state.cartItems.isEmpty)) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 64,
                      color: isDarkMode ? Colors.grey[400] : Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Your cart is empty",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Add some items to get started",
                      style: TextStyle(
                        fontSize: 16,
                        color: isDarkMode ? Colors.grey[500] : Colors.grey[500],
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/main-navigation'),
                      icon: const Icon(Icons.shopping_bag),
                      label: const Text('Start Shopping'),
                    ),
                  ],
                ),
              );
            }

            final cartItems = (state as CartLoaded).cartItems;
            final totalPrice = cartItems.fold<double>(
              0,
              (sum, item) => sum + item.product.price * item.quantity,
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
                          color:
                              isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                      if (cartItems.isNotEmpty)
                        TextButton.icon(
                          onPressed: () =>
                              context.read<CartCubit>().clearCart(),
                          icon: const Icon(Icons.delete_sweep),
                          label: const Text('Clear Cart'),
                          style: TextButton.styleFrom(
                            foregroundColor:
                                isDarkMode ? Colors.red[300] : Colors.red,
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
                      return _buildCartItem(context, item, isDarkMode);
                    },
                  ),
                ),

                const SizedBox(height: 8),
                // Total and Checkout Section
                _buildTotalSection(context, totalPrice, isDarkMode),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      return CustomButton(
                        onPressed: state is CartLoading
                            ? null
                            : () {
                                try {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CheckoutView(),
                                    ),
                                  );
                                } catch (e, stackTrace) {
                                  dev.log(
                                      'Error navigating to checkout: $e\n$stackTrace',
                                      name: 'CartView',
                                      error: e);
                                  _showMessage(
                                      context,
                                      'Failed to navigate to checkout',
                                      CartAction.error);
                                }
                              },
                        buttonText: 'Proceed to Checkout',
                        isLoading: state is CartLoading,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],
            );
          } catch (e, stackTrace) {
            dev.log('Error building cart view: $e\n$stackTrace',
                name: 'CartView', error: e);
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: isDarkMode ? Colors.red[300] : Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'An error occurred. Please try again.',
                    style: TextStyle(
                      color: isDarkMode ? Colors.red[300] : Colors.red,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => context.read<CartCubit>().getCart(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildCartItem(
      BuildContext context, CartItemModel item, bool isDarkMode) {
    try {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDarkMode ? 0.2 : 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              if (item.product.id.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailView(
                      product: item.product,
                    ),
                  ),
                );
              } else {
                _showMessage(
                    context, 'Product details not available', CartAction.error);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image with loading and error states
                  Hero(
                    tag: 'product-${item.product.id}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.grey[800] : Colors.grey[100],
                        ),
                        child: Builder(
                          builder: (context) {
                            final product = item.product;
                            final paths = product.imagePaths;
                            final productJson = product.toJson();
                            String? imageCover = productJson['imageCover'] as String?;
                            print('Cart product: ' + productJson.toString());
                            print('Cart product imagePaths: $paths, imageCover: $imageCover');
                            String? path;
                            if (paths != null && paths.isNotEmpty && paths.first.isNotEmpty) {
                              path = paths.first;
                            } else if (imageCover != null && imageCover.isNotEmpty) {
                              path = imageCover;
                            } else {
                              path = null;
                            }
                            print('Cart image path selected: $path');
                            if (path == null) {
                              return Icon(
                                Icons.image_not_supported,
                                color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
                                size: 32,
                              );
                            }
                            if (path.startsWith('http')) {
                              return Image.network(
                                path,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes!
                                          : null,
                                      strokeWidth: 2,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  print('Network image error: $error');
                                  return Icon(
                                    Icons.image_not_supported,
                                    color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
                                    size: 32,
                                  );
                                },
                              );
                            } else {
                              return Image.asset(
                                path,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  print('Asset image error: $error');
                                  return Icon(
                                    Icons.image_not_supported,
                                    color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
                                    size: 32,
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.product.title,
                          style: TextStyles.semiBold16.copyWith(
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '\$${item.product.price.toStringAsFixed(2)}',
                          style: TextStyles.semiBold16.copyWith(
                            color: AppColors.primaryColor,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Quantity Controls
                            Container(
                              decoration: BoxDecoration(
                                color: isDarkMode
                                    ? Colors.grey[800]
                                    : Colors.grey[100],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      if (item.product.id.isNotEmpty) {
                                        if (item.quantity > 1) {
                                          context
                                              .read<CartCubit>()
                                              .updateCartItemQuantity(
                                                item.product.id,
                                                item.quantity - 1,
                                              );
                                        } else {
                                          context
                                              .read<CartCubit>()
                                              .removeFromCart(item.product.id);
                                        }
                                      }
                                    },
                                    color: isDarkMode
                                        ? Colors.grey[400]
                                        : Colors.grey[600],
                                    iconSize: 20,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Text(
                                      '${item.quantity}',
                                      style: TextStyles.semiBold16,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      if (item.product.id.isNotEmpty) {
                                        context
                                            .read<CartCubit>()
                                            .updateCartItemQuantity(
                                              item.product.id,
                                              item.quantity + 1,
                                            );
                                      }
                                    },
                                    color: isDarkMode
                                        ? Colors.grey[400]
                                        : Colors.grey[600],
                                    iconSize: 20,
                                  ),
                                ],
                              ),
                            ),
                            // Remove Button
                            IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () {
                                if (item.product.id.isNotEmpty) {
                                  context
                                      .read<CartCubit>()
                                      .removeFromCart(item.product.id);
                                }
                              },
                              color: isDarkMode ? Colors.red[300] : Colors.red,
                              iconSize: 24,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } catch (e, stackTrace) {
      dev.log('Error building cart item: $e\n$stackTrace',
          name: 'CartView', error: e);
      return const SizedBox.shrink();
    }
  }

  Widget _buildTotalSection(
      BuildContext context, double totalPrice, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.2 : 0.05),
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyles.semiBold16.copyWith(
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  fontSize: 18,
                ),
              ),
              Text(
                '\$${totalPrice.toStringAsFixed(2)}',
                style: TextStyles.bold19.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Shipping and taxes calculated at checkout',
            style: TextStyles.regular13.copyWith(
              color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  void _showMessage(BuildContext context, String message, CartAction action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: action == CartAction.error ? Colors.red : Colors.green,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
