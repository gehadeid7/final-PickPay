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
                        height: 120,
                        decoration: BoxDecoration(
                          color:
                              isDarkMode ? Colors.grey[800] : Colors.grey[100],
                        ),
                        child: _buildProductImage(item, isDarkMode),
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

  Widget _buildProductImage(CartItemModel item, bool isDarkMode) {
    // Try to get image paths from the product
    final imagePaths = item.product.imagePaths;
    if (imagePaths != null && imagePaths.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          imagePaths[0],
          width: 80,
          height: 80,
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 80,
              height: 80,
              color: isDarkMode ? Colors.grey[850] : Colors.grey[100],
              child: Icon(
                Icons.error_outline,
                color: isDarkMode ? Colors.grey[700] : Colors.grey[400],
              ),
            );
          },
        ),
      );
    }

    // If no image paths, try to get a static image based on product ID
    final id = item.product.id;
    String? staticPath;

    // Define image path mappings for each category
    final Map<String, Map<String, String>> categoryImagePaths = {
      'fashion': {
        '682b00c26977bd89257c0e8e':
            'assets/Fashion_products/Women_Fashion/women_fashion1/1.png',
        '682b00c26977bd89257c0e8f':
            'assets/Fashion_products/Women_Fashion/women_fashion2/1.png',
        '682b00c26977bd89257c0e90':
            'assets/Fashion_products/Women_Fashion/women_fashion3/1.png',
        '682b00c26977bd89257c0e91':
            'assets/Fashion_products/Women_Fashion/women_fashion4/1.png',
        '682b00c26977bd89257c0e92':
            'assets/Fashion_products/Women_Fashion/women_fashion5/1.png',
        '682b00c26977bd89257c0e93':
            'assets/Fashion_products/Men_Fashion/men_fashion1/navy/1.png',
        '682b00c26977bd89257c0e94':
            'assets/Fashion_products/Men_Fashion/men_fashion2/light_blue/1.png',
        '682b00c26977bd89257c0e95':
            'assets/Fashion_products/Men_Fashion/men_fashion3/1.png',
        '682b00c26977bd89257c0e96':
            'assets/Fashion_products/Men_Fashion/men_fashion4/black/1.png',
        '682b00c26977bd89257c0e97':
            'assets/Fashion_products/Men_Fashion/men_fashion5/1.png',
        '682b00c26977bd89257c0e98':
            'assets/Fashion_products/Kids_Fashion/kids_fashion1/1.png',
        '682b00c26977bd89257c0e99':
            'assets/Fashion_products/Kids_Fashion/kids_fashion2/1.png',
        '682b00c26977bd89257c0e9a':
            'assets/Fashion_products/Kids_Fashion/kids_fashion3/1.png',
        '682b00c26977bd89257c0e9b':
            'assets/Fashion_products/Kids_Fashion/kids_fashion4/1.png',
        '682b00c26977bd89257c0e9c':
            'assets/Fashion_products/Kids_Fashion/kids_fashion5/1.png',
      },
      'beauty': {
        '682b00d16977bd89257c0e9d': 'assets/beauty_products/makeup_1/1.png',
        '682b00d16977bd89257c0e9e': 'assets/beauty_products/makeup_2/1.png',
        '682b00d16977bd89257c0e9f': 'assets/beauty_products/makeup_3/1.png',
        '682b00d16977bd89257c0ea0': 'assets/beauty_products/makeup_4/1.png',
        '682b00d16977bd89257c0ea1': 'assets/beauty_products/makeup_5/1.png',
        '682b00d16977bd89257c0ea2': 'assets/beauty_products/skincare_1/1.png',
        '682b00d16977bd89257c0ea3': 'assets/beauty_products/skincare_2/1.png',
        '682b00d16977bd89257c0ea4': 'assets/beauty_products/skincare_3/1.png',
        '682b00d16977bd89257c0ea5': 'assets/beauty_products/skincare_4/1.png',
        '682b00d16977bd89257c0ea6': 'assets/beauty_products/skincare_5/1.png',
        '682b00d16977bd89257c0ea7': 'assets/beauty_products/haircare_1/1.png',
        '682b00d16977bd89257c0ea8': 'assets/beauty_products/haircare_2/1.png',
        '682b00d16977bd89257c0ea9': 'assets/beauty_products/haircare_3/1.png',
        '682b00d16977bd89257c0eaa': 'assets/beauty_products/haircare_4/1.png',
        '682b00d16977bd89257c0eab': 'assets/beauty_products/haircare_5/1.png',
      },
      'home': {
        '681dab0df9c9147444b452cd':
            'assets/Home_products/furniture/furniture1/1.png',
        '681dab0df9c9147444b452ce':
            'assets/Home_products/furniture/furniture2/1.png',
        '681dab0df9c9147444b452cf':
            'assets/Home_products/furniture/furniture3/1.png',
        '681dab0df9c9147444b452d0':
            'assets/Home_products/furniture/furniture4/1.png',
        '681dab0df9c9147444b452d1':
            'assets/Home_products/furniture/furniture5/1.png',
        '681dab0df9c9147444b452d2':
            'assets/Home_products/home-decor/home_decor1/1.png',
        '681dab0df9c9147444b452d3':
            'assets/Home_products/home-decor/home_decor2/1.png',
        '681dab0df9c9147444b452d4':
            'assets/Home_products/home-decor/home_decor3/1.png',
        '681dab0df9c9147444b452d5':
            'assets/Home_products/home-decor/home_decor4/1.png',
        '681dab0df9c9147444b452d6':
            'assets/Home_products/home-decor/home_decor5/1.png',
        '681dab0df9c9147444b452d7':
            'assets/Home_products/kitchen/kitchen1/1.png',
        '681dab0df9c9147444b452d8':
            'assets/Home_products/kitchen/kitchen2/1.png',
        '681dab0df9c9147444b452d9':
            'assets/Home_products/kitchen/kitchen3/1.png',
        '681dab0df9c9147444b452da':
            'assets/Home_products/kitchen/kitchen4/1.png',
        '681dab0df9c9147444b452db':
            'assets/Home_products/kitchen/kitchen5/1.png',
        '681dab0df9c9147444b452dc':
            'assets/Home_products/bath_and_bedding/bath1/1.png',
        '681dab0df9c9147444b452dd':
            'assets/Home_products/bath_and_bedding/bath2/1.png',
        '681dab0df9c9147444b452de':
            'assets/Home_products/bath_and_bedding/bath3/1.png',
        '681dab0df9c9147444b452df':
            'assets/Home_products/bath_and_bedding/bath4/1.png',
        '681dab0df9c9147444b452e0':
            'assets/Home_products/bath_and_bedding/bath5/1.png',
      },
      'videogames': {
        '682b00a46977bd89257c0e80':
            'assets/videogames_products/Consoles/console1/1.png',
        '682b00a46977bd89257c0e81':
            'assets/videogames_products/Consoles/console2/1.png',
        '682b00a46977bd89257c0e82':
            'assets/videogames_products/Consoles/console3/1.png',
        '682b00a46977bd89257c0e83':
            'assets/videogames_products/Consoles/console4/1.png',
        '682b00a46977bd89257c0e84':
            'assets/videogames_products/Controllers/controller1/1.png',
        '682b00a46977bd89257c0e85':
            'assets/videogames_products/Controllers/controller2/1.png',
        '682b00a46977bd89257c0e86':
            'assets/videogames_products/Controllers/controller3/1.png',
        '682b00a46977bd89257c0e87':
            'assets/videogames_products/Controllers/controller4/1.png',
        '682b00a46977bd89257c0e88':
            'assets/videogames_products/Controllers/controller5/1.png',
        '682b00a46977bd89257c0e89':
            'assets/videogames_products/Accessories/accessories1/1.png',
        '682b00a46977bd89257c0e8a':
            'assets/videogames_products/Accessories/accessories2/1.png',
        '682b00a46977bd89257c0e8b':
            'assets/videogames_products/Accessories/accessories3/1.png',
        '682b00a46977bd89257c0e8c':
            'assets/videogames_products/Accessories/accessories4/1.png',
        '682b00a46977bd89257c0e8d':
            'assets/videogames_products/Accessories/accessories5/1.png',
      },
      'appliances': {
        '68252918a68b49cb06164204': 'assets/appliances/product1/1.png',
        '68252918a68b49cb06164205': 'assets/appliances/product2/1.png',
        '68252918a68b49cb06164206': 'assets/appliances/product3/1.png',
        '68252918a68b49cb06164207': 'assets/appliances/product4/1.png',
        '68252918a68b49cb06164208': 'assets/appliances/product5/1.png',
        '68252918a68b49cb06164209': 'assets/appliances/product6/1.png',
        '68252918a68b49cb0616420a': 'assets/appliances/product7/1.png',
        '68252918a68b49cb0616420b': 'assets/appliances/product8/1.png',
        '68252918a68b49cb0616420c': 'assets/appliances/product9/1.png',
        '68252918a68b49cb0616420d': 'assets/appliances/product10/1.png',
        '68252918a68b49cb0616420e': 'assets/appliances/product11/1.png',
        '68252918a68b49cb0616420f': 'assets/appliances/product12/1.png',
        '68252918a68b49cb06164210': 'assets/appliances/product13/1.png',
        '68252918a68b49cb06164211': 'assets/appliances/product14/1.png',
        '68252918a68b49cb06164212': 'assets/appliances/product15/1.png',
      },
      'electronics': {
        '6819e22b123a4faad16613be':
            'assets/electronics_products/mobile_and_tablet/mobile_and_tablet1/1.png',
        '6819e22b123a4faad16613bf':
            'assets/electronics_products/mobile_and_tablet/mobile_and_tablet2/1.png',
        '6819e22b123a4faad16613c0':
            'assets/electronics_products/mobile_and_tablet/mobile_and_tablet3/1.png',
        '6819e22b123a4faad16613c1':
            'assets/electronics_products/mobile_and_tablet/mobile_and_tablet4/1.png',
        '6819e22b123a4faad16613c3':
            'assets/electronics_products/mobile_and_tablet/mobile_and_tablet5/1.png',
        '6819e22b123a4faad16613c4':
            'assets/electronics_products/tvscreens/tv1/1.png',
        '6819e22b123a4faad16613c5':
            'assets/electronics_products/tvscreens/tv2/1.png',
        '6819e22b123a4faad16613c6':
            'assets/electronics_products/tvscreens/tv3/1.png',
        '6819e22b123a4faad16613c7':
            'assets/electronics_products/tvscreens/tv4/1.png',
        '6819e22b123a4faad16613c8':
            'assets/electronics_products/tvscreens/tv5/1.png',
        '6819e22b123a4faad16613c9':
            'assets/electronics_products/Laptop/Laptop1/1.png',
        '6819e22b123a4faad16613ca':
            'assets/electronics_products/Laptop/Laptop2/1.png',
        '6819e22b123a4faad16613cb':
            'assets/electronics_products/Laptop/Laptop3/1.png',
        '6819e22b123a4faad16613cc':
            'assets/electronics_products/Laptop/Laptop4/1.png',
        '6819e22b123a4faad16613cd':
            'assets/electronics_products/Laptop/Laptop5/1.png',
      },
    };

    // Try to find the image path based on the product ID
    for (final categoryPaths in categoryImagePaths.values) {
      if (categoryPaths.containsKey(id)) {
        staticPath = categoryPaths[id];
        break;
      }
    }

    if (staticPath != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          staticPath,
          width: 80,
          height: 80,
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 80,
              height: 80,
              color: isDarkMode ? Colors.grey[850] : Colors.grey[100],
              child: Icon(
                Icons.error_outline,
                color: isDarkMode ? Colors.grey[700] : Colors.grey[400],
              ),
            );
          },
        ),
      );
    }

    // If no static path found, return a placeholder
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[850] : Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        Icons.image_not_supported,
        color: isDarkMode ? Colors.grey[700] : Colors.grey[400],
      ),
    );
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
