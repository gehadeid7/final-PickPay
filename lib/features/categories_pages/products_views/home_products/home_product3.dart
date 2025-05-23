import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class HomeProduct3 extends StatelessWidget {
  const HomeProduct3({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'home3',
      title: "Generic Coffee Table, Round, 71 cm x 45 cm, Black",
      imagePaths: [
        'assets/Home_products/furniture/furniture3/1.png',
        'assets/Home_products/furniture/furniture3/2.png',
        'assets/Home_products/furniture/furniture3/3.png',
      ],
      price: 3600.00,
      originalPrice: 3800.00,
      rating: 5.0,
      reviewCount: 1,
      category: 'home',
      subcategory: 'Furniture',
      colorOptions: ['Black', 'White'],
      colorAvailability: {'Black': true, 'White': true},
      itemWeight: '15 Kilograms',
      brand: 'Generic',
      dimensions: '70D x 70W x 45H centimeters',
      maximumWeightRecommendation: '80 Kilograms',
      frameMaterial: 'Metal',
      topMaterialType: 'Wood',
      productCareInstructions: 'Wipe with Dry Cloth',
      recommendedUsesForProduct: 'Living Room, Office Room',
      itemShape: 'Round',
      aboutThisItem: 'Round',
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
