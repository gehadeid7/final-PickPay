import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class AppliancesProduct5 extends StatelessWidget {
  const AppliancesProduct5({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "68252918a68b49cb06164208",
      title:
          'Midea Dishwasher - WQP13-5201C-S - 6 programs - Free standing - 13 Place set - Silver',
      imagePaths: [
        'assets/appliances/product5/1.png',
        'assets/appliances/product5/2.png',
        'assets/appliances/product5/3.png',
        'assets/appliances/product5/4.png',
      ],
      price: 15699,
      originalPrice: 16000,
      rating: 4.0,
      reviewCount: 11,
      brand: 'Midea',
      category: 'Appliances',
      subcategory: 'Large Appliances',
      color: 'Silver',
      modelNumber: 'WQP13-5201C-S',
      capacity: '13 Place Set',
      installationType: 'Free standing',
      numberofprograms: '6',
      controlsType: 'Electronic',
      material: 'Stainless Steel',
      energyEfficency: 'A + +',
      noiselevel: '49 dB',
      aboutThisItem:
          '''Free-standing dishwasher with 13 place settings capacity, ideal for family use.

6 versatile washing programs to handle everything from lightly soiled to heavily dirty dishes.

Sleek silver finish that complements modern kitchen designs.

Energy-efficient operation helps save on electricity and water bills.

Easy-to-use electronic controls with clear program indicators. ''',
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
