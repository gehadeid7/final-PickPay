import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class AppliancesProduct12 extends StatelessWidget {
  const AppliancesProduct12({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "68132a95ff7813b3d47f9db0",
      title:
          'TORNADO Gas Water Heater 6 Liter, Digital, Natural Gas, Silver GHM-C06CNE-S',
      imagePaths: [
        'assets/appliances/product12/1.png',
        'assets/appliances/product12/2.png',
      ],
      category: 'Appliances',
      price: 3719,
      originalPrice: 3900,
      rating: 4.8,
      reviewCount: 2285,
      brand: 'TORNADO',
      color: 'Silver',
      material: 'Steel',
      dimensions: '6 Liters Capacity',
      style: 'Wall Mounted',
      installationType: 'Wall-Mount',
      accessLocation: 'Front',
      settingsCount: 5,
      powerSource: 'Natural Gas',
      manufacturer: 'TORNADO',
      aboutThisItem:
          'Digital gas water heater with 6L capacity, natural gas-powered. Energy-efficient with safety features.',
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
