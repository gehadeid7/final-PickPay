import 'package:flutter/material.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/widgets/custom_app.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product1.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product2.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product3.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product4.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product5.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product6.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product7.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';

class ElectronicsViewBody extends StatelessWidget {
  const ElectronicsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Electronics'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          SizedBox(height: kTopPadding),
          // product 1
          ProductCard(
            name: 'Samsung Galaxy S23 Ultra',
            imagePaths: [
              'assets/Categories/Electronics/samsung_galaxys23ultra.png',
              'assets/Categories/Electronics/samsung_galaxys23ultra.png',
            ],
            price: 999.99,
            originalPrice: 1199.99,
            rating: 4.9,
            reviewCount: 1893,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Product1View()),
              );
            },
          ),
          SizedBox(height: 10),

          // product 2

          ProductCard(
            name: 'Apple iPhone 15 Pro Max',
            imagePaths: [
              'assets/Categories/Electronics/samsung_galaxys23ultra.png',
            ],
            price: 1099.00,
            originalPrice: 1299.00,
            rating: 4.8,
            reviewCount: 2762,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Product2View()),
              );
            },
          ),
          SizedBox(height: 10),

          // product 3

          ProductCard(
            name: 'Samsung 55-Inch QLED 4K Smart TV',
            imagePaths: [
              'assets/Categories/Electronics/samsung_galaxys23ultra.png',
            ],
            price: 699.99,
            originalPrice: 899.99,
            rating: 4.7,
            reviewCount: 1542,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Product3View()),
              );
            },
          ),
          SizedBox(height: 10),

          // product 4

          ProductCard(
            name: 'Sony WH-1000XM5 Wireless Headphones',
            imagePaths: [
              'assets/Categories/Electronics/samsung_galaxys23ultra.png',
            ],
            price: 348.00,
            originalPrice: 399.99,
            rating: 4.9,
            reviewCount: 3120,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Product4View()),
              );
            },
          ),
          SizedBox(height: 10),

          // product 5
          ProductCard(
            name: 'Apple MacBook Air M2',
            imagePaths: [
              'assets/Categories/Electronics/samsung_galaxys23ultra.png',
            ],
            price: 1149.00,
            originalPrice: 1299.00,
            rating: 4.8,
            reviewCount: 2123,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Product5View()),
              );
            },
          ),
          SizedBox(height: 10),
          // product 6
          ProductCard(
            name: 'Lenovo IdeaPad 3 Laptop',
            imagePaths: [
              'assets/Categories/Electronics/samsung_galaxys23ultra.png',
            ],
            price: 429.00,
            originalPrice: 549.00,
            rating: 4.5,
            reviewCount: 954,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Product6View()),
              );
            },
          ),
          SizedBox(height: 10),

          // product 7
          ProductCard(
            name: 'ASUS ROG Strix Gaming Laptop',
            imagePaths: [
              'assets/Categories/Electronics/samsung_galaxys23ultra.png',
            ],
            price: 1399.00,
            originalPrice: 1599.00,
            rating: 4.7,
            reviewCount: 1288,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Product7View()),
              );
            },
          ),
          SizedBox(height: 10),

          // product 8
          ProductCard(
            name: 'Canon EOS R50 Mirrorless Camera',
            imagePaths: [
              'assets/Categories/Electronics/samsung_galaxys23ultra.png',
            ],
            price: 699.00,
            originalPrice: 799.00,
            rating: 4.6,
            reviewCount: 884,
          ),
          SizedBox(height: 10),

          // product 9
          ProductCard(
            name: 'DJI Mini 3 Pro Drone with Camera',
            imagePaths: [
              'assets/Categories/Electronics/samsung_galaxys23ultra.png',
            ],
            price: 759.00,
            originalPrice: 859.00,
            rating: 4.8,
            reviewCount: 1193,
          ),
          SizedBox(height: 10),

          // product 10
          ProductCard(
            name: 'Amazon Echo Dot (5th Gen)',
            imagePaths: [
              'assets/Categories/Electronics/samsung_galaxys23ultra.png',
            ],
            price: 39.99,
            originalPrice: 59.99,
            rating: 4.6,
            reviewCount: 4576,
          ),
          SizedBox(height: 10),
          // product 11
          ProductCard(
            name: 'Xiaomi Smart Air Purifier 4',
            imagePaths: [
              'assets/Categories/Electronics/samsung_galaxys23ultra.png',
            ],
            price: 149.99,
            originalPrice: 199.99,
            rating: 4.4,
            reviewCount: 674,
          ),
          SizedBox(height: 10),
          // product 12
          ProductCard(
            name: 'Anker PowerCore Portable Charger 20,000mAh',
            imagePaths: [
              'assets/Categories/Electronics/samsung_galaxys23ultra.png',
            ],
            price: 49.99,
            originalPrice: 79.99,
            rating: 4.8,
            reviewCount: 2285,
          ),
          SizedBox(height: 10),
          // product 13
          ProductCard(
            name: 'Logitech MX Master 3 Wireless Mouse',
            imagePaths: [
              'assets/Categories/Electronics/samsung_galaxys23ultra.png',
            ],
            price: 89.99,
            originalPrice: 109.99,
            rating: 4.9,
            reviewCount: 1439,
          ),
          SizedBox(height: 10),
          // product 14
          ProductCard(
            name: 'TP-Link AC1900 Smart WiFi Router',
            imagePaths: [
              'assets/Categories/Electronics/samsung_galaxys23ultra.png',
            ],
            price: 74.99,
            originalPrice: 99.99,
            rating: 4.5,
            reviewCount: 1162,
          ),
          SizedBox(height: 10),
          // product 15
          ProductCard(
            name: 'Google Chromecast with Google TV',
            imagePaths: [
              'assets/Categories/Electronics/samsung_galaxys23ultra.png',
            ],
            price: 49.99,
            originalPrice: 69.99,
            rating: 4.6,
            reviewCount: 1735,
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
