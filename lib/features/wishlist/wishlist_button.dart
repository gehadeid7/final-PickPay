import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/wishlist/wishlist_cubits/wishlist_cubit.dart';

class WishlistButton extends StatelessWidget {
  final ProductsViewsModel product;
  final Color? backgroundColor;
  final double? iconSize;

  const WishlistButton({
    super.key,
    required this.product,
    this.backgroundColor,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishlistCubit, WishlistState>(
      listener: (context, state) {},
      builder: (context, state) {
        bool isInWishlist = false;
        if (state is WishlistLoaded) {
          isInWishlist = state.items.any((item) => item.id == product.id);
        }
        // fallback for initial state
        else if (state is WishlistInitial) {
          isInWishlist = false;
        }
        // fallback for error state
        else if (state is WishlistError) {
          isInWishlist = false;
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6.0),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: backgroundColor ?? const Color(0xFFF2F2F2),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              isInWishlist ? Icons.favorite : Icons.favorite_border,
              color: isInWishlist
                  ? Colors.red
                  : Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
              size: iconSize ?? 22,
            ),
            onPressed: () => _handleWishlistAction(context, isInWishlist),
          ),
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
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                message.contains('Added')
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        margin: const EdgeInsets.only(bottom: 80, left: 24, right: 24),
        backgroundColor: message.contains('Added')
            ? const Color(0xFFE91E63) // Pink shade for added
            : const Color(0xFFF44336), // Red shade for removed
        elevation: 8,
      ),
    );
  }
}
