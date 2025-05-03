import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class AppliancesProduct5 extends StatelessWidget {
  const AppliancesProduct5({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "68132a95ff7813b3d47f9da9",
      title:
          'Midea Dishwasher - WQP13-5201C-S - 6 programs - Free standing - 13 Place set - Silver',
      imagePaths: [
        'assets/appliances/product5/1.png',
        'assets/appliances/product5/2.png',
        'assets/appliances/product5/3.png',
        'assets/appliances/product5/4.png',
      ],
      category: 'Appliances',
      price: 15699,
      originalPrice: 16000,
      rating: 4.8,
      reviewCount: 2123,
      brand: 'Midea',
      color: 'Silver',
      material: 'Stainless Steel',
      dimensions: '598 x 600 x 845 mm',
      style: 'Dishwasher',
      installationType: 'Freestanding',
      accessLocation: 'Front',
      settingsCount: 6,
      powerSource: 'Electric',
      manufacturer: 'Midea',
      description:
          'A powerful and efficient dishwasher with 13-place setting capacity and 6 washing programs.',
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
