import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product17.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product5.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product8.dart';
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
      'imagePath': 'assets/beauty_products/makeup_1/1.png',
      'productName':
          'L’Oréal Paris Volume Million Lashes Panorama Mascara in Black, 9.9 ml',
      'price': '401.00',
      'rating': 4.0,
      'reviewCount': 1288,
      'detailPage': const BeautyProduct1(),
    },
    {
      'imagePath': 'assets/beauty_products/makeup_2/1.png',
      'productName':
          'L\'Oréal Paris Infaillible 24H Matte Cover Foundation 200 Sable Dore - Oil Control, High Coverage',
      'price': '509.00',
      'rating': 4.2,
      'reviewCount': 4470,
      'detailPage': const BeautyProduct2(),
    },
    {
      'imagePath': 'assets/beauty_products/makeup_5/1.png',
      'productName': 'Maybelline New York Lifter Lip Gloss, 005 Petal',
      'price': '430.00',
      'rating': 4.5,
      'reviewCount': 17782,
      'detailPage': const BeautyProduct5(),
    },
    {
      'imagePath': 'assets/beauty_products/skincare_2/1.png',
      'productName':
          'La Roche-Posay Anthelios XL Non-perfumed Dry Touch oil control gel cream SPF50+ 50ml',
      'price': '1168.70',
      'rating': 4.3,
      'reviewCount': 81,
      'detailPage': const BeautyProduct7(),
    },
    {
      'imagePath': 'assets/beauty_products/skincare_3/1.png',
      'productName':
          'Eva Aloe skin clinic anti-ageing collagen toner for firmed and refined skin - 200ml',
      'price': '158.00',
      'rating': 4.4,
      'reviewCount': 317,
      'detailPage': const BeautyProduct8(),
    },
    {
      'imagePath': 'assets/beauty_products/skincare_5/1.png',
      'productName':
          'L’Oréal Paris Hyaluron Expert Eye Serum with 2.5% Hyaluronic Acid, Caffeine and Niacinamide - 20ml',
      'price': '341.00',
      'rating': 4.2,
      'reviewCount': 899,
      'detailPage': const BeautyProduct10(),
    },
    {
      'imagePath': 'assets/beauty_products/haircare_3/1.png',
      'productName':
          'Garnier Color Naturals Permanent Crème Hair Color - 8.1 Light Ash Blonde',
      'price': '131.55',
      'rating': 4.2,
      'reviewCount': 160,
      'detailPage': const BeautyProduct13(),
    },
    {
      'imagePath': 'assets/beauty_products/fragrance_2/1.png',
      'productName':
          'Memwa Coco Memwa Long Lasting Perfume Fragrance Luxury Eau De Parfum EDP Perfume for Women',
      'price': '608.00',
      'rating': 3.4,
      'reviewCount': 2,
      'detailPage': const BeautyProduct17(),
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
