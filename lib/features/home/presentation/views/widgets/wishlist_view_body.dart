import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/core/utils/app_colors.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/core/widgets/custom_app.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';
import 'package:pickpay/features/home/presentation/cubits/wishlist_cubits/wishlist_cubit.dart';

class WishlistViewBody extends StatelessWidget {
  const WishlistViewBody({super.key});

  @override
  Widget build(BuildContext context) {
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
            return _buildEmptyWishlist();
          }

          final wishlistItems = (state as WishlistLoaded).items;

          return Column(
            children: [
              _buildWishlistHeader(wishlistItems.length),
              _buildWishlistItems(wishlistItems, context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyWishlist() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.favorite_border, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            "Your wishlist is empty",
            style: TextStyles.semiBold16.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            "Tap the heart icon to save items you love",
            style: TextStyles.regular16.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistHeader(int itemCount) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            itemCount == 1
                ? "1 item in wishlist"
                : "$itemCount items in wishlist",
            style: TextStyles.semiBold16.copyWith(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistItems(
      List<ProductsViewsModel> items, BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final product = items[index];
          return _buildWishlistItem(product, context);
        },
      ),
    );
  }

  Widget _buildWishlistItem(ProductsViewsModel product, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
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
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.image_not_supported),
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
                        style: TextStyles.bold16,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "EGP ${product.price?.toStringAsFixed(2) ?? '0.00'}",
                        style: TextStyles.semiBold11.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      if (product.originalPrice != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            "EGP ${product.originalPrice?.toStringAsFixed(2)}",
                            style: TextStyles.regular11.copyWith(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                // Remove button
                IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
