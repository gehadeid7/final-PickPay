import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class AppliancesProduct11 extends StatelessWidget {
  const AppliancesProduct11({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "68132a95ff7813b3d47f9daf",
      title:
          'Fresh fan 50 watts 18 inches with charger with 3 blades, black and white',
      imagePaths: [
        'assets/appliances/product11/1.png',
      ],
      category: 'Appliances',
      price: 3983,
      originalPrice: 4200,
      rating: 4.4,
      reviewCount: 674,
      brand: 'Fresh',
      color: 'Black and White',
      material: 'Plastic',
      dimensions: '18 inches',
      style: 'Rechargeable Fan',
      installationType: 'Stand',
      accessLocation: 'Front',
      settingsCount: 3,
      powerSource: 'Electric with charger',
      manufacturer: 'Fresh',
      aboutThisItem:
          'Rechargeable standing fan with 50W power, 3 blades, and long-lasting battery backup.',
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
