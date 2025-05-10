import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product18.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product8.dart';
import 'package:pickpay/features/home/presentation/views/card_item.dart';

class HomeSectionGrid extends StatefulWidget {
  const HomeSectionGrid({super.key});

  @override
  State<HomeSectionGrid> createState() => _HomeSectionGrid();
}

class _HomeSectionGrid extends State<HomeSectionGrid> {
  late PageController _pageController;
  int currentPage = 1; // Start at the first real item

  final List<Map<String, dynamic>> originalItems = [
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

  List<Map<String, dynamic>> get carouselItems {
    final list = [...originalItems];
    list.insert(0, originalItems.last); // Fake first item (last real)
    list.add(originalItems.first); // Fake last item (first real)
    return list;
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentPage);
  }

  void _onPageChanged(int index) {
    setState(() => currentPage = index);

    // Handle wrapping around
    if (index == 0) {
      Future.delayed(const Duration(milliseconds: 300), () {
        _pageController.jumpToPage(originalItems.length);
      });
    } else if (index == originalItems.length + 1) {
      Future.delayed(const Duration(milliseconds: 300), () {
        _pageController.jumpToPage(1);
      });
    }
  }

  void _goLeft() {
    if (_pageController.hasClients) {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  void _goRight() {
    if (_pageController.hasClients) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230, // Adjusted height for better appearance
      width: 600, // Increased width of the carousel
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: carouselItems.length,
            itemBuilder: (context, index) {
              final int firstIndex = index;
              final int secondIndex = index + 1;

              final item1 = carouselItems[firstIndex];
              final item2 = secondIndex < carouselItems.length
                  ? carouselItems[secondIndex]
                  : null;

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
                                  builder: (_) => item1['detailPage']));
                        },
                        child: CardItem(
                          imagePath: item1['imagePath'],
                          productName: item1['productName'],
                          price: item1['price'],
                          rating: item1['rating'],
                          reviewCount: item1['reviewCount'],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    if (item2 != null)
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => item2['detailPage']));
                          },
                          child: CardItem(
                            imagePath: item2['imagePath'],
                            productName: item2['productName'],
                            price: item2['price'],
                            rating: item2['rating'],
                            reviewCount: item2['reviewCount'],
                          ),
                        ),
                      )
                    else
                      const Expanded(
                          child: SizedBox()), // Empty slot if odd number
                  ],
                ),
              );
            },
          ),
          Positioned(
            left: 0,
            top: 100,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: _goLeft,
              splashRadius: 24,
            ),
          ),
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
