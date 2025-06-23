import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product16.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product18.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product20.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product9.dart';
import 'package:pickpay/features/home/presentation/views/widgets/card_item.dart';

class HomeSectionGrid extends StatefulWidget {
  const HomeSectionGrid({super.key});

  @override
  State<HomeSectionGrid> createState() => _HomeSectionGridState();
}

class _HomeSectionGridState extends State<HomeSectionGrid> {
  late PageController _pageController;
  int currentPage = 0;

  final List<Map<String, dynamic>> items = [
    {
      'imagePath': 'assets/Home_products/bath_and_bedding/bath1/1.png',
      'productName': "Banotex Cotton Towel 50x100 (Sugar)",
      'price': '200.00',
      'rating': 4.4,
      'reviewCount': 9,
      'detailPage': const HomeProduct16(),
    },
    {
      'imagePath': 'assets/Home_products/bath_and_bedding/bath3/1.png',
      'productName':
          'Bedsure 100% Cotton Blankets Queen Size for Bed - Waffle Weave Blankets for Summer, Lightweight and Breathable Soft Woven Blankets for Spring, Mint, 90x90 Inches ',
      'price': '604.00',
      'rating': 4.4,
      'reviewCount': 20938,
      'detailPage': const HomeProduct18(),
    },
    {
      'imagePath': 'assets/Home_products/bath_and_bedding/bath5/1.png',
      'productName':
          "Home of Linen - Duvet Cover Set - 3 Pieces for Double Bed - 1 Duvet Cover (185cm*235cm) + 2 Pillow Cases (50cm*70cm) - 100% Egyptian Cotton - Zebra - 802",
      'price': '948.00',
      'rating': 3.8,
      'reviewCount': 84,
      'detailPage': const HomeProduct20(),
    },
    {
      'imagePath': 'assets/Home_products/furniture/furniture1/1.png',
      'productName': "Golden Life Sofa Bed - Size 190 cm - Beige",
      'price': '7850.00',
      'rating': 2.4,
      'reviewCount': 3,
      'detailPage': const HomeProduct1(),
    },
    {
      'imagePath': 'assets/Home_products/furniture/furniture4/1.png',
      'productName':
          "Furgle Gocker Gaming Chair - Ergonomic 3D Swivel, One-Piece Steel Frame, Adjustable Tilt Angle, PU Leather, Gas Lift",
      'price': '9696.00',
      'rating': 3.1,
      'reviewCount': 1,
      'detailPage': const HomeProduct4(),
    },
    {
      'imagePath': 'assets/Home_products/home-decor/home_decor1/1.png',
      'productName':
          'Golden Lighting LED Gold Lampshade + 1 Crystal Cylinder Bulb.',
      'price': '527.86',
      'rating': 3.9,
      'reviewCount': 58,
      'detailPage': const HomeProduct6(),
    },
    {
      'imagePath': 'assets/Home_products/home-decor/home_decor4/1.png',
      'productName':
          "Amotpo Indoor/Outdoor Wall Clock,12-Inch Waterproof Clock with Thermometer and Hygrometer Combo,Battery Operated Quality Quartz Round Clock,Silver",
      'price': '549.00',
      'rating': 4.2,
      'reviewCount': 919,
      'detailPage': const HomeProduct9(),
    },
    {
      'imagePath': 'assets/Home_products/kitchen/kitchen2/1.png',
      'productName':
          "Pasabahce Set of 6 Large Mug with Handle -340ml Turkey Made",
      'price': '495.00',
      'rating': 4.5,
      'reviewCount': 12,
      'detailPage': const HomeProduct12(),
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int get pageCount => (items.length / 2).ceil();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentPage);
  }

  void _onPageChanged(int index) {
    setState(() => currentPage = index);
  }

  void _goLeft() {
    if (_pageController.hasClients && currentPage > 0) {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  void _goRight() {
    if (_pageController.hasClients && currentPage < pageCount - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      width: 600,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: pageCount,
            itemBuilder: (context, index) {
              final int firstIndex = index * 2;
              final int secondIndex = firstIndex + 1;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      items[firstIndex]['detailPage']));
                        },
                        child: CardItem(
                          imagePath: items[firstIndex]['imagePath'],
                          productName: items[firstIndex]['productName'],
                          price: items[firstIndex]['price'],
                          rating: items[firstIndex]['rating'],
                          reviewCount: items[firstIndex]['reviewCount'],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    if (secondIndex < items.length)
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        items[secondIndex]['detailPage']));
                          },
                          child: CardItem(
                            imagePath: items[secondIndex]['imagePath'],
                            productName: items[secondIndex]['productName'],
                            price: items[secondIndex]['price'],
                            rating: items[secondIndex]['rating'],
                            reviewCount: items[secondIndex]['reviewCount'],
                          ),
                        ),
                      )
                    else
                      const Expanded(child: SizedBox()),
                  ],
                ),
              );
            },
          ),
          if (currentPage > 0)
            Positioned(
              left: 0,
              top: 100,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: _goLeft,
                splashRadius: 24,
              ),
            ),
          if (currentPage < pageCount - 1)
            Positioned(
              right: -4.5,
              top: 100,
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: _goRight,
                splashRadius: 24,
              ),
            ),
        ],
      ),
    );
  }
}
