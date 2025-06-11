import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/core/utils/app_colors.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';
import 'package:pickpay/features/wishlist/wishlist_cubits/wishlist_cubit.dart';

class WishlistViewBody extends StatelessWidget {
  const WishlistViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Your Wishlist'),
      body: BlocConsumer<WishlistCubit, WishlistState>(
        listener: (context, state) {
          if (state is WishlistLoaded) {
            if (state.action == WishlistAction.added) {
              _showMessage(context, "Added to wishlist");
            } else if (state.action == WishlistAction.removed) {
              _showMessage(context, "Removed from wishlist");
            }
          } else if (state is WishlistError) {
            _showMessage(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is WishlistLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WishlistError) {
            return Center(
              child: Text(
                state.message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.error,
                ),
              ),
            );
          } else if (state is WishlistInitial ||
              (state is WishlistLoaded && state.items.isEmpty)) {
            return _buildEmptyWishlist(theme, colorScheme);
          }

          final wishlistItems = (state as WishlistLoaded).items;

          return Column(
            children: [
              _buildWishlistHeader(wishlistItems.length, theme, colorScheme),
              Divider(
                height: 1,
                thickness: 1,
                indent: 16,
                endIndent: 16,
                color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
              ),
              _buildWishlistItems(
                  wishlistItems, context, isDarkMode, colorScheme),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyWishlist(ThemeData theme, ColorScheme colorScheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 64,
            color: colorScheme.onSurface.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            "Your wishlist is empty",
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Tap the heart icon to save items you love",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistHeader(
      int itemCount, ThemeData theme, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            itemCount == 1
                ? "1 item in wishlist"
                : "$itemCount items in wishlist",
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistItems(
    List<ProductsViewsModel> items,
    BuildContext context,
    bool isDarkMode,
    ColorScheme colorScheme,
  ) {
    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final product = items[index];
          return _buildWishlistItem(product, context, isDarkMode, colorScheme);
        },
      ),
    );
  }

  Widget _buildWishlistItem(
    ProductsViewsModel product,
    BuildContext context,
    bool isDarkMode,
    ColorScheme colorScheme,
  ) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 82, 82, 82)
                .withOpacity(isDarkMode ? 0.1 : 0.05),
            spreadRadius: 6,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade200,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailView(product: product),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: _buildProductImage(product, isDarkMode, colorScheme),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title ?? "Unnamed Product",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "EGP ${product.price?.toStringAsFixed(2) ?? '0.00'}",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (product.originalPrice != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            "EGP ${product.originalPrice?.toStringAsFixed(2)}",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.red,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.redAccent,
                  ),
                  onPressed: () {
                    context
                        .read<WishlistCubit>()
                        .removeFromWishlist(product.id);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage(
    ProductsViewsModel product,
    bool isDarkMode,
    ColorScheme colorScheme,
  ) {
    // Try to get image paths from the product
    final imagePaths = product.imagePaths;
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
    final id = product.id;
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

  void _showMessage(BuildContext context, String message) {
    final theme = Theme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        backgroundColor: theme.colorScheme.surfaceVariant,
      ),
    );
  }
}
