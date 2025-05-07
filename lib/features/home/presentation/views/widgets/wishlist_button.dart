import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/home/presentation/cubits/wishlist_cubits/wishlist_cubit.dart';

class WishlistButton extends StatelessWidget {
  final ProductsViewsModel product;
  final bool isMini;
  final Color? backgroundColor;
  final double? iconSize;

  const WishlistButton({
    super.key,
    required this.product,
    this.isMini = false,
    this.backgroundColor,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishlistCubit, WishlistState>(
      listener: (context, state) {
        // Empty listener to ensure rebuilds
      },
      builder: (context, state) {
        // Get fresh state on every build
        final isInWishlist =
            context.read<WishlistCubit>().isInWishlist(product.id);

        return FloatingActionButton(
          heroTag: 'wishlist_${product.id}', // Unique hero tag
          // ignore: deprecated_member_use
          backgroundColor: backgroundColor ?? Colors.white.withOpacity(0.9),
          mini: isMini,
          elevation: 2,
          child: Icon(
            isInWishlist ? Icons.favorite : Icons.favorite_border,
            color: isInWishlist ? Colors.red : Colors.black,
            size: iconSize,
          ),
          onPressed: () => _handleWishlistAction(context, isInWishlist),
        );
      },
    );
  }

  void _handleWishlistAction(BuildContext context, bool isInWishlist) {
    final cubit = context.read<WishlistCubit>();

    if (isInWishlist) {
      cubit.removeFromWishlist(product.id);
      _showSnackBar(context, "Removed from wishlist");
    } else {
      cubit.addToWishlist(product);
      _showSnackBar(context, "Added to wishlist");
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar(); // Remove previous
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(bottom: 70, left: 20, right: 20),
        backgroundColor: Colors.black87,
      ),
    );
  }
}
