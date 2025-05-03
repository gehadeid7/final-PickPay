import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct9 extends StatelessWidget {
  const BeautyProduct9({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "",
      title:
          'Eucerin DermoPurifyer Oil Control Skin Renewal Treatment Face Serum, 40ml',
      imagePaths: [
        'assets/beauty_products/skincare_4/1.png',
        // 'assets/beauty_products/skincare_4/2.png',
        'assets/beauty_products/skincare_4/3.png',
      ],
      category: 'Beauty',
      price: 658.93,
      originalPrice: 775.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Eucerin',
      material: 'Serum',
      dimensions: '40ml',
      style: 'Oil Control Serum',
      installationType: '',
      accessLocation: '',
      settingsCount: 0,
      powerSource: '',
      manufacturer: 'Eucerin',
      description:
          'Eucerin Skin Renewal Serum treats blemish-prone skin and controls oil, improving skin texture and appearance.',
      deliveryDate: 'Sunday, 9 March',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay Warehouse',
      soldBy: 'Pickpay Official',
      color: 'White',
    );

    return ProductDetailView(product: product);
  }
}
