import 'package:flutter/material.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/widgets/custom_app.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product15.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product16.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product17.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product18.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product19.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product20.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product5.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product9.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';

class BeautyViewBody extends StatelessWidget {
  const BeautyViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Beauty'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          SizedBox(height: kTopPadding),

          // Product 1
          ProductCard(
            name:
                'L’Oréal Paris Volume Million Lashes Panorama Mascara in Black, 9.9 ml',
            imagePaths: [
              'assets/beauty_products/makeup_1/1.png',
            ],
            price: 401.00,
            originalPrice: 730.00,
            rating: 5.0,
            reviewCount: 88,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BeautyProduct1()),
              );
            },
          ),
          SizedBox(height: 10),

          // Product 2
          ProductCard(
            name:
                'L\'Oréal Paris Infaillible 24H Matte Cover Foundation 200 Sable Dore - Oil Control, High Coverage',
            imagePaths: [
              'assets/beauty_products/makeup_2/1.png',
            ],
            price: 509.00,
            originalPrice: 575.00,
            rating: 5.0,
            reviewCount: 88,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BeautyProduct2()),
              );
            },
          ),
          SizedBox(height: 10),

          // Product 3
          ProductCard(
            name: 'Cybele Smooth N`Wear Powder Blush Corail 17 - 3.7gm',
            imagePaths: [
              'assets/beauty_products/makeup_3/1.png',
            ],
            price: 227.20,
            originalPrice: 240.00,
            rating: 5.0,
            reviewCount: 88,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BeautyProduct3()),
              );
            },
          ),
          SizedBox(height: 10),

          // Product 4
          ProductCard(
            name:
                'Eva skin care cleansing & makeup remover facial wipes for normal/dry skin 20%',
            imagePaths: [
              'assets/beauty_products/makeup_4/1.png',
            ],
            price: 63.00,
            originalPrice: 63.00, // No old price in HTML, so same as current
            rating: 5.0,
            reviewCount: 92,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BeautyProduct4()),
              );
            },
          ),
          SizedBox(height: 10),

          // Product 5
          ProductCard(
            name: 'Maybelline New York Lifter Lip Gloss, 005 Petal',
            imagePaths: [
              'assets/beauty_products/makeup_5/1.png',
            ],
            price: 300.00,
            originalPrice: 310.00,
            rating: 5.0,
            reviewCount: 88,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BeautyProduct5()),
              );
            },
          ),
          SizedBox(height: 10),

// Product 6
          ProductCard(
            name: 'Care & More Soft Cream With Glycerin Mixed berries 75 ML',
            imagePaths: [
              'assets/beauty_products/skincare_1/1.png',
            ],
            price: 31.00,
            originalPrice: 44.00,
            rating: 4.0,
            reviewCount: 19,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BeautyProduct6()),
              );
            },
          ),
          SizedBox(height: 10),

// Product 7
          ProductCard(
            name:
                'La Roche-Posay Anthelios XL Non-perfumed Dry Touch oil control gel cream SPF50+ 50ml',
            imagePaths: [
              'assets/beauty_products/skincare_2/1.png',
            ],
            price: 1168.70,
            originalPrice: 1168.70, // No old price listed
            rating: 4.0,
            reviewCount: 19,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BeautyProduct7()),
              );
            },
          ),
          SizedBox(height: 10),

// Product 8
          ProductCard(
            name:
                'Eva Aloe skin clinic anti-ageing collagen toner for firmed and refined skin - 200ml',
            imagePaths: [
              'assets/beauty_products/skincare_3/1.png',
            ],
            price: 138.60,
            originalPrice: 210.00,
            rating: 4.0,
            reviewCount: 19,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BeautyProduct8()),
              );
            },
          ),
          SizedBox(height: 10),

          // product 9
          ProductCard(
            name:
                'Eucerin DermoPurifyer Oil Control Skin Renewal Treatment Face Serum, 40ml',
            imagePaths: [
              'assets/beauty_products/skincare_4/1.png',
            ],
            price: 658.93,
            originalPrice: 775.00,
            rating: 4.0,
            reviewCount: 19,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BeautyProduct9()),
              );
            },
          ),
          SizedBox(height: 10),

          // product 10
          ProductCard(
            name: 'L’Oréal Paris Hyaluron Expert Eye Serum - 20ml',
            imagePaths: [
              'assets/beauty_products/skincare_5/1.png',
            ],
            price: 429.00,
            originalPrice: 0.00, // no original price shown
            rating: 4.8,
            reviewCount: 19,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BeautyProduct10()),
              );
            },
          ),
          SizedBox(height: 10),

          // product 11
          ProductCard(
            name: 'L’Oréal Paris Elvive Hyaluron Pure Shampoo 400ML',
            imagePaths: [
              'assets/beauty_products/haircare_1/1.png',
            ],
            price: 142.20,
            originalPrice: 0.00,
            rating: 4.0,
            reviewCount: 19,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BeautyProduct11()),
              );
            },
          ),
          SizedBox(height: 10),

          // product 12
          ProductCard(
            name: 'Raw African Booster Shea Set',
            imagePaths: [
              'assets/beauty_products/haircare_2/1.png',
            ],
            price: 650.00,
            originalPrice: 0.00,
            rating: 4.0,
            reviewCount: 19,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BeautyProduct12()),
              );
            },
          ),
          SizedBox(height: 10),

          // product 13
          ProductCard(
            name:
                'Garnier Color Naturals Permanent Crème Hair Color - 8.1 Light Ash Blonde',
            imagePaths: [
              'assets/beauty_products/haircare_3/1.png',
            ],
            price: 132.00,
            originalPrice: 0.00, // No original price shown
            rating: 4.0,
            reviewCount: 19,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BeautyProduct13()),
              );
            },
          ),
          SizedBox(height: 10),

          // product 14
          ProductCard(
            name:
                "L'Oreal Professionnel Absolut Repair 10-In-1 Hair Serum Oil - 90ml",
            imagePaths: [
              'assets/beauty_products/haircare_4/1.png',
            ],
            price: 965.00,
            originalPrice: 1214.00,
            rating: 4.0,
            reviewCount: 19,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BeautyProduct14()),
              );
            },
          ),
          SizedBox(height: 10),

          // product 15
          ProductCard(
            name:
                'CORATED Heatless Curling Rod Headband Kit with Clips and Scrunchie',
            imagePaths: [
              'assets/beauty_products/haircare_5/1.png',
            ],
            price: 94.96,
            originalPrice: 111.98,
            rating: 4.0,
            reviewCount: 19,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BeautyProduct15()),
              );
            },
          ),
          SizedBox(height: 10),

          // product 16
          ProductCard(
            name: 'Avon Far Away for Women, Floral Eau de Parfum 50ml',
            imagePaths: [
              'assets/beauty_products/fragrance_1/1.png',
            ],
            price: 534.51,
            originalPrice: 0.00,
            rating: 4.0,
            reviewCount: 19,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BeautyProduct16()),
              );
            },
          ),
          SizedBox(height: 10),

          // product 17
          ProductCard(
            name:
                'Memwa Coco Memwa Long Lasting Perfume Fragrance Luxury Eau De Parfum EDP Perfume for Women',
            imagePaths: [
              'assets/beauty_products/fragrance_2/1.png',
            ],
            price: 624.04,
            originalPrice: 624.04,
            rating: 4.0,
            reviewCount: 19,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BeautyProduct17()),
              );
            },
          ),
          SizedBox(height: 10),

          // product 18
          ProductCard(
            name:
                'Bath Body Gingham Gorgeous Fine Fragrance Mist, Size/Volume: 8 fl oz / 236 mL',
            imagePaths: [
              'assets/beauty_products/fragrance_3/1.png',
            ],
            price: 1350.00,
            originalPrice: 1350.00,
            rating: 4.0,
            reviewCount: 19,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BeautyProduct18()),
              );
            },
          ),
          SizedBox(height: 10),

          // product 19
          ProductCard(
            name:
                'NIVEA Antiperspirant Spray for Women, Pearl & Beauty Pearl Extracts, 150ml',
            imagePaths: [
              'assets/beauty_products/fragrance_4/1.png',
            ],
            price: 123.00,
            originalPrice: 123.00,
            rating: 4.0,
            reviewCount: 19,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BeautyProduct19()),
              );
            },
          ),
          SizedBox(height: 10),

          // product 20
          ProductCard(
            name:
                'Jacques Bogart One Man Show for Men, Eau de Toilette - 100ml',
            imagePaths: [
              'assets/beauty_products/fragrance_5/1.png',
            ],
            price: 840.00,
            originalPrice: 900.00,
            rating: 4.0,
            reviewCount: 19,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BeautyProduct20()),
              );
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
