import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class FashionProduct14 extends StatefulWidget {
  const FashionProduct14({super.key});

  @override
  State<FashionProduct14> createState() => _FashionProduct14State();
}

class _FashionProduct14State extends State<FashionProduct14> {
  String _selectedColor = 'white';

  final Map<String, List<String>> colorImages = {
    'white': [
      "assets/Fashion_products/Kids_Fashion/kids_fashion4/1.png",
      "assets/Fashion_products/Kids_Fashion/kids_fashion4/2.png",
    ],
    'Brown': [
      "assets/Fashion_products/Kids_Fashion/kids_fashion4/brown.png",
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
      id: '682b00c26977bd89257c0e9b',
      title:
          'Baby Boys Jacket Fashion Comfortable High Quality Plush Full Warmth Jacket for Your Baby',
      imagePaths: colorImages[_selectedColor],
      colorImages: colorImages,
      price: 425,
      originalPrice: 475,
      rating: 5.0,
      reviewCount: 1,
      category: 'Fashion',
      subcategory: "Kids' Fashion",
      colorOptions: [
        'white',
        'Brown',
      ],
      colorAvailability: {
        'white': true,
        'Brown': true,
      },
      availableSizes: ['1-3 Years'],
      sizeAvailability: {
        '1-3 Years': true,
      },
      careInstruction: 'Machine wash',
      closureType: 'Button',
      lining: 'Unlined',
      aboutThisItem:
          'Fashionable and comfortable high quality plush jacket provides the complete warmth of your baby',
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
