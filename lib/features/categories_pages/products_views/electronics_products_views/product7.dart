// lib/features/categories_pages/products_views/product7_view.dart
import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class Product7View extends StatelessWidget {
  const Product7View({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '6819e22b123a4faad16613c5',
      title:
          'Xiaomi TV A 43 2025, 43", FHD, HDR, Cinematic Smart TV, 43-Inch Screen Size Google Assistant platform built-in receiver and Chromecast, metal finish Dolby Atoms 2 years local warranty',
      imagePaths: [
        'assets/electronics_products/tvscreens/tv2/1.png',
        'assets/electronics_products/tvscreens/tv2/2.png',
        'assets/electronics_products/tvscreens/tv2/3.png',
        'assets/electronics_products/tvscreens/tv2/4.png',
      ],
      price: 9999.00,
      originalPrice: 10000.00,
      rating: 3.8,
      reviewCount: 264,
      screenSize: '43 Inches',
      brand: 'Xiaomi',
      category: 'Electronics',
      subcategory: "TVs",
      displayTechnology: 'LED',
      resolution: '1080p',
      modelName: 'L43MA-AUEU',
      specialfeatures: 'chromecast',
      supportedInternetServices: 'Netflix, YouTube, Amazon Prime Video, etc.',
      connectivityTechnology: 'Bluetooth, USB, Ethernet, HDMI',
      aspectRatio: '16:9',
      dimensions: '21D x 95.7W x 59.8H centimeters',
      aboutThisItem:
          '''Enjoy an unparalleled visual experience thanks to an innovative frameless design. The exceptional screen-to-case ratio invites you to immerse yourself in a pure and uninterrupted visual experience.

With FHD HDR resolution, you will enjoy spectacular and fluid content thanks to MEMC technology. This, together with the innovative DTS Virtual, transforms 2D audio into an immersive sound experience. Experience complete immersion with dual decoding of Dolby Audio and DTS-X, amplified by 10W speakers each.

Google TV simplifies your entertainment by bringing movies, TV shows and more from all your subscriptions in one place. Discover personalized recommendations and search more than 10,000 apps with Google.

Control the Xiaomi ecosystem from the comfort of your sofa. Whether via Xiaomi Home or with the "OK Google" command, you can control everything, from surveillance cameras to vacuum cleaner robots.

Entertainment you love with a little help from Google''',
      deliveryDate: "Thursday, May 11th",
      deliveryTimeLeft: "3 hours 5 minutes",
      deliveryLocation: "Cairo, Egypt",
      inStock: true,
      shipsFrom: "PickPay",
      soldBy: "PickPay",
    );

    return ProductDetailView(product: product);
  }
}
