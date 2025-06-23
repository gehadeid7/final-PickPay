import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product9.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product13.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product15.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product20.dart';
import 'package:pickpay/features/home/presentation/views/widgets/card_item.dart';

class RecommendedForuGridView extends StatefulWidget {
  const RecommendedForuGridView({super.key});

  @override
  State<RecommendedForuGridView> createState() => _RecommendedForuGridView();
}

class _RecommendedForuGridView extends State<RecommendedForuGridView> {
  late PageController _pageController;
  int currentPage = 0;

  final List<Map<String, dynamic>> items = [
    {
      'imagePath': 'assets/Home_products/kitchen/kitchen5/1.png',
      'productName':
          "Dish Rack Dish Drying Stand Dish Drainer Plate Rack Dish rake Kitchen Organizer Dish Drying Rack Countertop Large Antibacterial Kitchen Utensils Dish racks Dish Stand (STYLE A)",
      'price': ' 399.00',
      'rating': 3.8,
      'reviewCount': 476,
      'detailPage': HomeProduct15(),
    },
    {
      'imagePath': 'assets/appliances/product9/1.png',
      'productName':
          'Panasonic Powerful Steam/Dry Iron, 1800W, NI-M300TVTD- 1 Year Warranty',
      'price': '10499',
      'rating': 4.8,
      'reviewCount': 1193,
      'detailPage': AppliancesProduct9(),
    },
    {
      'imagePath': 'assets/electronics_products/Laptop/Laptop3/1.png',
      'productName':
          'HP Victus Gaming Laptop (15-fb1004ne), CPU: Ryzen 5-7535HS, 16GB DDR5 2DM 4800, NVIDIA RTX 2050, 15.6" FHD 144Hz, 512GB, Windows 11',
      'price': '29999.00',
      'rating': 4.2,
      'reviewCount': 13,
      'detailPage': Product13View(),
    },
    {
      'imagePath': 'assets/Home_products/bath_and_bedding/bath5/1.png',
      'productName':
          "Home of Linen - Duvet Cover Set - 3 Pieces for Double Bed - 1 Duvet Cover (185cm*235cm) + 2 Pillow Cases (50cm*70cm) - 100% Egyptian Cotton - Zebra - 802",
      'price': ' 948.00',
      'rating': 3.8,
      'reviewCount': 84,
      'detailPage': HomeProduct20(),
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
