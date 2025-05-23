import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class Product3View extends StatelessWidget {
  const Product3View({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '6819e22b123a4faad16613c0',
      title: "Apple iPhone 16 (128 GB)",
      imagePaths: [
        'assets/electronics_products/mobile_and_tablet/mobile_and_tablet3/1.png',
        'assets/electronics_products/mobile_and_tablet/mobile_and_tablet3/2.png',
        'assets/electronics_products/mobile_and_tablet/mobile_and_tablet3/3.png',
        'assets/electronics_products/mobile_and_tablet/mobile_and_tablet3/4.png',
      ],
      price: 53550.00,
      originalPrice: 57555.00,
      rating: 4.7,
      reviewCount: 330,
      category: 'Electronics',
      subcategory: 'Mobile & Tablets',
      colorOptions: ['Ultramarine'],
      colorAvailability: {'Ultramarine': true},
      size: '128GB Storage',
      style: 'iPhone 16',
      brand: "Apple",
      modelName: 'iPhone 16',
      memoryStorageCapacity: '128 GB',
      screenSize: '6.1 Inches',
      wirelessProvider: 'Unlocked for All Carriers',
      operatingSystem: 'iOS 17',
      cellularTechnology: '5G',
      wirelessNetworkTechnology: 'LTE',
      connectorType: 'USB Type C',
      aboutThisItem:
          '''6.1-inch Super Retina XDR display with Dynamic Island and up to 2000 nits peak outdoor brightness

6.1-inch Super Retina XDR display with Dynamic Island and up to 2000 nits peak outdoor brightness

Advanced 48MP Fusion camera system with improved low-light performance and spatial photo capabilities

Extended battery life with up to 22 hours video playback and enhanced 25W MagSafe charging

Customizable Action button and Camera Control features for improved user experience and photography control''',
      deliveryDate: "Monday, May 5th",
      deliveryTimeLeft: "2 hours 30 minutes",
      deliveryLocation: "Cairo, Egypt",
      inStock: true,
      shipsFrom: "PickPay",
      soldBy: "PickPay",
    );

    return ProductDetailView(product: product);
  }
}
