import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class FashionProduct4 extends StatelessWidget {
  const FashionProduct4({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da4',
      title: 'Dejavu womens JAL-DJTF-058 Sandal',
      imagePaths: [
        "assets/Fashion_products/Women_Fashion/women_fashion4/1.png",
        "assets/Fashion_products/Women_Fashion/women_fashion4/2.png",
        "assets/Fashion_products/Women_Fashion/women_fashion4/3.png",
      ],
      price: 1259,
      originalPrice: 1400,
      rating: 5.0,
      reviewCount: 88,
      colorOptions: ['Silver', 'Black'],
      colorAvailability: {'Silver': true, 'Black': true},
      availableSizes: ['38 EU', '39 EU', '40 EU', '41 EU'],
      sizeAvailability: {
        '38 EU': true,
        '39 EU': false,
        '40 EU': true,
        '41 EU': true,
      },
      color: 'Silver & Black',
      soleMaterial: 'Rubber',
      outerMaterial: 'Leather',
      closureType: 'Buckle',
      waterResistanceLevel: 'Not Water Resistant',
      aboutThisItem: '''Leather upper material for a luxurious look and feel

Type : Water Dispenser

Leather inner material ensures comfort and breathability

Hard sole provides stability and support for all-day wear

Open toecap shape adds a trendy touch

Buckle closure for a secure and adjustable fit''',
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
