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
      price: 112,
      originalPrice: 125,
      rating: 4.0,
      reviewCount: 19,
      brand: 'NIVEA',
      scent: 'Pearl & Beauty',
      itemform: 'Aerosol Spray',
      targetUseBodyPart: 'Body',
      itemvolume: '150 Milliliters',
      materialfeature: 'Aluminum Free, Fragrance Free',
      specialfeatures: 'Fresh',
      aboutThisItem:
          '''The formula provides reliable 48hour antiperspirant protection

Infused with pearl extracts to even out your skin tone

For beautiful and smooth underarms

Sweat and odour protection''',
      deliveryDate: 'Thursday, 20 March',
      deliveryTimeLeft: '12hrs 40 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
