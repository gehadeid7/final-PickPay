import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class Product13View extends StatelessWidget {
  const Product13View({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '6819e22b123a4faad16613cb',
      title:
          'HP Victus Gaming Laptop 15-fb1004ne, CPU: Ryzen 5-7535HS, 16GB RAM,512GB SSD, Graphics Card: NVIDIA GeForce RTX 2050, VRAM: 4GB, Display: 15.6 FHD Antiglare IPS 250 nits 144Hz, Windows 11',
      imagePaths: [
        'assets/electronics_products/Laptop/Laptop3/1.png',
        'assets/electronics_products/Laptop/Laptop3/2.png',
        'assets/electronics_products/Laptop/Laptop3/3.png',
        'assets/electronics_products/Laptop/Laptop3/4.png',
      ],
      price: 29999.00,
      rating: 4.2,
      reviewCount: 13,
      screenSize: '15.6 Inches',
      brand: 'HP',
      category: 'Electronics',
      subcategory: 'Laptop',
      graphicsDescription: 'Dedicated',
      operatingSystem: 'Windows 11',
      ramMemoryInstalled: '16 GB',
      specialfeatures:
          'Wireless: MediaTek Wi-Fi 6 MT7921 (2x2) and Bluetooth 5.3 wireless card (supporting gigabit data rate), Graphics: NVIDIA GeForce RTX 2050 Laptop GPU (4 GB GDDR6 dedicated), Storage: 512 GB PCIe Gen4 NVMe M.2 SSD, Processor: AMD Ryzen 5 7535HS (up to 4.55 GHz max boost clock, 16 MB L3 cache, 6 cores, 12 threads), Battery: 3-cell, 52.5 Wh Li-ion polymer',
      cpuModel: 'Ryzen 5',
      cpuSpeed: '3.4',
      modelName: 'Victus',
      aboutThisItem:
          '''Processor: Ryzen 5-7535HS, a capable processor for gaming and multitasking.

RAM:16GB, providing ample memory for multitasking and resource-intensive tasks.

Graphics: NVIDIA GeForce GTX 1650 graphics card for entry-level gaming performance.

Display: 15.6-inch FHD IPS display with 60Hz refresh rate for standard visuals.''',
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
