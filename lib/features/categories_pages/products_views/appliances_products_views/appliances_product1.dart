import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class AppliancesProduct1 extends StatelessWidget {
  const AppliancesProduct1({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      title:
          'Koldair Water Dispenser Cold And Hot 2 Tabs - Bottom Load KWDB Silver Cooler',
      imagePaths: [
        'assets/appliances/product1/1.png',
        'assets/appliances/product1/2.png',
        'assets/appliances/product1/3.png',
      ],
      category: 'Appliances',
      price: 10499,
      originalPrice: 11999,
      rating: 4.9,
      reviewCount: 1893,
      brand: 'Koldair',
      color: 'Silver',
      material: 'Plastic and Metal',
      dimensions: '310 x 360 x 1040 mm',
      style: 'Bottom Load Water Dispenser',
      installationType: 'Freestanding',
      accessLocation: 'Front',
      settingsCount: 2,
      powerSource: 'Electric',
      manufacturer: 'Koldair',
      description:
          'The Koldair KWDB water dispenser provides both cold and hot water with two separate taps. Features a bottom loading design for ease of use and a sleek silver finish suitable for home or office.',
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
