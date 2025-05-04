import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product15.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product7.dart';
import 'package:pickpay/features/home/presentation/views/card_item.dart';

class AppliancesGrid extends StatefulWidget {
  const AppliancesGrid({super.key});

  @override
  State<AppliancesGrid> createState() => _AppliancesGrid();
}

class _AppliancesGrid extends State<AppliancesGrid> {
  late PageController _pageController;
  int currentPage = 1; // Start at the first real item

  final List<Map<String, dynamic>> originalItems = [
    {
      'imagePath': 'assets/appliances/product6/1.png',
      'productName':
          'deime Air Fryer 6.2 Quart, Large Air Fryer for Families, 5 Cooking Functions AirFryer, 400°F Temp Controls in 5° Increments, Ceramic Coated Nonstick',
      'price': '3629',
      'rating': 4.5,
      'reviewCount': 954,
      'detailPage': const AppliancesProduct6(),
    },
    {
      'imagePath': 'assets/appliances/product7/1.png',
      'productName': 'Black & Decker DCM25N-B5 Coffee Maker, Black - 1 Cup',
      'price': '930',
      'rating': 4.7,
      'reviewCount': 1288,
      'detailPage': const AppliancesProduct7(),
    },
    {
      'imagePath': 'assets/appliances/product15/1.png',
      'productName':
          ' BLACK & DECKER Dough Mixer With 1000W 3-Blade Motor And 4L Stainless Steel Mixer For 600G Dough Mixer 5.76 Kilograms White/Sliver',
      'price': '6799',
      'rating': 4.6,
      'reviewCount': 1735,
      'detailPage': const AppliancesProduct15(),
    },
    {
      'imagePath': 'assets/appliances/product1/1.png',
      'productName':
          'Koldair Water Dispenser Cold And Hot 2 Tabs - Bottom Load KWDB Silver Cooler',
      'price': '10499',
      'rating': 4.9,
      'reviewCount': 1893,
      'detailPage': const AppliancesProduct1(),
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
