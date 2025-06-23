import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product5.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product8.dart';
import 'package:pickpay/features/home/presentation/views/widgets/card_item.dart';

class VgamesGrid extends StatefulWidget {
  const VgamesGrid({super.key});

  @override
  State<VgamesGrid> createState() => _VgamesGridState();
}

class _VgamesGridState extends State<VgamesGrid> {
  late final PageController _pageController;
  int currentPage = 0;

  final List<Map<String, dynamic>> items = [
    {
      'imagePath': 'assets/videogames_products/Consoles/console1/2.png',
      'productName': 'PlayStation 5 Digital Console (Slim)',
      'price': '27750.00',
      'rating': 4.6,
      'reviewCount': 893,
      'detailPage': const VideoGamesProduct1(),
    },
    {
      'imagePath': 'assets/videogames_products/Consoles/console3/1.png',
      'productName': 'PlayStation 5 Digital Edition Slim (Nordic)',
      'price': '28799.00',
      'rating': 4.8,
      'reviewCount': 36,
      'detailPage': const VideoGamesProduct3(),
    },
    {
      'imagePath': 'assets/videogames_products/Controllers/controller1/1.png',
      'productName': 'Sony PlayStation 5 DualSense Wireless Controller',
      'price': '4499.00',
      'rating': 5.0,
      'reviewCount': 3,
      'detailPage': const VideoGamesProduct5(),
    },
    {
      'imagePath': 'assets/videogames_products/Controllers/controller2/1.png',
      'productName':
          'PlayStation Sony DualSense wireless controller for PS5 White',
      'price': '4536.00',
      'rating': 4.4,
      'reviewCount': 2313,
      'detailPage': const VideoGamesProduct6(),
    },
    {
      'imagePath': 'assets/videogames_products/Controllers/controller4/1.png',
      'productName':
          'PlayStation 5 DualSense Edge Wireless Controller (UAE Version)',
      'price': '16.500',
      'rating': 5.0,
      'reviewCount': 954,
      'detailPage': const VideoGamesProduct8(),
    },
    {
      'imagePath': 'assets/videogames_products/Accessories/accessories1/1.png',
      'productName':
          'Likorlove PS5 Controller Quick Charger, Dual USB Fast Charging Dock Station Stand for Playstation 5 DualSense Controllers Console with LED Indicator USB Type C Ports, White [2.5-3 Hours]',
      'price': '576.00',
      'rating': 4.3,
      'reviewCount': 185,
      'detailPage': const VideoGamesProduct10(),
    },
    {
      'imagePath': 'assets/videogames_products/Accessories/accessories2/1.png',
      'productName':
          'OIVO PS5 Charging Station, 2H Fast PS5 Controller Charger for Playstation 5 Dualsense Controller, Upgrade PS5 Charging Dock with 2 Types of Cable, PS5 Charger for Dual PS5 Controller',
      'price': '1200.00',
      'rating': 4.6,
      'reviewCount': 1573,
      'detailPage': const VideoGamesProduct11(),
    },
    {
      'imagePath': 'assets/videogames_products/Accessories/accessories4/1.png',
      'productName':
          'Mcbazel PS5 Cooling Station and Charging Station, 3 Speed Fan, Controller Dock with LED Indicator and 11 Storage Discs - White(Not for PS5 Pro)',
      'price': '1999.00',
      'rating': 3.9,
      'reviewCount': 38,
      'detailPage': const VideoGamesProduct13(),
    },
  ];

  int get pageCount => (items.length / 2).ceil();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => currentPage = index);
  }

  void _goLeft() {
    if (currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goRight() {
    if (currentPage < pageCount - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
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
                              builder: (_) => items[firstIndex]['detailPage'],
                            ),
                          );
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
                                    items[secondIndex]['detailPage'],
                              ),
                            );
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
