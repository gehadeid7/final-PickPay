import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class FashionProduct9 extends StatelessWidget {
  const FashionProduct9({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da9',
      title: "Timberland Ek Larchmont Ftm_Chelsea, Men's Boots",
      imagePaths: [
        "assets/Fashion_products/Men_Fashion/men_fashion4/1.png",
        "assets/Fashion_products/Men_Fashion/men_fashion4/2.png",
        "assets/Fashion_products/Men_Fashion/men_fashion4/3.png",
        "assets/Fashion_products/Men_Fashion/men_fashion4/4.png",
        "assets/Fashion_products/Men_Fashion/men_fashion4/5.png",
      ],
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
      aboutThisItem: '''Premium full grain leather upper with tonal sching

Breathable textile lining for comfort

Textile lined footbed for cushioning and support''',
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
