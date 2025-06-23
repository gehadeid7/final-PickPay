import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product15.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product5.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product9.dart';
import 'package:pickpay/features/home/presentation/views/widgets/card_item.dart';

class FashionGrid extends StatefulWidget {
  const FashionGrid({super.key});

  @override
  State<FashionGrid> createState() => _FashionGridState();
}

class _FashionGridState extends State<FashionGrid> {
  late PageController _pageController;
  int currentPage = 0;

  final List<Map<String, dynamic>> items = [
    {
      'imagePath':
          "assets/Fashion_products/Men_Fashion/men_fashion4/black/1.png",
      'productName': "Timberland Ek Larchmont Ftm_Chelsea, Men's Boots",
      'price': '10499.00',
      'rating': 4.3,
      'reviewCount': 57,
      'detailPage': const FashionProduct9(),
    },
    {
      'imagePath': 'assets/Fashion_products/Women_Fashion/women_fashion5/1.png',
      'productName': 'Aldo Caraever Ladies Satchel Handbags, Khaki, Khaki',
      'price': '5190.00',
      'rating': 4.9,
      'reviewCount': 1893,
      'detailPage': const FashionProduct5(),
    },
    {
      'imagePath': "assets/Fashion_products/Women_Fashion/women_fashion4/1.png",
      'productName': 'Dejavu womens JAL-DJTF-058 Sandal',
      'price': '1259.00',
      'rating': 5.0,
      'reviewCount': 88,
      'detailPage': const FashionProduct4(),
    },
    {
      'imagePath': 'assets/Fashion_products/Women_Fashion/women_fashion3/1.png',
      'productName': 'American Eagle Womens Low-Rise Baggy Wide-Leg Jean',
      'price': '2700.00',
      'rating': 3.1,
      'reviewCount': 9,
      'detailPage': const FashionProduct3(),
    },
    {
      'imagePath': "assets/Fashion_products/Kids_Fashion/kids_fashion5/1.png",
      'productName': "MIX & MAX, Ballerina Shoes, girls, Ballet Flat",
      'price': '354.00',
      'rating': 5.0,
      'reviewCount': 1,
      'detailPage': const FashionProduct15(),
    },
    {
      'imagePath': "assets/Fashion_products/Kids_Fashion/kids_fashion4/1.png",
      'productName':
          'Baby Boys Jacket Fashion Comfortable High Quality Plush Full Warmth Jacket for Your Baby',
      'price': '425.00',
      'rating': 5.0,
      'reviewCount': 1,
      'detailPage': const FashionProduct14(),
    },
    {
      'imagePath': "assets/Fashion_products/Kids_Fashion/kids_fashion3/1.png",
      'productName':
          'DeFacto Girls Cropped Fit Long Sleeve B9857A8 Denim Jacket',
      'price': '899.00',
      'rating': 5.0,
      'reviewCount': 1,
      'detailPage': const FashionProduct13(),
    },
    {
      'imagePath': "assets/Fashion_products/Men_Fashion/men_fashion5/1.png",
      'productName':
          "Timberland Men's Leather Trifold Wallet Hybrid, Brown/Black, One Size",
      'price': ' 1399.33',
      'rating': 4.6,
      'reviewCount': 1118,
      'detailPage': const FashionProduct10(),
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
