import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/electronics/presentation/views/electronics_view.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product13.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product14.dart';
import 'package:pickpay/features/home/presentation/views/card_item.dart';

class RecommendedForuGridView extends StatefulWidget {
  const RecommendedForuGridView({super.key});

  @override
  State<RecommendedForuGridView> createState() => _RecommendedForuGridView();
}

class _RecommendedForuGridView extends State<RecommendedForuGridView> {
  late PageController _pageController;
  int currentPage = 1; // Start at the first real item

  final List<Map<String, dynamic>> originalItems = [
    {
      'imagePath': 'assets/appliances/product1/1.png',
      'productName':
          'Koldair Water Dispenser Cold And Hot 2 Tabs - Bottom Load KWDB Silver Cooler',
      'price': '10.499',
      'rating': 4.8,
      'reviewCount': 88,
      'detailPage': const AppliancesProduct1(),
    },
    {
      'imagePath': 'assets/electronics_products/Laptop/Laptop3/1.png',
      'productName':
          'HP Victus Gaming Laptop (15-fb1004ne), CPU: Ryzen 5-7535HS, 16GB DDR5 2DM 4800, NVIDIA RTX 2050, 15.6" FHD 144Hz, 512GB, Windows 11',
      'price': '33.199',
      'rating': 4.6,
      'reviewCount': 150,
      'detailPage': const Product13View(),
    },
    {
      'imagePath': 'assets/videogames_products/Controllers/controller4/1.png',
      'productName':
          'PlayStation 5 DualSense Edge Wireless Controller (UAE Version)',
      'price': '16.500',
      'rating': 5.0,
      'reviewCount': 954,
      'detailPage': const ElectronicsView(),
    },
    {
      'imagePath': 'assets/electronics_products/Laptop/Laptop4/1.png',
      'productName': 'HP OfficeJet Pro 9720 Printer',
      'price': '7199.00',
      'rating': 4.4,
      'reviewCount': 19,
      'detailPage': const Product14View(),
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
