import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product16.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product6.dart';
import 'package:pickpay/features/home/presentation/views/widgets/card_item.dart';

class BeautyGrid extends StatefulWidget {
  const BeautyGrid({super.key});

  @override
  State<BeautyGrid> createState() => _BeautyGridState();
}

class _BeautyGridState extends State<BeautyGrid> {
  late PageController _pageController;
  int currentPage = 0;

  final List<Map<String, dynamic>> items = [
    {
      'imagePath': 'assets/beauty_products/fragrance_1/1.png',
      'productName': 'Avon Far Away for Women, Floral Eau de Parfum 50ml',
      'price': '534.51',
      'rating': 5.0,
      'reviewCount': 954,
      'detailPage': const BeautyProduct16(),
    },
    {
      'imagePath': 'assets/beauty_products/makeup_1/1.png',
      'productName':
          'L’Oréal Paris Volume Million Lashes Panorama Mascara in Black, 9.9 ml',
      'price': '401.00',
      'rating': 4.0,
      'reviewCount': 1288,
      'detailPage': const BeautyProduct1(),
    },
    {
      'imagePath': 'assets/beauty_products/makeup_3/1.png',
      'productName': 'Cybele Smooth N`Wear Powder Blush Corail 17 - 3.7gm',
      'price': '227.20',
      'rating': 4.6,
      'reviewCount': 1735,
      'detailPage': const BeautyProduct3(),
    },
    {
      'imagePath': 'assets/beauty_products/skincare_1/1.png',
      'productName': 'Care & More Soft Cream With Glycerin Mixed berries 75 ML',
      'price': '31.00',
      'rating': 4.9,
      'reviewCount': 1893,
      'detailPage': const BeautyProduct6(),
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
