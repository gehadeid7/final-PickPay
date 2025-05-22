import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class Product10View extends StatelessWidget {
  const Product10View({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'elec10',
      title:
          'LG UHD 4K TV 60 Inch UQ7900 Series, Cinema Screen Design 4K Active HDR WebOS Smart AI ThinQ - 60UQ79006LD (New)',
      imagePaths: [
        'assets/electronics_products/tvscreens/tv5/1.png',
        'assets/electronics_products/tvscreens/tv5/2.png',
        'assets/electronics_products/tvscreens/tv5/3.png',
        'assets/electronics_products/tvscreens/tv5/4.png',
        'assets/electronics_products/tvscreens/tv5/5.png',
      ],
      price: 18849.00,
      originalPrice: 19999.00,
      rating: 4.2,
      reviewCount: 43,
      category: 'Electronics',
      subcategory: "TVs",
      screenSize: '60 Inches',
      brand: 'LG',
      displayTechnology: 'LCD',
      resolution: '1080i',
      refreshRate: '60 Hz',
      specialfeatures: 'Sleep Timer',
      supportedInternetServices: 'Netflix',
      connectivityTechnology: 'RF',
      aspectRatio: '16:9',
      dimensions: '3D x 170W x 100H centimeters',
      aboutThisItem: '''Brand: LG

Size in Inch: 60

Model Number: 60UQ79006LD

Tv Type: Flat

Resolution Type: 4K UHD (3840×2160)

Connectivity: 2 HDMI ports, 2 USB ports, Bluetooth V5.0

Smart Connection: Yes (Wi-Fi, Ethernet)

Built-in Receiver: Yes''',
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
