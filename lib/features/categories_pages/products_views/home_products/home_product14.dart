import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class HomeProduct14 extends StatelessWidget {
  const HomeProduct14({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'home14',
      title:
          "LIANYU 20 Piece Silverware Flatware Cutlery Set, Stainless Steel Utensils Service for 4, Include Knife Fork Spoon, Mirror Polished, Dishwasher Safe",
      imagePaths: [
        'assets/Home_products/kitchen/kitchen4/1.png',
        'assets/Home_products/kitchen/kitchen4/2.png',
        'assets/Home_products/kitchen/kitchen4/3.png',
        'assets/Home_products/kitchen/kitchen4/4.png',
      ],
      price: 1099.00,
      originalPrice: 1200.00,
      rating: 4.7,
      reviewCount: 16707,
      colorOptions: ['Silver'],
      colorAvailability: {'Silver': true},
      brand: 'LIANYU',
      numberOfPieces: '20',
      specialfeatures: 'Dishwasher Safe',
      material: 'Stainless Steel',
      productCareInstructions: 'Hand Wash Only, Dishwasher Safe',
      recommendedUsesForProduct: 'Indoor, Outdoor',
      finishType: 'Mirror Finish',
      includedComponents:
          '4 dinner knives, 4 dinner forks, 4 salad forks, 4 table spoons, 4 tea spoons',
      style: 'minimalist',
      aboutThisItem:
          '''Include 20 piece utensils, consist of 4 dinner knives, 4 dinner forks, 4 dinner spoons, 4 salad forks, 4 tea spoons

Durable, constructed by high quality rust-resistant stainless steel, durable for everyday use

Craft, mirror finished surface, simple appearance with no redundant annoying decoration, smooth edge no rough spots

Proper weight, proper gauge to hold comfortably, easy to clean by hand wash, dishwasher safe makes cleaning a breeze

Useful, classic design to fit any tableware, perfect for daily use, gathering, parties, camping, restaurant, hotel or when you need extra silverware set''',
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
