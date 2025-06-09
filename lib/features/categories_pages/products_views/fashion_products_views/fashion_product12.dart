import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class FashionProduct12 extends StatefulWidget {
  const FashionProduct12({super.key});

  @override
  State<FashionProduct12> createState() => _FashionProduct12State();
}

class _FashionProduct12State extends State<FashionProduct12> {
  String _selectedColor = 'Green';

  final Map<String, List<String>> colorImages = {
    'Green': [
      "assets/Fashion_products/Kids_Fashion/kids_fashion2/1.png",
      "assets/Fashion_products/Kids_Fashion/kids_fashion2/2.png",
    ],
    'Gray': [
      "assets/Fashion_products/Kids_Fashion/kids_fashion2/grey/1.jpg",
      "assets/Fashion_products/Kids_Fashion/kids_fashion2/grey/2.jpg",
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
      id: '682b00c26977bd89257c0e99',
      title: "Kidzo Boys Pajamas",
      imagePaths: colorImages[_selectedColor],
      colorImages: colorImages,
      price: 580,
      originalPrice: 621,
      rating: 5.0,
      reviewCount: 3,
      category: 'Fashion',
      subcategory: "Kids' Fashion",
      colorOptions: [
        'Green',
        'Gray',
      ],
      colorAvailability: {
        'Green': true,
        'Gray': true,
      },
      availableSizes: [
        '2-3 Years',
        '3-4 Years',
        '4-5 Years',
        '5-6 Years',
        '6-7 Years',
      ],
      sizeAvailability: {
        '2-3 Years': true,
        '3-4 Years': true,
        '4-5 Years': true,
        '5-6 Years': false,
        '6-7 Years': true,
      },
      careInstruction: 'Machine wash',
      closureType: 'Pull On',
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
