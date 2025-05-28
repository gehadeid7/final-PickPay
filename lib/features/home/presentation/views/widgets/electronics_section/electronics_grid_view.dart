import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product11.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product14.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product3.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product4.dart';
import 'package:pickpay/features/home/presentation/views/widgets/card_item.dart';

class ElectronicsCarouselView extends StatefulWidget {
  const ElectronicsCarouselView({super.key});

  @override
  State<ElectronicsCarouselView> createState() => _ElectronicsCarouselView();
}

class _ElectronicsCarouselView extends State<ElectronicsCarouselView> {
  late PageController _pageController;
  int currentPage = 0;

  final List<Map<String, dynamic>> items = [
    {
      'imagePath':
          'assets/electronics_products/mobile_and_tablet/mobile_and_tablet3/1.png',
      'productName': 'Apple iPhone 16 (128GB) - Ultramarine',
      'price': '57555.00',
      'rating': 4.8,
      'reviewCount': 88,
      'detailPage': const Product3View(),
    },
    {
      'imagePath':
          'assets/electronics_products/mobile_and_tablet/mobile_and_tablet4/1.png',
      'productName': 'CANSHN Magnetic iPhone 16 Pro Max Case, Clear',
      'price': '141.25',
      'rating': 4.6,
      'reviewCount': 92,
      'detailPage': const Product4View(),
    },
    {
      'imagePath': 'assets/electronics_products/Laptop/Laptop1/1.png',
      'productName': 'LENOVO Ideapad Slim3 15IRH8',
      'price': '24313.00',
      'rating': 4.9,
      'reviewCount': 19,
      'detailPage': const Product11View(),
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
