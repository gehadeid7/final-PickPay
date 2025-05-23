import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class HomeProduct12 extends StatelessWidget {
  const HomeProduct12({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'home12',
      title: "Pasabahce Set of 6 Large Mug with Handle -340ml Turkey Made",
      imagePaths: [
        'assets/Home_products/kitchen/kitchen2/1.png',
        'assets/Home_products/kitchen/kitchen2/2.png',
        'assets/Home_products/kitchen/kitchen2/3.png',
      ],
      price: 495.00,
      originalPrice: 550.00,
      rating: 4.5,
      reviewCount: 12,
      category: 'home',
      subcategory: 'Kitchen & Dining',
      colorOptions: ['White'],
      colorAvailability: {'White': true},
      brand: 'Pasabahce',
      capacity: '340 Milliliters',
      specialfeatures: 'Microwave Safe',
      material: 'Glass',
      style: 'Classic',
      theme: 'Fantasy',
      recommendedUsesForProduct: 'Home',
      occasion: 'Engagement, Wedding, Birthday',
      includedComponents: 'Handle',
      aboutThisItem: '''Dishwasher proof : Yes
Type : Drinkware Set
Material : Glass
Microwave Proof : Yes
Brand : Pasabahce''',
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
