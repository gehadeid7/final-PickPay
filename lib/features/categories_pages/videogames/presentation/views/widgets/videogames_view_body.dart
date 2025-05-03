import 'package:flutter/material.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/widgets/custom_app.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';

class VideogamesViewBody extends StatelessWidget {
  const VideogamesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Video Games'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          SizedBox(height: kTopPadding),

          // product 1
          ProductCard(
            name:
                'Sony PlayStation 5 SLIM Disc [ NEW 2023 Model ] - International Version',
            imagePaths: [
              'assets/videogames_products/Consoles/console1/2.png',
            ],
            price: 27.750,
            originalPrice: 28.999,
            rating: 4.8,
            reviewCount: 88,
          ),
          SizedBox(height: 10),

          // product 2
          ProductCard(
            name: 'PlayStation 5 Digital Console (Slim)',
            imagePaths: [
              'assets/videogames_products/Consoles/console2/1.png',
            ],
            price: 19.600,
            originalPrice: 20.800,
            rating: 4.7,
            reviewCount: 3538,
          ),
          SizedBox(height: 10),

          // product 3
          ProductCard(
            name: ' PlayStation 5 Digital Edition Slim (Nordic)',
            imagePaths: [
              'assets/videogames_products/Consoles/console3/1.png',
            ],
            price: 28.799,
            originalPrice: 20.900,
            rating: 4.7,
            reviewCount: 3538,
          ),
          SizedBox(height: 10),

          // product 4
          ProductCard(
            name: 'Nintendo Switch OLED Mario Red Edition Gaming Console',
            imagePaths: [
              'assets/videogames_products/Consoles/console4/1.png',
            ],
            price: 16.990,
            originalPrice: 18.989,
            rating: 4.9,
            reviewCount: 814,
          ),
          SizedBox(height: 10),

          // product 5
          ProductCard(
            name: 'Sony PlayStation 5 DualSense Wireless Controller',
            imagePaths: [
              'assets/videogames_products/Controllers/controller1/1.png',
            ],
            price: 4.499,
            originalPrice: 5.000,
            rating: 4.4,
            reviewCount: 557,
          ),
          SizedBox(height: 10),

          // product 6
          ProductCard(
            name:
                'PlayStation Sony DualSense wireless controller for PS5 White',
            imagePaths: [
              'assets/videogames_products/Controllers/controller2/1.png',
            ],
            price: 4.536,
            originalPrice: 5.000,
            rating: 4.2,
            reviewCount: 698,
          ),
          SizedBox(height: 10),

          // product 7
          ProductCard(
            name: 'PlayStation 5 Dual Sense Wireless Controller Cosmic Red',
            imagePaths: [
              'assets/videogames_products/Controllers/controller3/1.png',
            ],
            price: 4.498,
            originalPrice: 4.900,
            rating: 4.8,
            reviewCount: 2571,
          ),
          SizedBox(height: 10),

          // product 8
          ProductCard(
            name:
                'PlayStation 5 DualSense Edge Wireless Controller (UAE Version)',
            imagePaths: [
              'assets/videogames_products/Controllers/controller4/1.png',
            ],
            price: 16.500,
            originalPrice: 17.000,
            rating: 4.8,
            reviewCount: 2571,
          ),
          SizedBox(height: 10),

          // product 9
          ProductCard(
            name:
                'Nintendo 160 2 Nintendo Switch Joy-Con Controllers (Pastel Purple/Pastel Green)',
            imagePaths: [
              'assets/videogames_products/Controllers/controller5/1.png',
            ],
            price: 4.499,
            originalPrice: 4.988,
            rating: 4.8,
            reviewCount: 2571,
          ),
          SizedBox(height: 10),

          // product 10
          ProductCard(
            name:
                ' Likorlove PS5 Controller Quick Charger, Dual USB Fast Charging Dock Station Stand for Playstation 5 DualSense Controllers Console with LED Indicator USB Type C Ports, White [2.5-3 Hours]',
            imagePaths: [
              'assets/videogames_products/Accessories/accessories1/1.png',
            ],
            price: 750.00,
            originalPrice: 800.99,
            rating: 4.8,
            reviewCount: 2571,
          ),
          SizedBox(height: 10),

          // product 11
          ProductCard(
            name:
                'OIVO PS5 Charging Station, 2H Fast PS5 Controller Charger for Playstation 5 Dualsense Controller, Upgrade PS5 Charging Dock with 2 Types of Cable, PS5 Charger for Dual PS5 Controller',
            imagePaths: [
              'assets/videogames_products/Accessories/accessories2/1.png',
            ],
            price: 1.375,
            originalPrice: 1.599,
            rating: 4.8,
            reviewCount: 2571,
          ),
          SizedBox(height: 10),

          // product 12
          ProductCard(
            name:
                'fanxiang S770 4TB NVMe M.2 SSD for PS5 - with Heatsink and DRAM, Up to 7300MB/s, PCIe 4.0, Suitable for Playstation 5 Memory Expansion, Game Enthusiasts, IT Professionals',
            imagePaths: [
              'assets/videogames_products/Accessories/accessories3/1.png',
            ],
            price: 26.200,
            originalPrice: 26.999,
            rating: 4.8,
            reviewCount: 2571,
          ),
          SizedBox(height: 10),

          // product 13
          ProductCard(
            name:
                'Mcbazel PS5 Cooling Station and Charging Station, 3 Speed Fan, Controller Dock with LED Indicator and 11 Storage Discs - White(Not for PS5 Pro)',
            imagePaths: [
              'assets/videogames_products/Accessories/accessories4/1.png',
            ],
            price: 2.122,
            originalPrice: 2.555,
            rating: 4.8,
            reviewCount: 2571,
          ),
          SizedBox(height: 10),

          // product 14
          ProductCard(
            name: ' EA SPORTS FC 25 Standard Edition PS5 | VideoGame | English',
            imagePaths: [
              'assets/videogames_products/Accessories/accessories5/1.png',
            ],
            price: 3.216,
            originalPrice: 3.490,
            rating: 4.8,
            reviewCount: 2571,
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}
