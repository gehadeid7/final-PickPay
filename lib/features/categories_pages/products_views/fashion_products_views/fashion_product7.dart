import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class FashionProduct7 extends StatefulWidget {
  const FashionProduct7({super.key});

  @override
  State<FashionProduct7> createState() => _FashionProduct7State();
}

class _FashionProduct7State extends State<FashionProduct7> {
  String _selectedColor = 'Light Blue';

  final Map<String, List<String>> colorImages = {
    'Light Blue': [
      "assets/Fashion_products/Men_Fashion/men_fashion2/light_blue/1.png",
      "assets/Fashion_products/Men_Fashion/men_fashion2/light_blue/2.png",
      "assets/Fashion_products/Men_Fashion/men_fashion2/light_blue/3.png",
    ],
    'greenish blue': [
      "assets/Fashion_products/Men_Fashion/men_fashion2/greenish/1.jpg",
      "assets/Fashion_products/Men_Fashion/men_fashion2/greenish/2.jpg",
      "assets/Fashion_products/Men_Fashion/men_fashion2/greenish/3.jpg",
      "assets/Fashion_products/Men_Fashion/men_fashion2/greenish/4.jpg",
    ],
    'Dark Blue': [
      "assets/Fashion_products/Men_Fashion/men_fashion2/dark_blue/1.jpg",
      "assets/Fashion_products/Men_Fashion/men_fashion2/dark_blue/2.jpg",
      "assets/Fashion_products/Men_Fashion/men_fashion2/dark_blue/3.jpg",
    ],
  };

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '682b00c26977bd89257c0e94',
      title: "DOTT JEANS WEAR Men's Relaxed Fit Jean",
      imagePaths: colorImages[_selectedColor],
      colorImages: colorImages,
      colorOptions: ['greenish blue', 'Dark Blue', 'Light Blue'],
      colorAvailability: {
        'Light Blue': true,
        'greenish blue': true,
        'Dark Blue': true,
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
      closureType: 'Zipper',
      aboutThisItem:
          '''Relaxed Fit: These jeans offer a comfortable, relaxed fit for all-day wear.

Durable Construction: Crafted with high-quality materials for long-lasting durability.

Versatile Style: The classic denim design makes these jeans suitable for various casual occasions.

Convenient Pockets: Multiple pockets provide ample storage space for essentials.

Easy Care: These jeans are low-maintenance and can be machine-washed for easy cleaning.''',
      price: 799,
      originalPrice: 830,
      rating: 4.3,
      reviewCount: 16,
      category: 'Fashion',
      subcategory: "Men's Fashion",
      deliveryDate: 'Sunday, 9 March',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
      onColorSelected: (color) {
        setState(() {
          _selectedColor = color;
        });
      },
    );

    return ProductDetailView(product: product);
  }
}
