import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product14.dart';
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
      'imagePath': 'assets/videogames_products/Controllers/controller4/1.png',
      'productName':
          'PlayStation 5 DualSense Edge Wireless Controller (UAE Version)',
      'price': '16.500',
      'rating': 5.0,
      'reviewCount': 954,
      'detailPage': const VideoGamesProduct8(),
    },
    {
      'imagePath': 'assets/videogames_products/Accessories/accessories5/1.png',
      'productName':
          'EA SPORTS FC 25 Standard Edition PS5 | VideoGame | English',
      'price': '1128.00',
      'rating': 4.0,
      'reviewCount': 1288,
      'detailPage': const VideoGamesProduct14(),
    },
    {
      'imagePath': 'assets/videogames_products/Consoles/console1/2.png',
      'productName':
          'Sony PlayStation 5 SLIM Disc [ NEW 2023 Model ] - International Version',
      'price': '27.750',
      'rating': 4.6,
      'reviewCount': 1735,
      'detailPage': const VideoGamesProduct1(),
    },
    {
      'imagePath': 'assets/videogames_products/Controllers/controller3/1.png',
      'productName': 'PlayStation 5 Dual Sense Wireless Controller Cosmic Red',
      'price': ' 4.498',
      'rating': 4.9,
      'reviewCount': 1893,
      'detailPage': const VideoGamesProduct7(),
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
