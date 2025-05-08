import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class AppliancesProduct10 extends StatelessWidget {
  const AppliancesProduct10({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "68132a95ff7813b3d47f9dae",
      title: 'Fresh 1600W Faster Vacuum Cleaner with Bag, Black',
      imagePaths: [
        'assets/appliances/product10/1.png',
      ],
      price: 2830,
      originalPrice: 3100,
      rating: 4.6,
      reviewCount: 4576,
      brand: 'Fresh',
      filtertype: 'HEPA',
      surface: 'All floors',
      components: 'Vacuum Bag',
      isProductCordless: 'No',
      installationType: 'Floor Mounted',
      capacity: '3.5 Liters',
      wattage: '1600 watts',
      aboutThisItem: '''Quickly removes solid particles at ease.

Keep your house clean and healthy without any physical effort.

Thermo cut keeps motor from getting extra heated.

Dust bag full indicator automatically detects when the dust bag is full.

Make daily cleaning hassle-free.''',
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
