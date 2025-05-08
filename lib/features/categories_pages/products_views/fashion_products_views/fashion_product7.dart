import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class FashionProduct7 extends StatelessWidget {
  const FashionProduct7({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da7',
      title: "DOTT JEANS WEAR Men's Relaxed Fit Jean",
      imagePaths: [
        "assets/Fashion_products/Men_Fashion/men_fashion2/1.png",
        "assets/Fashion_products/Men_Fashion/men_fashion2/2.png",
        "assets/Fashion_products/Men_Fashion/men_fashion2/3.png",
      ],
      price: 799,
      originalPrice: 830,
      rating: 4.3,
      reviewCount: 16,
      colorOptions: ['greenish blue', 'Dark Blue', 'Light Blue'],
      closureType: 'Zipper',
      colorAvailability: {
        'greenish blue': true,
        'Dark Blue': true,
        'Light Blue': true,
      },
      availableSizes: ['29', '30', '32', '34', '36', '38'],
      sizeAvailability: {
        '29': true,
        '30': true,
        '32': true,
        '34': true,
        '36': true,
        '38': true,
      },
      aboutThisItem:
          '''Relaxed Fit: These jeans offer a comfortable, relaxed fit for all-day wear.

Durable Construction: Crafted with high-quality materials for long-lasting durability.

Versatile Style: The classic denim design makes these jeans suitable for various casual occasions.

Convenient Pockets: Multiple pockets provide ample storage space for essentials.

Easy Care: These jeans are low-maintenance and can be machine-washed for easy cleaning.''',
      deliveryDate: 'Sunday, 9 March',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
