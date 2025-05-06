import 'package:flutter/material.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/widgets/custom_app.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';

class HomeCategoryViewBody extends StatelessWidget {
  const HomeCategoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Home'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          SizedBox(height: kTopPadding),

// product 1
          ProductCard(
            id: '68132a95ff7813b3d47f9da5',
            name: 'Golden Life Sofa Bed - Size 190 cm - Beige',
            imagePaths: [
              'assets/Home_products/furniture/furniture1/1.png',
            ],
            price: 7850.00,
            originalPrice: 0,
            rating: 5.0,
            reviewCount: 88,
          ),
          SizedBox(height: 10),

// product 2
          ProductCard(
            id: '68132a95ff7813b3d47f9da5',
            name:
                'Star Bags Bean Bag Chair - Purple, 95*95*97 cm, Unisex Adults',
            imagePaths: [
              'assets/Home_products/furniture/furniture2/1.png',
            ],
            price: 1699.00,
            originalPrice: 2499.00,
            rating: 5.0,
            reviewCount: 88,
          ),
          SizedBox(height: 10),

// product 3
          ProductCard(
            id: '68132a95ff7813b3d47f9da5',
            name: 'Generic Coffee Table, Round, 71 cm x 45 cm, Black',
            imagePaths: [
              'assets/Home_products/furniture/furniture3/1.png',
            ],
            price: 3600.00,
            originalPrice: 0,
            rating: 5.0,
            reviewCount: 88,
          ),
          SizedBox(height: 10),

// product 4
          ProductCard(
            id: '68132a95ff7813b3d47f9da5',
            name:
                'Gaming Chair, Furgle Gocker Ergonomic Adjustable 3D Swivel Chair',
            imagePaths: [
              'assets/Home_products/furniture/furniture4/1.png',
            ],
            price: 9696.55,
            originalPrice: 12071.00,
            rating: 5.0,
            reviewCount: 92,
          ),
          SizedBox(height: 10),

// product 5
          ProductCard(
            id: '68132a95ff7813b3d47f9da5',
            name:
                'Janssen Almany Innerspring Mattress Height 25 cm - 120 x 195 cm',
            imagePaths: [
              'assets/Home_products/furniture/furniture5/1.png',
            ],
            price: 5060.03,
            originalPrice: 0,
            rating: 5.0,
            reviewCount: 88,
          ),
          SizedBox(height: 10),
// Product 6
          ProductCard(
            id: '68132a95ff7813b3d47f9da5',
            name:
                'Golden Lighting LED Gold Lampshade + 1 Crystal Cylinder Bulb.',
            imagePaths: [
              'assets/Home_products/home-decor/home_decor1/1.png',
            ],
            price: 1128.00,
            originalPrice: 0.0,
            rating: 4.0,
            reviewCount: 19,
          ),
          SizedBox(height: 10),

// Product 7
          ProductCard(
            id: '68132a95ff7813b3d47f9da5',
            name:
                'Luxury Bathroom Rug Shaggy Bath Mat 60x40 Cm, Washable Non Slip, Soft Chenille, Gray',
            imagePaths: [
              'assets/Home_products/home-decor/home_decor2/1.png',
            ],
            price: 355.00,
            originalPrice: 0.0,
            rating: 4.0,
            reviewCount: 19,
          ),
          SizedBox(height: 10),

// Product 8
          ProductCard(
            id: '68132a95ff7813b3d47f9da5',
            name: 'Glass Vase 15cm',
            imagePaths: [
              'assets/Home_products/home-decor/home_decor3/1.png',
            ],
            price: 250.00,
            originalPrice: 0.0,
            rating: 4.0,
            reviewCount: 19,
          ),
          SizedBox(height: 10),

// Product 9
          ProductCard(
            id: '68132a95ff7813b3d47f9da5',
            name:
                'Amotpo Indoor/Outdoor Wall Clock, 12-Inch Waterproof with Thermometer & Hygrometer',
            imagePaths: [
              'assets/Home_products/home-decor/home_decor4/1.png',
            ],
            price: 549.00,
            originalPrice: 0.0,
            rating: 4.0,
            reviewCount: 19,
          ),
          SizedBox(height: 10),

// Product 10
          ProductCard(
            id: '68132a95ff7813b3d47f9da5',
            name:
                'Oliruim Black Home Decor Accent Art Woman Face Statue - 2 Pieces Set',
            imagePaths: [
              'assets/Home_products/home-decor/home_decor5/1.png',
            ],
            price: 650.00,
            originalPrice: 0.0,
            rating: 5.0,
            reviewCount: 19,
          ),
          SizedBox(height: 10),

          // product 11
          ProductCard(
            id: '68132a95ff7813b3d47f9da5',
            name: 'Neoflam Pote Cookware Set 11-Pieces, Pink Marble',
            imagePaths: [
              'assets/Home_products/kitchen/kitchen1/1.png',
            ],
            price: 15.795,
            originalPrice: 18.989,
            rating: 4.8,
            reviewCount: 19,
          ),
          SizedBox(height: 10),

          // product 12
          ProductCard(
            id: '68132a95ff7813b3d47f9da5',
            name: 'Pasabahce Set of 6 Large Mug with Handle -340ml Turkey Made',
            imagePaths: [
              'assets/Home_products/kitchen/kitchen2/1.png',
            ],
            price: 495.00,
            originalPrice: 590.99,
            rating: 4.9,
            reviewCount: 1439,
          ),
          SizedBox(height: 10),

          // product 13
          ProductCard(
            id: '68132a95ff7813b3d47f9da5',
            name:
                'P&P CHEF 13½ Inch Pizza Pan Set, 3 Pack Nonstick Pizza Pans, Round Pizza Tray Bakeware for Oven Baking, Stainless Steel Core & Easy to Clean, Non Toxic & Durable, Black',
            imagePaths: [
              'assets/Home_products/kitchen/kitchen3/1.png',
            ],
            price: 276.00,
            originalPrice: 300.00,
            rating: 4.5,
            reviewCount: 1162,
          ),
          SizedBox(height: 10),

          // product 14
          ProductCard(
            id: '68132a95ff7813b3d47f9da5',
            name:
                ' LIANYU 20 Piece Silverware Flatware Cutlery Set, Stainless Steel Utensils Service for 4, Include Knife Fork Spoon, Mirror Polished, Dishwasher Safe ',
            imagePaths: [
              'assets/Home_products/kitchen/kitchen4/1.png',
            ],
            price: 50.099,
            originalPrice: 69.99,
            rating: 4.6,
            reviewCount: 1735,
          ),
          SizedBox(height: 10),

          // product 15
          ProductCard(
            id: '68132a95ff7813b3d47f9da5',
            name:
                ' Dish Rack Dish Drying Stand Dish Drainer Plate Rack Dish rake Kitchen Organizer Dish Drying Rack Countertop Large Antibacterial Kitchen Utensils Dish racks Dish Stand (STYLE A)',
            imagePaths: [
              'assets/Home_products/kitchen/kitchen5/1.png',
            ],
            price: 400.00,
            originalPrice: 550.99,
            rating: 4.6,
            reviewCount: 4576,
          ),
          SizedBox(height: 10),

          // product 16
          ProductCard(
            id: '68132a95ff7813b3d47f9da5',
            name: 'Banotex Cotton Towel 50x100 (Sugar)',
            imagePaths: [
              'assets/Home_products/bath_and_bedding/bath1/1.png',
            ],
            price: 170.00,
            originalPrice: 200.99,
            rating: 4.6,
            reviewCount: 4576,
          ),
          SizedBox(height: 10),
          // product 17
          ProductCard(
            id: '68132a95ff7813b3d47f9da5',
            name: 'Fiber pillow 2 pieces size 40x60',
            imagePaths: [
              'assets/Home_products/bath_and_bedding/bath2/1.png',
            ],
            price: 180.00,
            originalPrice: 200.99,
            rating: 4.6,
            reviewCount: 4576,
          ),
          SizedBox(height: 10),
          // product 18
          ProductCard(
            id: '68132a95ff7813b3d47f9da5',
            name:
                'Bedsure 100% Cotton Blankets Queen Size for Bed - Waffle Weave Blankets for Summer, Lightweight and Breathable Soft Woven Blankets for Spring, Mint, 90x90 Inches ',
            imagePaths: [
              'assets/Home_products/bath_and_bedding/bath3/1.png',
            ],
            price: 604.00,
            originalPrice: 700.99,
            rating: 4.6,
            reviewCount: 4576,
          ),
          SizedBox(height: 10),
          // product 19
          ProductCard(
            id: '68132a95ff7813b3d47f9da5',
            name: 'Home of linen-fitted sheet set, size 120 * 200cm, offwhite',
            imagePaths: [
              'assets/Home_products/bath_and_bedding/bath4/1.png',
            ],
            price: 369.00,
            originalPrice: 400.99,
            rating: 4.6,
            reviewCount: 4576,
          ),
          SizedBox(height: 10),
          // product 20
          ProductCard(
            id: '68132a95ff7813b3d47f9da5',
            name:
                'Home of Linen - Duvet Cover Set - 3 Pieces for Double Bed - 1 Duvet Cover (185cm*235cm) + 2 Pillow Cases (50cm*70cm) - 100% Egyptian Cotton - Zebra - 802',
            imagePaths: [
              'assets/Home_products/bath_and_bedding/bath5/1.png',
            ],
            price: 948.00,
            originalPrice: 1000.99,
            rating: 4.6,
            reviewCount: 4576,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
