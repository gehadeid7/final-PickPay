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
              name:
                  'Samsung Galaxy Tab A9 4G LTE, 8.7" Tablet, 8GB RAM, 128GB, Navy',
              imagePaths: [
                'assets/electronics_products/mobile_and_tablet/mobile_and_tablet1/1.png',
              ],
              price: 9399.00,
              originalPrice: 0,
              rating: 5.0,
              reviewCount: 88,
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
              name:
                  'Xiaomi Redmi Pad SE WiFi 11" FHD+, 8GB+256GB, Snapdragon 680',
              imagePaths: [
                'assets/electronics_products/mobile_and_tablet/mobile_and_tablet2/1.png',
              ],
              price: 12999.99,
              originalPrice: 0,
              rating: 5.0,
              reviewCount: 88,
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
              name: 'Apple iPhone 16 (128GB) - Ultramarine',
              imagePaths: [
                'assets/electronics_products/mobile_and_tablet/mobile_and_tablet3/1.png',
              ],
              price: 57555.00,
              originalPrice: 0,
              rating: 5.0,
              reviewCount: 88,
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
              name:
                  'CANSHN Magnetic iPhone 16 Pro Max Case, Clear, Magsafe Compatible',
              imagePaths: [
                'assets/electronics_products/mobile_and_tablet/mobile_and_tablet4/1.png',
              ],
              price: 141.25,
              originalPrice: 119.00,
              rating: 5.0,
              reviewCount: 92,
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
              name: 'Oraimo 18W USB-C Fast Charger, Dual Output, QC3.0 & PD3.0',
              imagePaths: [
                'assets/electronics_products/mobile_and_tablet/mobile_and_tablet5/1.png',
              ],
              price: 199.00,
              originalPrice: 0,
              rating: 5.0,
              reviewCount: 88,
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
              name:
                  'Samsung 55 Inch QLED Smart TV Neural HDR Quantum Processor Lite 4K - QA55QE1DAUXEG [2024 Model]',
              imagePaths: [
                'assets/electronics_products/tvscreens/tv1/1.png',
              ],
              price: 18499.00,
              originalPrice: 0,
              rating: 4.0,
              reviewCount: 19,
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
              name:
                  'Xiaomi TV A 43 2025, 43", FHD, HDR, Smart Google TV with Dolby Atmos',
              imagePaths: [
                'assets/electronics_products/tvscreens/tv2/1.png',
              ],
              price: 9999.00,
              originalPrice: 0,
              rating: 4.0,
              reviewCount: 19,
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
              name:
                  'Samsung 50 Inch TV Crystal Processor 4K LED - Titan Gray - UA50DU8000UXEG [2024 Model]',
              imagePaths: [
                'assets/electronics_products/tvscreens/tv3/1.png',
              ],
              price: 16299.00,
              originalPrice: 20999.00,
              rating: 4.0,
              reviewCount: 19,
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => const Product8View()),
              //   );
              // },
            ),
            SizedBox(height: 10),

// product 9
            ProductCard(
              name:
                  'SHARP 4K Smart Frameless TV 55 Inch Built-In Receiver 4T-C55FL6EX',
              imagePaths: [
                'assets/electronics_products/tvscreens/tv4/1.png',
              ],
              price: 16999.00,
              originalPrice: 23499.00,
              rating: 4.0,
              reviewCount: 19,
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => const Product9View()),
              //   );
              // },
            ),
            SizedBox(height: 10),

// product 10
            ProductCard(
              name:
                  'LG UHD 4K TV 60 Inch UQ7900 Series, Cinema Screen Design WebOS Smart AI ThinQ',
              imagePaths: [
                'assets/electronics_products/tvscreens/tv5/1.png',
              ],
              price: 18849.00,
              originalPrice: 23999.00,
              rating: 4.5,
              reviewCount: 19,
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => const Product10View()),
              //   );
              // },
            ),
            SizedBox(height: 10),

            // product 11

            ProductCard(
              name:
                  'LENOVO ideapad slim3 15IRH8 -I5-13420H 8G-512SSD 83EM007LPS GREY',
              imagePaths: [
                'assets/electronics_products/Laptop/Laptop1/1.png',
              ],
              price: 24313.00,
              originalPrice: 0,
              rating: 4,
              reviewCount: 19,
            ),
            SizedBox(height: 10),
            // product 12
            ProductCard(
              name:
                  'Lenovo Legion 5 15ACH6 Gaming Laptop - Ryzen 5-5600H, 16 GB RAM, 512 GB SSD, NVIDIA GeForce RTX 3050 Ti 4GB GDDR6 Graphics, 15.6" FHD (1920x1080) IPS 120Hz, Backlit Keyboard, WIN 11',
              imagePaths: [
                'assets/electronics_products/Laptop/Laptop2/1.png',
              ],
              price: 36999.00,
              originalPrice: 0,
              rating: 4,
              reviewCount: 19,
            ),
            SizedBox(height: 10),
            // product 13
            ProductCard(
              name:
                  'HP Victus Gaming Laptop (15-fb1004ne), CPU: Ryzen 5-7535HS, 16GB DDR5 2DM 4800, NVIDIA RTX 2050, 15.6" FHD 144Hz, 512GB, Windows 11',
              imagePaths: [
                'assets/electronics_products/Laptop/Laptop3/1.png',
              ],
              price: 30999.00,
              originalPrice: 0,
              rating: 4,
              reviewCount: 19,
            ),
            SizedBox(height: 10),
            // product 14
            ProductCard(
              name:
                  'HP OfficeJet Pro 9720 Wide Format All-in-One Printer - Print, Scan, Copy, Wireless, ADF, Duplex, Touchscreen - [53N94C]',
              imagePaths: [
                'assets/electronics_products/Laptop/Laptop4/1.png',
              ],
              price: 7199.00,
              originalPrice: 0,
              rating: 4,
              reviewCount: 19,
            ),
            SizedBox(height: 10),
            // product 15
            ProductCard(
              name: 'USB Cooling Pad Stand Fan Cooler for Laptop Notebook',
              imagePaths: [
                'assets/electronics_products/Laptop/Laptop5/1.png',
              ],
              price: 355.00,
              originalPrice: 0,
              rating: 4,
              reviewCount: 19,
            ),
            SizedBox(height: 20),
          ]),
    );
  }
}
