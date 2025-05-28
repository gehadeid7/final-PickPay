import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product18.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product8.dart';
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
      'imagePath': 'assets/Home_products/furniture/furniture2/1.png',
      'productName':
          'Star Bags Bean Bag Chair - Purple, 95*95*97 cm, Unisex Adults',
      'price': '1699.00',
      'rating': 5.0,
      'reviewCount': 954,
      'detailPage': const HomeProduct2(),
    },
    {
      'imagePath': 'assets/Home_products/home-decor/home_decor1/1.png',
      'productName':
          'Golden Lighting LED Gold Lampshade + 1 Crystal Cylinder Bulb.',
      'price': '1128.00',
      'rating': 4.0,
      'reviewCount': 1288,
      'detailPage': const HomeProduct6(),
    },
    {
      'imagePath': 'assets/Home_products/home-decor/home_decor3/1.png',
      'productName': 'Glass Vase 15cm',
      'price': '250.00',
      'rating': 4.6,
      'reviewCount': 1735,
      'detailPage': const HomeProduct8(),
    },
    {
      'imagePath': 'assets/Home_products/bath_and_bedding/bath3/1.png',
      'productName':
          'Bedsure 100% Cotton Blankets Queen Size for Bed - Waffle Weave Blankets for Summer, Lightweight and Breathable Soft Woven Blankets for Spring, Mint, 90x90 Inches ',
      'price': '604.00',
      'rating': 4.9,
      'reviewCount': 1893,
      'detailPage': const HomeProduct18(),
    },
    {
      'imagePath': 'assets/Home_products/kitchen/kitchen1/1.png',
      'productName': 'Neoflam Pote Cookware Set 11-Pieces, Pink Marble',
      'price': '15.795',
      'rating': 4.9,
      'reviewCount': 1893,
      'detailPage': const HomeProduct11(),
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
