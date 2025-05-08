import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class Product14View extends StatelessWidget {
  const Product14View({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'elec14',
      title:
          'HP OfficeJet Pro 9720 Wide Format All-in-One Printer - Print, Scan, Copy,Wireless, Auto Document Feeder, Auto Duplex, Touchscreen, Quiet Mode; Input Capacity of up to 250 sheets - [53N94C]',
      imagePaths: [
        'assets/electronics_products/Laptop/Laptop4/1.png',
        'assets/electronics_products/Laptop/Laptop4/2.png',
        'assets/electronics_products/Laptop/Laptop4/3.png',
        'assets/electronics_products/Laptop/Laptop4/4.png',
      ],
      price: 7999.00,
      originalPrice: 8777.00,
      rating: 4.0,
      reviewCount: 2753,
      style: 'HP OfficeJet Pro 9720',
      brand: 'HP',
      connectivityTechnology: 'Wi-Fi',
      printerTechnology: 'white',
      specialfeatures: 'auto_document_feeder',
      printerOutput: 'Color',
      color: 'White',
      maximumPrintSpeedColor: '18 ppm',
      modelName: '9720',
      aboutThisItem:
          '''Easily achieve vibrant, screen-accurate prints. Print true-to-screen with the world’s first and only wide format printer with P3 for wider gamut vs. sRGB. Drop, arrange, and print multi-size files up to A3/11x17" in just a few clicks with HP Smart Click.

Take your team’s productivity to new heights. 250-page input tray, up to 22 black ppm / 18 color ppm, and an automatic document feeder.

Easily connect to your printer. Connect with our most reliable Wi-Fi - dual-band, self-healing - via USB, Ethernet or through a local VPN.''',
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
