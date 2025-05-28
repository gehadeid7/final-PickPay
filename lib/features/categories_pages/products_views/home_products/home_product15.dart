import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class HomeProduct15 extends StatelessWidget {
  const HomeProduct15({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '681dab0df9c9147444b452db',
      title:
          "Dish Rack Dish Drying Stand Dish Drainer Plate Rack Dish rake Kitchen Organizer Dish Drying Rack Countertop Large Antibacterial Kitchen Utensils Dish racks Dish Stand (STYLE A)",
      imagePaths: [
        'assets/Home_products/kitchen/kitchen5/1.png',
        'assets/Home_products/kitchen/kitchen5/2.png',
        'assets/Home_products/kitchen/kitchen5/3.png',
        'assets/Home_products/kitchen/kitchen5/4.png',
        'assets/Home_products/kitchen/kitchen5/5.png',
      ],
      price: 399.00,
      originalPrice: 430.00,
      rating: 3.8,
      reviewCount: 476,
      brand: 'S2C',
      category: 'home',
      subcategory: 'Kitchen & Dining',
      colorOptions: ['Multicolor'],
      colorAvailability: {'Multicolor': true},
      upc: '734077916932 703557955839',
      specialfeatures: 'Portable, Rust Resistant',
      material: 'Plastic',
      manufacturer: 'S2C',
      recommendedUsesForProduct: 'Dish drying, Kitchen organization',
      itemWeight: '1.8 Kilograms',
      mountingType: 'Countertop Mount',
      aboutThisItem:
          '''RUST PROOF HIGH QUALITY --- This dish rack is made of premium quality material which has excellent resistance to rust. Better than most kitchen utensil holder in the market the side has plastic cup holder and drainer tray board. High quality material also sturdy enough for kitchen storage

MULTI FUNCTIONAL --- This dish drying rack designed multi-functional purpose, 2-tier dish dryer rack is with a removable top shelf and cup holder, there is a removable drainage tray at the bottom, which you can remove for this utensil holder.

SPACE SAVER --- This kitchen utensil holder Can be put 10 dishes, more than 3 bowls and some forks & knives, upgrade your storage organizer space or give it to friends as a gift give your home cleaner and tidier shelf organizer for you and have spacious kitchen sink. Best kitchen organizer!

REMOVABLE DESIGN ---Our dish drainer is with a removable top shelf design. You can install in the dish holder or place in the sink or kitchen shelf. Amazing utensil holder for countertop

MONEY BACK GUARANTEE -- We assure you that this premium quality pots and pans organizer, it can be used for a long time, and if you're not satisfied with this dish drying mat at any time, we'll provide a full refund.''',
      dimensions: '32D x 45W x 20H centimeters',
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
