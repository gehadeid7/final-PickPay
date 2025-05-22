import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class Product9View extends StatelessWidget {
  const Product9View({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'elec9',
      title:
          'SHARP 4K Smart Frameless TV 55 Inch Built-In Receiver 4T-C55FL6EX',
      imagePaths: [
        'assets/electronics_products/tvscreens/tv4/1.png',
        'assets/electronics_products/tvscreens/tv4/2.png',
        'assets/electronics_products/tvscreens/tv4/3.png',
      ],
      price: 17849.00,
      originalPrice: 18999.00,
      rating: 4.7,
      reviewCount: 4,
      screenSize: '55',
      category: 'Electronics',
      subcategory: "TVs",
      brand: 'Sharp',
      displayTechnology: 'LED',
      resolution: '4K',
      refreshRate: '60 Hz',
      specialty:
          'Dolby Vision - HDR10 - HLG - Built-In Receiver - Google TV - Voice Search - Bluetooth - Chromecast Built-in',
      includedComponents: 'Power Cable - Remote Control',
      connectivityTechnology: 'Bluetooth',
      aspectRatio: '16:9',
      dimensions: '75D x 122W x 72H centimeters',
      aboutThisItem: '''Sharp TV 55 inch 4T-C55FL6EX
With built-In receiver
Connect with wired and wireless internet''',
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
