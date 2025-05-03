import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class AppliancesProduct9 extends StatelessWidget {
  const AppliancesProduct9({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "68132a95ff7813b3d47f9dad",
      title:
          'Panasonic Powerful Steam/Dry Iron, 1800W, NI-M300TVTD- 1 Year Warranty',
      imagePaths: [
        'assets/appliances/product9/1.png',
      ],
      category: 'Appliances',
      price: 10499,
      originalPrice: 11000,
      rating: 4.8,
      reviewCount: 1193,
      brand: 'Panasonic',
      color: 'White/Blue',
      material: 'Plastic and Metal',
      dimensions: '27.4 x 11.3 x 13.6 cm',
      style: 'Handheld Iron',
      installationType: 'N/A',
      accessLocation: 'Top',
      settingsCount: 3,
      powerSource: 'Electric',
      manufacturer: 'Panasonic',
      description:
          'Panasonic NI-M300TVTD is a powerful 1800W steam/dry iron with a titanium-coated soleplate, anti-calc system, and precision tip for efficient ironing.',
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
