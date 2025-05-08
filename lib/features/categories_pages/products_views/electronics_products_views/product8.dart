import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class Product8View extends StatelessWidget {
  const Product8View({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'elec8',
      title:
          'Samsung 50 Inch TV Crystal Processor 4K LED - Titan Gray - UA50DU8000UXEG [2024 Model]',
      imagePaths: [
        'assets/electronics_products/tvscreens/tv3/1.png',
        'assets/electronics_products/tvscreens/tv3/2.png',
        'assets/electronics_products/tvscreens/tv3/3.png',
        'assets/electronics_products/tvscreens/tv3/4.png',
        'assets/electronics_products/tvscreens/tv3/5.png',
      ],
      price: 19199.00,
      originalPrice: 20999.00,
      rating: 4.0,
      reviewCount: 180,
      screenSize: '50 Inches',
      brand: 'SAMSUNG',
      displayTechnology: '4K LED',
      resolution: '4K',
      size: '50 Inch',
      specialfeatures: 'Browser',
      includedComponents:
          'User Manual - Remote Control - Power Cable - Full Motion Slim Mount (Y22)',
      connectivityTechnology: 'Bluetooth - Wi-Fi - HDMI',
      aspectRatio: '16:10',
      dimensions: '2.6D x 111.8W x 64.5H centimeters',
      aboutThisItem:
          '''Samsung 50 Inches with resolution 3,840 x 2,160 - 50HZ Refresh Rate

Crystal Processor 4K Picture Engine with High Dynamic Range, Mega Contrast, UHD Dimming and LED Clear Motion

Smart Services: Tizen Operation System, Web Browser, SmartThings App Support and Media Home

Smart Features: Mobile to TV - Mirroring, DLNA, Tap View, SmartThings Hub, WiFi Direct, TV Sound to Mobile and Microsoft 365 Web Service

DVB-T2CS2 Digital Broadcasting, with Analog Tuner and TV Key''',
      deliveryDate: "Thursday, May 11th",
      deliveryTimeLeft: "3 hours 5 minutes",
      deliveryLocation: "Cairo, Egypt",
      inStock: true,
      shipsFrom: "Egypt",
      soldBy: "ASUS Official Store",
    );

    return ProductDetailView(product: product);
  }
}
