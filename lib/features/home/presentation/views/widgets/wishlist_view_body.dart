import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/core/utils/app_colors.dart';
import 'package:pickpay/core/widgets/custom_app.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';
import 'package:pickpay/features/home/presentation/cubits/wishlist_cubits/wishlist_cubit.dart';

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
          }
        },
        builder: (context, state) {
          if (state is WishlistInitial ||
              (state is WishlistLoaded && state.items.isEmpty)) {
            return _buildEmptyWishlist(theme, colorScheme);
          }

          final wishlistItems = (state as WishlistLoaded).items;

          return Column(
            children: [
              _buildWishlistHeader(wishlistItems.length, theme, colorScheme),
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
            // ignore: deprecated_member_use
            color: colorScheme.onSurface.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            "Your wishlist is empty",
            style: theme.textTheme.titleMedium?.copyWith(
              // ignore: deprecated_member_use
              color: colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Tap the heart icon to save items you love",
            style: theme.textTheme.bodyMedium?.copyWith(
              // ignore: deprecated_member_use
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
              // ignore: deprecated_member_use
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
        color: isDarkMode ? colorScheme.surface : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 82, 82, 82)
                // ignore: deprecated_member_use
                .withOpacity(isDarkMode ? 0.1 : 0.05),
            spreadRadius: 6,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
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
                // Product Image
                if (product.imagePaths != null &&
                    product.imagePaths!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        product.imagePaths![0],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 80,
                          height: 80,
                          color: isDarkMode
                              // ignore: deprecated_member_use
                              ? colorScheme.surfaceVariant
                              : Colors.grey.shade200,
                          child: Icon(
                            Icons.image_not_supported,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ),
                // Product Info
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
                // Remove button
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.redAccent, // Bright red color
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
        // ignore: deprecated_member_use
        backgroundColor: theme.colorScheme.surfaceVariant,
      ),
    );
  }
}
