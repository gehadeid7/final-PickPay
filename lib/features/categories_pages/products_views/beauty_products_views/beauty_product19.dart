import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct19 extends StatelessWidget {
  const BeautyProduct19({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "",
      title:
          'NIVEA Antiperspirant Spray for Women, Pearl & Beauty Pearl Extracts, 150ml',
      imagePaths: [
        'assets/beauty_products/fragrance_4/1.png',
        'assets/beauty_products/fragrance_4/2.png',
        'assets/beauty_products/fragrance_4/3.png',
        'assets/beauty_products/fragrance_4/4.png',
        'assets/beauty_products/fragrance_4/5.png',
      ],
      category: 'Beauty',
      price: 123.00,
      originalPrice: 123.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'NIVEA',
      color: 'Pearl & Beauty',
      material: 'Liquid',
      dimensions: '150ml',
      style: 'Antiperspirant Spray',
      installationType: 'N/A',
      accessLocation: 'N/A',
      settingsCount: 0,
      powerSource: 'N/A',
      manufacturer: 'NIVEA',
      aboutThisItem:
          'NIVEA Pearl & Beauty Antiperspirant Spray with a soothing scent and pearl extracts.',
      deliveryDate: 'Thursday, 20 March',
      deliveryTimeLeft: '12hrs 40 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay Warehouse',
      soldBy: 'Pickpay Official',
    );

    return ProductDetailView(product: product);
  }
}
