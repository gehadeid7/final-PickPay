import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product8.dart';
import 'package:pickpay/features/home/presentation/views/widgets/card_item.dart';

class VgamesGrid extends StatefulWidget {
  const VgamesGrid({super.key});

  @override
  State<VgamesGrid> createState() => _VgamesGrid();
}

class _VgamesGrid extends State<VgamesGrid> {
  late PageController _pageController;
  int currentPage = 1; // Start at the first real item

  final List<Map<String, dynamic>> originalItems = [
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
