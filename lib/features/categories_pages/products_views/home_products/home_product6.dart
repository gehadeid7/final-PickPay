import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class HomeProduct6 extends StatelessWidget {
  const HomeProduct6({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'home6',
      title: "Golden Lighting LED Gold Lampshade + 1 Crystal Cylinder Bulb.",
      imagePaths: [
        'assets/Home_products/home-decor/home_decor1/1.png',
      ],
      price: 527.86,
      originalPrice: 560.88,
      rating: 3.9,
      reviewCount: 58,
      category: 'Home',
      subcategory: 'Home Decor',
      colorOptions: ['golden'],
      colorAvailability: {'golden': true},
      brand: 'Golden Lighting',
      includedComponents:
          'Golden Lighting LED Gold Lampshade + 1 Crystal Cylinder Bulb.',
      itemWeight: '5500 Grams',
      numberofitems: '1',
      manufacturer: 'China',
      aboutThisItem: '''Made in china
Made of high quality materials. .
Suitable for bedrooms and living rooms''',
      deliveryDate: 'Sunday, 9 March',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
