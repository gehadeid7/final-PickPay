import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class HomeProduct17 extends StatelessWidget {
  const HomeProduct17({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'home17',
      title: "Fiber pillow 2 pieces size 40x60",
      imagePaths: [
        'assets/Home_products/bath_and_bedding/bath2/1.png',
        'assets/Home_products/bath_and_bedding/bath2/2.png',
      ],
      price: 185.00,
      originalPrice: 200.00,
      rating: 3.5,
      reviewCount: 257,
      brand: 'Generic',
      color: 'White',
      fillMaterial: 'Cotton',
      specialfeatures: 'breathable',
      pillowType: 'Bed Pillow',
      size: '2 Count (Pack of 1)',
      itemShape: 'Rectangular',
      coverMatrial: 'Microfiber',
      pattern: 'Plain',
      ageRangeDescription: 'Adult',
      aboutThisItem: '''Brand : Other
Height : 40 centimeters
Width :60 centimeters''',
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
