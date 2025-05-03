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
      category: 'Appliances',
      price: 2830,
      originalPrice: 3100,
      rating: 4.6,
      reviewCount: 4576,
      brand: 'Fresh',
      color: 'Black',
      material: 'Plastic',
      dimensions: 'N/A',
      style: 'Vacuum Cleaner',
      installationType: 'N/A',
      accessLocation: 'Front',
      settingsCount: 3,
      powerSource: 'Electric',
      manufacturer: 'Fresh',
      description:
          'A high-performance 1600W vacuum cleaner with bag. Compact and powerful, ideal for daily use.',
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
