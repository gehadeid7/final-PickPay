import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class FashionProduct15 extends StatefulWidget {
  const FashionProduct15({super.key});

  @override
  State<FashionProduct15> createState() => _FashionProduct15State();
}

class _FashionProduct15State extends State<FashionProduct15> {
  String _selectedColor = 'White';

  final Map<String, List<String>> colorImages = {
    'White': [
      "assets/Fashion_products/Kids_Fashion/kids_fashion5/1.png",
      "assets/Fashion_products/Kids_Fashion/kids_fashion5/2.png",
      "assets/Fashion_products/Kids_Fashion/kids_fashion5/3.png",
    ],
    'Beige': [
      "assets/Fashion_products/Kids_Fashion/kids_fashion5/beige/1.png",
      "assets/Fashion_products/Kids_Fashion/kids_fashion5/beige/2.png",
      "assets/Fashion_products/Kids_Fashion/kids_fashion5/beige/3.png",
      "assets/Fashion_products/Kids_Fashion/kids_fashion5/beige/4.png",
    ],
    'Black': [
      "assets/Fashion_products/Kids_Fashion/kids_fashion5/black/1.png",
      "assets/Fashion_products/Kids_Fashion/kids_fashion5/black/2.png",
      "assets/Fashion_products/Kids_Fashion/kids_fashion5/black/3.png",
      "assets/Fashion_products/Kids_Fashion/kids_fashion5/black/4.png",
    ],
    'Red': [
      "assets/Fashion_products/Kids_Fashion/kids_fashion5/red/1.png",
      "assets/Fashion_products/Kids_Fashion/kids_fashion5/red/2.png",
      "assets/Fashion_products/Kids_Fashion/kids_fashion5/red/3.png",
    ],
    'Rose': [
      "assets/Fashion_products/Kids_Fashion/kids_fashion5/rose/1.png",
      "assets/Fashion_products/Kids_Fashion/kids_fashion5/rose/2.png",
      "assets/Fashion_products/Kids_Fashion/kids_fashion5/rose/3.png",
      "assets/Fashion_products/Kids_Fashion/kids_fashion5/rose/4.png",
    ],
  };

  void _handleColorSelection(String color) {
    setState(() {
      _selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '682b00c26977bd89257c0e9c',
      title: "MIX & MAX, Ballerina Shoes, girls, Ballet Flat",
      imagePaths: colorImages[_selectedColor],
      colorImages: colorImages,
      price: 354.00,
      rating: 5.0,
      reviewCount: 1,
      category: 'Fashion',
      subcategory: "Kids' Fashion",
      colorOptions: [
        'White',
        'Beige',
        'Black',
        'Red',
        'Rose',
      ],
      colorAvailability: {
        'White': true,
        'Beige': true,
        'Black': true,
        'Red': true,
        'Rose': true,
      },
      availableSizes: [
        '0-6 Months',
        '6-12 Months',
        '12-18 Months',
      ],
      sizeAvailability: {
        '0-6 Months': false,
        '6-12 Months': false,
        '12-18 Months': true,
      },
      soleMaterial: 'Synthetic Leather',
      outerMaterial: 'Faux Leather',
      closureType: 'Hook & Loop',
      waterResistanceLevel: 'Not Water Resistant',
      aboutThisItem: '''
Color: Black&Red /Size: 1-6Month/Insole Length: 11cm

Made In: China

Material: Synthetic Leather

Brand: Mix&Max

Target Gender: Girls''',
      deliveryDate: 'Sunday, 9 March',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
      onColorSelected: _handleColorSelection,
    );

    return ProductDetailView(product: product);
  }
}
