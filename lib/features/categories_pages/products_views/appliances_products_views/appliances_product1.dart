import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class AppliancesProduct1 extends StatelessWidget {
  const AppliancesProduct1({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
        id: "68252918a68b49cb06164204",
        title:
            'Koldair Water Dispenser Cold And Hot 2 Tabs - Bottom Load KWDB Silver Cooler',
        imagePaths: [
          'assets/appliances/product1/1.png',
          'assets/appliances/product1/2.png',
          'assets/appliances/product1/3.png',
        ],
        price: 10499,
        originalPrice: 16800,
        rating: 3.1,
        reviewCount: 9,
        category: 'Appliances',
        subcategory: 'Large Appliances',
        color: 'Silver',
        material: 'Plastic, Acrylonitrile Butadiene Styrene (ABS)',
        brand: 'Koldair',
        dimensions: '30D x 30W x 110H centimeters',
        style: 'Bottom Load',
        installationType: 'Floor Mounted',
        accessLocation: 'Top',
        settingsCount: 2,
        powerSource: 'Corderd Electric',
        manufacturer: 'Koldair',
        aboutThisItem: '''
Brand Name : Koldair
Type : Water Dispenser
Water Type : Hot And Cold
Top Load - Floor Standing -2 Tabs
Material : ABS (Plastic)
''',
        deliveryDate:
            'FREE Delivery Sunday, 9 March order within 20hrs 36 mins',
        deliveryLocation: 'to Egypt',
        inStock: true,
        shipsFrom: 'PickPay',
        soldBy: 'Pickpay');

    return ProductDetailView(product: product);
  }
}
