import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct18 extends StatelessWidget {
  const BeautyProduct18({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "",
      title:
          'Bath Body Gingham Gorgeous Fine Fragrance Mist, Size/Volume: 8 fl oz / 236 mL',
      imagePaths: [
        'assets/beauty_products/fragrance_3/1.png',
        'assets/beauty_products/fragrance_3/2.png',
        'assets/beauty_products/fragrance_3/3.png',
      ],
      category: 'Beauty',
      price: 1350.00,
      originalPrice: 1350.00,
      rating: 4.0,
      reviewCount: 19,
      modelName:
          'Bath Body Gingham Gorgeous Fine Fragrance Mist, Size/Volume: 8 fl oz / 236 mL',
      itemform: 'Liquid',
      brand: '9Street Corner',
      scent: 'juicy pear, sparkling clementine and fresh daisies',
      itemWeight: '150 Milligrams',
      numberofitems: '1',
      unitcount: '236 Milliliters',
      aboutThisItem:
          '''scents your skin with a light-as-air-mist that's super layerable

The truest way to fragrance, Designed for great coverage

What it smells like: our freshest, brightest, most cheerful Gingham yet.

Fragrance notes: juicy pear, sparkling clementine and fresh daisies.''',
      deliveryDate: 'Wednesday, 19 March',
      deliveryTimeLeft: '13hrs 10 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
