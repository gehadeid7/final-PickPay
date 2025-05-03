import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct14 extends StatelessWidget {
  const BeautyProduct14({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "",
      title:
          "L'Oreal Professionnel Absolut Repair 10-In-1 Hair Serum Oil - 90ml",
      imagePaths: [
        'assets/beauty_products/haircare_4/1.png',
        'assets/beauty_products/haircare_4/2.png',
        'assets/beauty_products/haircare_4/3.png',
      ],
      category: 'Beauty',
      price: 965.00,
      originalPrice: 1214.00,
      rating: 4.0,
      reviewCount: 19,
      brand: "L'Oreal Professionnel",
      color: 'Golden',
      material: 'Serum',
      dimensions: '90ml',
      style: 'Hair Serum',
      installationType: 'N/A',
      accessLocation: 'N/A',
      settingsCount: 0,
      powerSource: 'N/A',
      manufacturer: "L'Oreal",
      description:
          'Multi-benefit hair serum for intense repair, strength, and softness.',
      deliveryDate: 'Friday, 14 March',
      deliveryTimeLeft: '17hrs 40 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay Warehouse',
      soldBy: 'Pickpay Official',
    );

    return ProductDetailView(product: product);
  }
}
