import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class AppliancesProduct6 extends StatelessWidget {
  const AppliancesProduct6({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "68132a95ff7813b3d47f9daa",
      title:
          'deime Air Fryer 6.2 Quart, Large Air Fryer for Families, 5 Cooking Functions',
      imagePaths: [
        'assets/appliances/product6/1.png',
        'assets/appliances/product6/2.png',
        'assets/appliances/product6/3.png',
      ],
      price: 3629,
      originalPrice: 4000,
      rating: 3.9,
      reviewCount: 9,
      brand: 'deime',
      color: 'Black-M',
      material: 'Plastic',
      dimensions: '26.9D x 27.4W x 33H centimeters',
      specialfeatures: 'Temperature Control',
      capacity: '6.2 Quarts',
      recommendedUsesForProduct: 'Bake',
      outputWattage: '1500 Watts',
      itemWeight: '12 Pounds',
      wattage: '1500 watts',
      aboutThisItem:
          '''Multifunctional Air Fryer: With a 6.2 QT capacity and 1500W power, this air fryer is equipped with a high-definition touch screen.

One-Touch Operation: With 10 preset cooking programs and an easy-to-use LED touch screen, this air fryer oven can quickly cook according to your needs in one click, such as french fries, roast chicken, roast pizza, fruit drier, or reheat leftovers and so on.

The Choice for Healthy: Our air fryer oven with 360 degree hot air circulation with 6.2 QT capacity and 1500W power. It can fit a 4-6lbs chicken, 4-8in pizza, 6-10 chicken wings, 2 steaks, or 400-600g french fries.

EASY & LARGE: The square basket design of the 6.2 QT air fryer is sufficient for a larger cooking capacity than round ones, which can serve 2~5 people in just one go! The basket is made of nonstick material.

The Best Gift: The 6.2 qt family-size large air fryer saves space on your counter and in your cabinet. It is a must-have for an apartment, smaller kitchen, college dorm life, or camper/RV traveling. ''',
      deliveryDate: 'Sunday, 9 March',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay Warehouse',
      soldBy: 'Pickpay Official',
    );
    return ProductDetailView(product: product);
  }
}
