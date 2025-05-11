import 'package:flutter/material.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product15.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product5.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product9.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';

class FashionViewbody extends StatelessWidget {
  const FashionViewbody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Fashion'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          SizedBox(height: kTopPadding),

          // Product 1
          ProductCard(
            id: '68132a95ff7813b3d47f9da1',
            name: "Women's Chiffon Lining Batwing Sleeve Dress",
            imagePaths: [
              "assets/Fashion_products/Women_Fashion/women_fashion1/1.png",
            ],
            price: 850.00,
            originalPrice: 970.00,
            rating: 5.0,
            reviewCount: 88,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FashionProduct1()),
              );
            },
          ),
          SizedBox(height: 10),

// Product 2
          ProductCard(
            id: '68132a95ff7813b3d47f9da2',
            name: "adidas womens ULTIMASHOW Shoes",
            imagePaths: [
              "assets/Fashion_products/Women_Fashion/women_fashion2/1.png",
            ],
            price: 1456.53,
            originalPrice: 2188.06,
            rating: 5.0,
            reviewCount: 88,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FashionProduct2()),
              );
            },
          ),
          SizedBox(height: 10),

// Product 3
          ProductCard(
            id: '68132a95ff7813b3d47f9da3',
            name: "American Eagle Womens Low-Rise Baggy Wide-Leg Jean",
            imagePaths: [
              "assets/Fashion_products/Women_Fashion/women_fashion3/1.png",
            ],
            price: 2700.00,
            originalPrice: 0,
            rating: 5.0,
            reviewCount: 88,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FashionProduct3()),
              );
            },
          ),
          SizedBox(height: 10),

// Product 4
          ProductCard(
            id: '68132a95ff7813b3d47f9da4',
            name: "Dejavu womens JAL-DJTF-058 Sandal",
            imagePaths: [
              "assets/Fashion_products/Women_Fashion/women_fashion4/1.png",
            ],
            price: 1399.00,
            originalPrice: 0,
            rating: 5.0,
            reviewCount: 92,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FashionProduct4()),
              );
            },
          ),
          SizedBox(height: 10),

// Product 5
          ProductCard(
            id: '68132a95ff7813b3d47f9da5',
            name: "Aldo Caraever Ladies Satchel Handbags, Khaki, Khaki",
            imagePaths: [
              "assets/Fashion_products/Women_Fashion/women_fashion5/1.png",
            ],
            price: 799,
            originalPrice: 0,
            rating: 5.0,
            reviewCount: 88,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FashionProduct5()),
              );
            },
          ),
          SizedBox(height: 10),

          // Product 6
          ProductCard(
            id: '68132a95ff7813b3d47f9da6',
            name:
                "DeFacto Man Modern Fit Polo Neck Short Sleeve B6374AX Polo T-Shirt",
            imagePaths: [
              "assets/Fashion_products/Men_Fashion/men_fashion1/1.png",
            ],
            price: 352.00,
            originalPrice: 899.00,
            rating: 4.0,
            reviewCount: 19,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FashionProduct6()),
              );
            },
          ),
          SizedBox(height: 10),

// Product 7
          ProductCard(
            id: '68132a95ff7813b3d47f9da7',
            name: "DOTT JEANS WEAR Men's Relaxed Fit Jeans",
            imagePaths: [
              "assets/Fashion_products/Men_Fashion/men_fashion2/1.png",
            ],
            price: 718.30,
            originalPrice: 799.00,
            rating: 4.0,
            reviewCount: 19,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FashionProduct7()),
              );
            },
          ),
          SizedBox(height: 10),

// Product 8
          ProductCard(
            id: '68132a95ff7813b3d47f9da8',
            name:
                "Sport-Q®Fury-X Latest Model Football Shoes X Football Shoes Combining Comfort Precision and Performance Excellence in Game.",
            imagePaths: [
              "assets/Fashion_products/Men_Fashion/men_fashion3/1.png",
            ],
            price: 269.00,
            originalPrice: 299.00,
            rating: 4.0,
            reviewCount: 19,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FashionProduct8()),
              );
            },
          ),
          SizedBox(height: 10),

// Product 9
          ProductCard(
            id: '68132a95ff7813b3d47f9da9',
            name: "Timberland Ek Larchmont Ftm_Chelsea, Men's Boots",
            imagePaths: [
              "assets/Fashion_products/Men_Fashion/men_fashion4/1.png",
            ],
            price: 10499,
            originalPrice: 11000,
            rating: 4.3,
            reviewCount: 57,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FashionProduct9()),
              );
            },
          ),
          SizedBox(height: 10),

// Product 10
          ProductCard(
            id: '68132a95ff7813b3d47f9da10',
            name:
                "Timberland Men's Leather Trifold Wallet Hybrid, Brown/Black, One Size",
            imagePaths: [
              "assets/Fashion_products/Men_Fashion/men_fashion5/1.png",
            ],
            price: 1399,
            originalPrice: 1511,
            rating: 4.6,
            reviewCount: 1118,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FashionProduct10()),
              );
            },
          ),
          SizedBox(height: 10),

          // product 11
          ProductCard(
            id: '68132a95ff7813b3d47f9da11',
            name: "LC WAIKIKI Crew Neck Girl's Shorts Pajama Set",
            imagePaths: [
              "assets/Fashion_products/Kids_Fashion/kids_fashion1/1.png",
            ],
            price: 261,
            originalPrice: 349,
            rating: 4.3,
            reviewCount: 11,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FashionProduct11()),
              );
            },
          ),
          SizedBox(height: 10),

// product 12
          ProductCard(
            id: '68132a95ff7813b3d47f9da12',
            name: "Kidzo Boys Pajamas",
            imagePaths: [
              "assets/Fashion_products/Kids_Fashion/kids_fashion2/1.png",
            ],
            price: 580,
            originalPrice: 621,
            rating: 5.0,
            reviewCount: 3,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FashionProduct12()),
              );
            },
          ),
          SizedBox(height: 10),

// product 13
          ProductCard(
            id: '68132a95ff7813b3d47f9da13',
            name: "DeFacto Girls Cropped Fit Long Sleeve B9857A8 Denim Jacket",
            imagePaths: [
              "assets/Fashion_products/Kids_Fashion/kids_fashion3/1.png",
            ],
            price: 899.00,
            originalPrice: 899.00,
            rating: 4.0,
            reviewCount: 19,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FashionProduct13()),
              );
            },
          ),
          SizedBox(height: 10),

// product 14
          ProductCard(
            id: '68132a95ff7813b3d47f9da14',
            name:
                "Baby Boys Jacket Fashion Comfortable High Quality Plush Full Warmth Jacket for Your Baby",
            imagePaths: [
              "assets/Fashion_products/Kids_Fashion/kids_fashion4/1.png",
            ],
            price: 425,
            originalPrice: 475,
            rating: 5.0,
            reviewCount: 19,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FashionProduct14()),
              );
            },
          ),
          SizedBox(height: 10),

// product 15
          ProductCard(
            id: '68132a95ff7813b3d47f9da15',
            name: "MIX & MAX, Ballerina Shoes, girls, Ballet Flat",
            imagePaths: [
              "assets/Fashion_products/Kids_Fashion/kids_fashion5/1.png",
            ],
            price: 354.65,
            originalPrice: 429.00,
            rating: 5.0,
            reviewCount: 19,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FashionProduct15()),
              );
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
