import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct10 extends StatelessWidget {
  const BeautyProduct10({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "",
      title: 'L’Oréal Paris Hyaluron Expert Eye Serum - 20ml',
      imagePaths: [
        'assets/beauty_products/skincare_5/1.png',
        'assets/beauty_products/skincare_5/2.png',
        'assets/beauty_products/skincare_5/3.png',
        'assets/beauty_products/skincare_5/4.png',
        'assets/beauty_products/skincare_5/5.png',
      ],
      category: 'Beauty',
      price: 429.00,
      originalPrice: 0.00,
      rating: 4.8,
      reviewCount: 19,
      brand: 'L’Oréal Paris',
      description:
          'Hydrating eye serum with hyaluronic acid for plumper, youthful under eyes.',
      color: 'Clear',
      material: 'Liquid Serum',
      dimensions: '20ml',
      style: 'Eye Serum',
      installationType: 'Topical Use',
      accessLocation: 'Eye Area',
      settingsCount: 1,
      powerSource: 'None',
      manufacturer: 'L’Oréal',
      deliveryDate: 'Monday, 10 March',
      deliveryTimeLeft: '18hrs 20 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay Warehouse',
      soldBy: 'Pickpay Official',
    );

    return ProductDetailView(product: product);
  }
}
