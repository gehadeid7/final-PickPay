import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class HomeProduct16 extends StatelessWidget {
  const HomeProduct16({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'home16',
      title: "Banotex Cotton Towel 50x100 (Sugar)",
      imagePaths: [
        'assets/Home_products/bath_and_bedding/bath1/1.png',
        'assets/Home_products/bath_and_bedding/bath1/2.png',
      ],
      price: 200.00,
      originalPrice: 220.00,
      rating: 4.4,
      reviewCount: 9,
      color: 'Sugary',
      brand: 'Banotex',
      towelFormType: 'Bath Towel',
      specialfeatures:
          '100% Cotton High Water Absorption Superior Color Fastness Proudly Made In Egypt',
      material: 'Cotton',
      numberofitems: '1',
      style: 'cotton terry',
      productCareInstructions:
          'Machine wash in warm water with a mild detergent. Avoid bleach. Tumble dry on low heat or air dry.',
      itemShape: 'Rectangular',
      dimensions: '100L x 50W centimeters',
      aboutThisItem: '''100% Cotton
High Water Absorption
High Color Fastness
Chic Bath Towel
Made in Egypt''',
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
