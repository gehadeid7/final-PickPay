import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct16 extends StatelessWidget {
  const BeautyProduct16({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "",
      title: 'Avon Far Away for Women, Floral Eau de Parfum 50ml',
      imagePaths: [
        'assets/beauty_products/fragrance_1/1.png',
        'assets/beauty_products/fragrance_1/2.png',
      ],
      category: 'Beauty',
      price: 434,
      originalPrice: 499,
      rating: 4.5,
      reviewCount: 6632,
      brand: 'Avon',
      style: 'Floral',
      itemform: 'Liquid',
      liquidVolume: '5E+1 Milliliters',
      size: '50 Ml',
      materialfeature: 'eau de parfum',
      fragranceConcentration: 'Eau de Parfum',
      specialfeatures: 'Long Lasting',
      aboutThisItem: '''Brand: Shea Mois
Department: women
Weight: 17 Oz
Longlasting fragrance''',
      deliveryDate: 'Monday, 17 March',
      deliveryTimeLeft: '14hrs 30 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
