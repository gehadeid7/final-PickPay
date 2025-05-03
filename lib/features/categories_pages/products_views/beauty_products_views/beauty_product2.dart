import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct2 extends StatelessWidget {
  const BeautyProduct2({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "",
      title:
          'L\'Oréal Paris Infaillible 24H Matte Cover Foundation 200 Sable Dore - Oil Control, High Coverage',
      imagePaths: [
        'assets/beauty_products/makeup_2/1.png',
        'assets/beauty_products/makeup_2/2.png',
        'assets/beauty_products/makeup_2/3.png',
        'assets/beauty_products/makeup_2/4.png',
      ],
      category: 'Beauty',
      price: 509.00,
      originalPrice: 575.00,
      rating: 5.0,
      reviewCount: 88,
      brand: 'L’Oréal Paris',
      color: 'Sable Dore',
      material: 'Liquid Foundation',
      dimensions: '30 ml',
      style: 'Matte Cover',
      installationType: 'N/A',
      accessLocation: 'N/A',
      settingsCount: 0,
      powerSource: 'Manual',
      manufacturer: 'L’Oréal',
      description:
          'Oil control, high coverage foundation designed to last 24 hours with a matte finish.',
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
