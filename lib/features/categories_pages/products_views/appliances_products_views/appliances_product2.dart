import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class AppliancesProduct2 extends StatelessWidget {
  const AppliancesProduct2({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "68132a95ff7813b3d47f9da6",
      title: 'Fresh Jumbo Stainless Steel Potato CB90"',
      imagePaths: [
        'assets/appliances/product2/1.png',
      ],
      category: 'Appliances',
      price: 1099.00,
      originalPrice: 1299.00,
      rating: 4.8,
      reviewCount: 2762,
      brand: 'Fresh',
      color: 'Silver',
      material: 'Stainless Steel',
      dimensions: '90 cm',
      style: 'Potato Peeler',
      installationType: 'Countertop',
      accessLocation: 'Top',
      settingsCount: 1,
      powerSource: 'Electric',
      manufacturer: 'Fresh',
      description:
          'The Fresh Jumbo Potato CB90" features a durable stainless steel body designed for fast and efficient potato peeling in commercial kitchens or busy homes.',
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
