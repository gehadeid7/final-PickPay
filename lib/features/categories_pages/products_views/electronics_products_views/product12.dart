import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class Product12View extends StatelessWidget {
  const Product12View({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'elec12',
      title:
          'Lenovo Legion 5 15ACH6 Gaming Laptop - Ryzen 5-5600H, 16 GB RAM, 512 GB SSD, NVIDIA GeForce RTX 3050 Ti 4GB GDDR6 Graphics, 15.6" FHD (1920x1080) IPS 120Hz, Backlit Keyboard, WIN 11',
      imagePaths: [
        'assets/electronics_products/Laptop/Laptop2/1.png',
        'assets/electronics_products/Laptop/Laptop2/2.png',
        'assets/electronics_products/Laptop/Laptop2/3.png',
        'assets/electronics_products/Laptop/Laptop2/4.png',
      ],
      price: 38749.00,
      originalPrice: 39866.00,
      rating: 3.4,
      reviewCount: 14,
      category: 'Electronics',
      subcategory: 'Laptop',
      screenSize: '15.6 Inches',
      brand: 'Lenovo',
      graphicsDescription: 'Dedicated',
      operatingSystem: 'Windows 11',
      ramMemoryInstalled: '16 GB',
      specialfeatures: 'Backlit Keyboard',
      cpuModel: 'Ryzen 5 5600H',
      hardDiskSize: '512 GB',
      color: 'Phantom Blue (Top), Shadow Black (Bottom)',
      modelName: '15ACH6-56H16G512G3050W11',
      aboutThisItem:
          'Lenovo Legion 5 15ACH6 Gaming Laptop - Ryzen 5 5600H 6-Cores, 16 GB RAM, 512 GB SSD, NVIDIA GeForce RTX 3050 Ti 4GB GDDR6 Graphics, 15.6" FHD (1920x1080) IPS 120Hz, Backlit Keyboard, Windows 11',
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
