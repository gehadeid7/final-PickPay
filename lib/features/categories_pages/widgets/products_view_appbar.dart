import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/sharing_product/app_constants.dart';
import 'package:pickpay/features/home/presentation/views/cart_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/home/presentation/views/widgets/wishlist_button.dart';

class ProductDetailAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final ProductsViewsModel product;
  final VoidCallback onBackPressed;

  const ProductDetailAppBar({
    super.key,
    required this.product,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final iconColor = isDarkMode ? Colors.white : Colors.black;
    final circleColor = isDarkMode
        // ignore: deprecated_member_use
        ? Colors.white.withOpacity(0.2)
        // ignore: deprecated_member_use
        : Colors.black.withOpacity(0.05);

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            _buildCircleIcon(
              icon: Icons.arrow_back,
              onTap: onBackPressed,
              iconColor: iconColor,
              circleColor: circleColor,
            ),
            const Spacer(),
            _buildCircleIcon(
              child: WishlistButton(
                product: product,
                backgroundColor: Colors.transparent,
                iconSize: 20,
              ),
              iconColor: iconColor,
              circleColor: circleColor,
            ),
            _buildCircleIcon(
              icon: Icons.share_outlined,
              onTap: () => _shareProduct(context),
              iconColor: iconColor,
              circleColor: circleColor,
            ),
            _buildCircleIcon(
              icon: Icons.shopping_cart_outlined,
              onTap: () => _navigateToCart(context),
              iconColor: iconColor,
              circleColor: circleColor,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _shareProduct(BuildContext context) async {
    try {
      final productLink = _generateProductLink();
      final shareText = _generateShareText();

      if (!kIsWeb) {
        // For mobile - include more details
        // ignore: deprecated_member_use
        await Share.share(
          shareText,
          subject: 'Check out ${product.title} on PickPay!',
        );
      } else {
        // For web - shorter version
        // ignore: deprecated_member_use
        await Share.share(
          'Check out ${product.title} on PickPay! $productLink',
          subject: 'PickPay Product',
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error sharing: ${e.toString()}'),
          duration: const Duration(seconds: 2),
        ),
      );
      debugPrint('Sharing error: $e');
    }
  }

  String _generateProductLink() {
    final baseUrl = AppConstants.baseUrl;
    final productId = Uri.encodeComponent(product.id ?? '');
    return '$baseUrl/products/$productId';
  }

  String _generateShareText() {
    // Basic product info
    final buffer = StringBuffer();
    buffer.writeln('🌟 ${product.title ?? 'Amazing Product'}');
    buffer.writeln(
        '💰 Price: EGP ${product.price?.toStringAsFixed(2) ?? '0.00'}');

    if (product.originalPrice != null) {
      buffer
          .writeln('📉 Was: EGP ${product.originalPrice?.toStringAsFixed(2)}');
    }

    // Rating
    if (product.rating != null) {
      buffer.writeln(
          '⭐ Rating: ${product.rating}/5 (${product.reviewCount ?? 0} reviews)');
    }

    // Key features
    buffer.writeln('\n🔍 Key Features:');
    if (product.brand != null && product.brand!.isNotEmpty) {
      buffer.writeln('• Brand: ${product.brand}');
    }
    if (product.color != null && product.color!.isNotEmpty) {
      buffer.writeln('• Color: ${product.color}');
    }
    if (product.material != null && product.material!.isNotEmpty) {
      buffer.writeln('• Material: ${product.material}');
    }
    if (product.specialfeatures != null &&
        product.specialfeatures!.isNotEmpty) {
      buffer.writeln('• Special Features: ${product.specialfeatures}');
    }

    // Delivery info
    buffer.writeln('\n🚚 Delivery:');
    if (product.deliveryDate != null) {
      buffer.writeln('• Get it by ${product.deliveryDate}');
    }
    if (product.inStock ?? false) {
      buffer.writeln('• ✅ In Stock');
    } else {
      buffer.writeln('• ❌ Out of Stock');
    }

    // About this item (first 3 lines)
    if (product.aboutThisItem != null && product.aboutThisItem!.isNotEmpty) {
      final aboutLines = product.aboutThisItem!.split('\n');
      buffer.writeln('\n📝 Description:');
      for (var i = 0;
          i < (aboutLines.length > 3 ? 3 : aboutLines.length);
          i++) {
        buffer.writeln('• ${aboutLines[i]}');
      }
      if (aboutLines.length > 3) {
        buffer.writeln('• ...');
      }
    }

    // Add the product link at the end
    buffer.writeln('\n🔗 View product: ${_generateProductLink()}');

    return buffer.toString();
  }

  void _navigateToCart(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CartView()),
    );
  }

  Widget _buildCircleIcon({
    IconData? icon,
    VoidCallback? onTap,
    Widget? child,
    required Color iconColor,
    required Color circleColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: circleColor,
              shape: BoxShape.circle,
            ),
            child: child ??
                Icon(
                  icon,
                  size: 20,
                  color: iconColor,
                ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
