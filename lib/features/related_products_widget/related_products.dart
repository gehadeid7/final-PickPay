import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product5.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product9.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product15.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product1.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product2.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product10.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product11.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product12.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product13.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product14.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product15.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product3.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product4.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product5.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product6.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product7.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product8.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product9.dart';

class RelatedProducts extends StatelessWidget {
  final ProductsViewsModel currentProduct;

  const RelatedProducts({
    super.key,
    required this.currentProduct,
  });

  ProductsViewsModel _getProductFromWidget(
      BuildContext context, Widget widget) {
    // Fashion products
    if (widget is FashionProduct1) {
      return (widget.build(context) as ProductDetailView).product;
    }
    if (widget is FashionProduct2) {
      return (widget.build(context) as ProductDetailView).product;
    }
    if (widget is FashionProduct3) {
      return (widget.build(context) as ProductDetailView).product;
    }
    if (widget is FashionProduct4) {
      return (widget.build(context) as ProductDetailView).product;
    }
    if (widget is FashionProduct5) {
      return (widget.build(context) as ProductDetailView).product;
    }
    if (widget is FashionProduct6) {
      return (widget.build(context) as ProductDetailView).product;
    }
    if (widget is FashionProduct7) {
      return (widget.build(context) as ProductDetailView).product;
    }
    if (widget is FashionProduct8) {
      return (widget.build(context) as ProductDetailView).product;
    }
    if (widget is FashionProduct9) {
      return (widget.build(context) as ProductDetailView).product;
    }
    if (widget is FashionProduct10) {
      return (widget.build(context) as ProductDetailView).product;
    }
    if (widget is FashionProduct11) {
      return (widget.build(context) as ProductDetailView).product;
    }
    if (widget is FashionProduct12) {
      return (widget.build(context) as ProductDetailView).product;
    }
    if (widget is FashionProduct13) {
      return (widget.build(context) as ProductDetailView).product;
    }
    if (widget is FashionProduct14) {
      return (widget.build(context) as ProductDetailView).product;
    }
    if (widget is FashionProduct15) {
      return (widget.build(context) as ProductDetailView).product;
    }
    // Electronics products
    if (widget is Product1View) {
      return (widget.build(context) as ProductDetailView).product;
    }
    if (widget is Product2View) {
      return (widget.build(context) as ProductDetailView).product;
    }
    if (widget is Product3View) {
      return (widget.build(context) as ProductDetailView).product;
    }
    if (widget is Product4View) {
      return (widget.build(context) as ProductDetailView).product;
    }
    if (widget is Product5View) {
      return (widget.build(context) as ProductDetailView).product;
    }
    if (widget is Product6View) {
      return (widget.build(context) as ProductDetailView).product;
    }
    if (widget is Product7View) {
      return (widget.build(context) as ProductDetailView).product;
    }
    if (widget is Product8View) {
      return (widget.build(context) as ProductDetailView).product;
    }
    if (widget is Product9View) {
      return (widget.build(context) as ProductDetailView).product;
    }
    if (widget is Product10View) {
      return (widget.build(context) as ProductDetailView).product;
    }
    if (widget is Product11View) {
      return (widget.build(context) as ProductDetailView).product;
    }
    if (widget is Product12View) {
      return (widget.build(context) as ProductDetailView).product;
    }
    if (widget is Product13View) {
      return (widget.build(context) as ProductDetailView).product;
    }
    if (widget is Product14View) {
      return (widget.build(context) as ProductDetailView).product;
    }
    if (widget is Product15View) {
      return (widget.build(context) as ProductDetailView).product;
    }

    throw Exception('Unknown widget type: ${widget.runtimeType}');
  }

  List<ProductsViewsModel> _getRelatedProducts(BuildContext context) {
    final allProducts = [
      // Fashion products
      const FashionProduct1(),
      const FashionProduct2(),
      const FashionProduct3(),
      const FashionProduct4(),
      const FashionProduct5(),
      const FashionProduct6(),
      const FashionProduct7(),
      const FashionProduct8(),
      const FashionProduct9(),
      const FashionProduct10(),
      const FashionProduct11(),
      const FashionProduct12(),
      const FashionProduct13(),
      const FashionProduct14(),
      const FashionProduct15(),
      // Electronics products
      const Product1View(),
      const Product2View(),
      const Product3View(),
      const Product4View(),
      const Product5View(),
      const Product6View(),
      const Product7View(),
      const Product8View(),
      const Product9View(),
      const Product10View(),
      const Product11View(),
      const Product12View(),
      const Product13View(),
      const Product14View(),
      const Product15View(),
    ];

    final products =
        allProducts.map((w) => _getProductFromWidget(context, w)).toList();

    // Fashion categories
    if (currentProduct.subcategory == "Women's Fashion") {
      return products
          .where((p) =>
              p.subcategory == "Women's Fashion" && p.id != currentProduct.id)
          .toList()
        ..shuffle();
    } else if (currentProduct.subcategory == "Men's Fashion") {
      return products
          .where((p) =>
              p.subcategory == "Men's Fashion" && p.id != currentProduct.id)
          .toList()
        ..shuffle();
    } else if (currentProduct.subcategory == "Kids' Fashion") {
      return products
          .where((p) =>
              p.subcategory == "Kids' Fashion" && p.id != currentProduct.id)
          .toList()
        ..shuffle();
    }
    // Electronics categories
    else if (currentProduct.subcategory == "Mobile & Tablets") {
      return products
          .where((p) =>
              p.subcategory == "Mobile & Tablets" && p.id != currentProduct.id)
          .toList()
        ..shuffle();
    } else if (currentProduct.subcategory == "TVs") {
      return products
          .where((p) => p.subcategory == "TVs" && p.id != currentProduct.id)
          .toList()
        ..shuffle();
    } else if (currentProduct.subcategory == 'Laptop') {
      return products
          .where((p) => p.subcategory == 'Laptop' && p.id != currentProduct.id)
          .toList()
        ..shuffle();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final relatedProducts = _getRelatedProducts(context);
    if (relatedProducts.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.local_mall_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Related Products',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 320,
            child: AnimationLimiter(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                itemCount: relatedProducts.length,
                itemBuilder: (context, index) {
                  final product = relatedProducts[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(
                        child: _RelatedProductCard(
                          product: product,
                          index: index,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RelatedProductCard extends StatelessWidget {
  final ProductsViewsModel product;
  final int index;

  const _RelatedProductCard({
    required this.product,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final discountPercentage = product.originalPrice != null
        ? ((product.originalPrice! - product.price) /
                product.originalPrice! *
                100)
            .round()
        : 0;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailView(product: product),
          ),
        );
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: Card(
          elevation: 4,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Hero(
                      tag: 'related_product_${product.id}',
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Image.asset(
                          (product.imagePaths?.isNotEmpty ?? false)
                              ? product.imagePaths![0]
                              : 'assets/placeholder.png',
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  if (discountPercentage > 0)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.shade600,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          '$discountPercentage% OFF',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? Colors.grey.shade800.withOpacity(0.8)
                            : Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.amber[700],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            product.rating.toString(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: isDarkMode ? Colors.white : Colors.black87,
                        ),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  'EGP ${product.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          if (product.originalPrice != null)
                            Text(
                              'EGP ${product.originalPrice!.toStringAsFixed(2)}',
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey[600],
                                fontSize: 11,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 14,
                            color: isDarkMode ? Colors.white70 : Colors.black54,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              '${product.reviewCount} orders',
                              style: TextStyle(
                                fontSize: 11,
                                color: isDarkMode
                                    ? Colors.white70
                                    : Colors.black54,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'In Stock',
                              style: TextStyle(
                                fontSize: 9,
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
