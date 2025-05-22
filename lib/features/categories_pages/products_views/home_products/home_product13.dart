import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class HomeProduct13 extends StatelessWidget {
  const HomeProduct13({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'home13',
      title:
          "P&P CHEF 13½ Inch Pizza Pan Set, 3 Pack Nonstick Pizza Pans, Round Pizza Tray Bakeware for Oven Baking, Stainless Steel Core & Easy to Clean, Non Toxic & Durable, Black",
      imagePaths: [
        'assets/Home_products/kitchen/kitchen3/1.png',
        'assets/Home_products/kitchen/kitchen3/2.png',
        // 'assets/Home_products/kitchen/kitchen3/3.png',
        'assets/Home_products/kitchen/kitchen3/4.png',
      ],
      price: 276.00,
      originalPrice: 300.00,
      rating: 4.5,
      reviewCount: 275,
      category: 'home',
      subcategory: 'Kitchen & Dining',
      colorOptions: ['Black'],
      colorAvailability: {'Black': true},
      brand: 'P&P CHEF',
      capacity: '13.5 Cubic Inches',
      specialfeatures: 'nonstick',
      material: 'Stainless Steel',
      size: '3 x 13.5',
      itemPackageQuantity: '3',
      itemShape: 'Round',
      occasion: 'Birthday, Holiday, Helloween, Chritmas, New Years',
      includedComponents: 'Pizza Tray',
      aboutThisItem:
          '''NON-TOXIC & STURDY P&P CHEF pizza pans are made from premium stainless steel core with food-grade coatings, which will not leech any harmful substances into the food at any temperatures, Giving you a healthier baking, Stainless steel core have strong structure to ensure long-term use, Differ from wooden and aluminum pans, Get rid of crack and rust

EASY CLEANING All-around nonstick pizza tray could release food easily and add less oil or butter for enjoying a good baking experience, With no hidden cleaning dead corner, Easy clean by hand under soapy water, To protect the outer coatings, Please clean with a soft dishcloth, and Please don’t put in dishwasher, Hand-wash is recommended

BAKING EVENLY Stainless Steel pizza pans could withstand high temperatures, Oven safe up to 450 F, Steel construction could transfer heat quickly and evenly to provide uniform baking results, With no undercooked pizza, And saving time on repeat baking, Perfect for cooking, baking and roasting''',
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
