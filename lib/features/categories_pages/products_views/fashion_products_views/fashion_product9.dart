import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class FashionProduct9 extends StatefulWidget {
  const FashionProduct9({super.key});

  @override
  State<FashionProduct9> createState() => _FashionProduct9State();
}

class _FashionProduct9State extends State<FashionProduct9> {
  String _selectedColor = 'Black Full Grain';

  final Map<String, List<String>> colorImages = {
    'Black Full Grain': [
      "assets/Fashion_products/Men_Fashion/men_fashion4/black/1.png",
      "assets/Fashion_products/Men_Fashion/men_fashion4/black/2.png",
      "assets/Fashion_products/Men_Fashion/men_fashion4/black/3.png",
      "assets/Fashion_products/Men_Fashion/men_fashion4/black/4.png",
      "assets/Fashion_products/Men_Fashion/men_fashion4/black/5.png",
    ],
    'Green Olive Full Grain': [
      "assets/Fashion_products/Men_Fashion/men_fashion4/Olive/1.jpg",
      "assets/Fashion_products/Men_Fashion/men_fashion4/Olive/2.jpg",
      "assets/Fashion_products/Men_Fashion/men_fashion4/Olive/3.jpg",
      "assets/Fashion_products/Men_Fashion/men_fashion4/Olive/4.jpg",
      "assets/Fashion_products/Men_Fashion/men_fashion4/Olive/5.jpg",
      "assets/Fashion_products/Men_Fashion/men_fashion4/Olive/6.jpg",
      "assets/Fashion_products/Men_Fashion/men_fashion4/Olive/7.jpg",
    ],
    'Rust Full Grain': [
      "assets/Fashion_products/Men_Fashion/men_fashion4/Rust/1.jpg",
      "assets/Fashion_products/Men_Fashion/men_fashion4/Rust/2.jpg",
      "assets/Fashion_products/Men_Fashion/men_fashion4/Rust/3.jpg",
      "assets/Fashion_products/Men_Fashion/men_fashion4/Rust/4.jpg",
      "assets/Fashion_products/Men_Fashion/men_fashion4/Rust/5.jpg",
      "assets/Fashion_products/Men_Fashion/men_fashion4/Rust/6.jpg",
      "assets/Fashion_products/Men_Fashion/men_fashion4/Rust/7.jpg",
    ],
  };

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '682b00c26977bd89257c0e96',
      title: "Timberland Ek Larchmont Ftm_Chelsea, Men's Boots",
      imagePaths: colorImages[_selectedColor],
      colorImages: colorImages,
      category: 'Fashion',
      subcategory: "Men's Fashion",
      price: 10499,
      originalPrice: 11000,
      rating: 4.3,
      reviewCount: 57,
      colorOptions: [
        'Black Full Grain',
        'Green Olive Full Grain',
        'Rust Full Grain',
      ],
      colorAvailability: {
        'Black Full Grain': true,
        'Green Olive Full Grain': true,
        'Rust Full Grain': true,
      },
      availableSizes: [
        '42 EU',
        '43 EU',
        '44 EU',
        '45 EU',
        '45.5 EU',
        '47.5 EU',
      ],
      sizeAvailability: {
        '42 EU': false,
        '43 EU': true,
        '44 EU': false,
        '45 EU': false,
        '45.5 EU': true,
        '47.5 EU': false,
      },
      materialcomposition: 'Leather',
      soleMaterial: 'Rubber',
      shaftHeight: 'Ankle',
      outerMaterial: 'Leather',
      aboutThisItem: '''Premium full grain leather upper with tonal stitching

Breathable textile lining for comfort

Durable rubber outsole for excellent traction

Classic Chelsea boot design with elastic side panels

Timberland logo detailing

Perfect for casual and semi-formal occasions''',
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
