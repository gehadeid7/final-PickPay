import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class Product1View extends StatelessWidget {
  const Product1View({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'elec1',
      title:
          'Samsung Galaxy Tab A9 4G LTE, 8.7 Inch Android Tablet, 8GB RAM, 128GB Storage, 8MP Rear Camera, Navy-1 Year Warranty/Local Version',
      imagePaths: [
        'assets/electronics_products/mobile_and_tablet/mobile_and_tablet1/1.png',
        'assets/electronics_products/mobile_and_tablet/mobile_and_tablet1/2.png',
        'assets/electronics_products/mobile_and_tablet/mobile_and_tablet1/3.png',
        'assets/electronics_products/mobile_and_tablet/mobile_and_tablet1/4.png',
        'assets/electronics_products/mobile_and_tablet/mobile_and_tablet1/5.png',
      ],
      price: 9399.00,
      originalPrice: 9655.00,
      rating: 3.1,
      reviewCount: 9,
      colorOptions: ['Navy'],
      colorAvailability: {'Navy': true},
      size: '8 GB ram-128 GB Storage',
      deliveryDate: 'Sunday, 9 March',
      brand: 'SAMSUNG',
      patternName: 'Local Version',
      modelName: 'Samsung Galaxy Tab A9 LTE Android',
      memoryStorageCapacity: '128 GB',
      screenSize: '8.7',
      displayResolutionMaximum: '1280 x 800 pixels',
      operatingSystem: 'Android',
      ramMemoryInstalled: '8 GB',
      generation: '9th Generation',
      specialfeatures: 'Dual Window Multitasking',
      aboutThisItem:
          '''Contemporary style, captivating display: Samsung Galaxy Tab A9 features a sleek metal body in Graphite, Silver, and Navy, Complemented by a large, bright display for immersive entertainment, even in bright conditions

Surround yourself with rich audio: Experience an enveloping soundscape with Galaxy Tab A9 speakers, providing remarkable clarity and depth for your movie and music enjoyment

Store more of what you love: Samsung Galaxy Tab A9 offers up to 4GB RAM to ensure less lag while multitasking, Built-in 64GB storage (expandable to 1TB) saves all your hi-res files, Store more and delete less

Divide screen, multiply your productivity: Galaxy Tab A9 lets you split the screen into two sections for efficient multitasking, Sketch, view visuals, and video chat with two apps open simultaneously, no need to close any

Secure your peace of mind: Safeguard your information, Secure Folder stores important data, Privacy Dashboard lets you monitor the overall security status of your device, Enjoy a worry-free Samsung Galaxy experience without security issues''',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
