import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class FashionProduct6 extends StatefulWidget {
  const FashionProduct6({super.key});

  @override
  State<FashionProduct6> createState() => _FashionProduct6State();
}

class _FashionProduct6State extends State<FashionProduct6> {
  String _selectedColor = 'Navy';

  final Map<String, List<String>> colorImages = {
    'Navy': [
      "assets/Fashion_products/Men_Fashion/men_fashion1/navy/1.png",
      "assets/Fashion_products/Men_Fashion/men_fashion1/navy/2.png",
      "assets/Fashion_products/Men_Fashion/men_fashion1/navy/3.png",
      "assets/Fashion_products/Men_Fashion/men_fashion1/navy/4.png",
    ],
    'Antracite': [
      "assets/Fashion_products/Men_Fashion/men_fashion1/antracite/antracite.jpg",
      "assets/Fashion_products/Men_Fashion/men_fashion1/antracite/arc2.jpg",
      "assets/Fashion_products/Men_Fashion/men_fashion1/antracite/arc3.jpg",
    ],
    'Grey': [
      "assets/Fashion_products/Men_Fashion/men_fashion1/grey/grey.jpg",
    ],
    'Blue': [
      "assets/Fashion_products/Men_Fashion/men_fashion1/blue/blue.jpg",
      "assets/Fashion_products/Men_Fashion/men_fashion1/blue/blue2.jpg",
      "assets/Fashion_products/Men_Fashion/men_fashion1/blue/blue3.jpg",
    ],
  };

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '682b00c26977bd89257c0e93',
      title:
          "DeFacto Man Modern Fit Polo Neck Short Sleeve B6374AX Polo T-Shirt",
      imagePaths: colorImages[_selectedColor],
      colorImages: colorImages,
      availableSizes: [
        'XSmall',
        'Small',
        'Medium',
        'Large',
        'XLarge',
        'XXLarge'
      ],
      colorOptions: ['Navy', 'Antracite', 'Grey', 'Blue'],
      colorAvailability: {
        'Navy': true,
        'Antracite': true,
        'Grey': true,
        'Blue': true,
      },
      careInstruction: 'Machine washable',
      aboutThisItem: '''B6374AX
Polyester 100%
Modern Fit
Polo Neck
Short Sleeve''',
      price: 599,
      originalPrice: 640,
      rating: 5.0,
      reviewCount: 438,
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
