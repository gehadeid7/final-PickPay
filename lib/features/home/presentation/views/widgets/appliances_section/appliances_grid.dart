import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product15.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product7.dart';
import 'package:pickpay/features/home/presentation/views/widgets/card_item.dart';

class AppliancesGrid extends StatefulWidget {
  const AppliancesGrid({super.key});

  @override
  State<AppliancesGrid> createState() => _AppliancesGridState();
}

class _AppliancesGridState extends State<AppliancesGrid> {
  late PageController _pageController;
  int currentPage = 0;

  final List<Map<String, dynamic>> items = [
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
      'imagePath': 'assets/appliances/product14/1.png',
      'productName':
          'Black & Decker 1.7L Concealed Coil Stainless Steel Kettle, Jc450-B5, Silver',
      'price': '1594',
      'rating': 4.5,
      'reviewCount': 1162,
      'detailPage': const AppliancesProduct14(),
    },
    {
      'imagePath': 'assets/appliances/product12/1.png',
      'productName':
          'TORNADO Gas Water Heater 6 Liter, Digital, Natural Gas, Silver GHM-C06CNE-S',
      'price': '3719',
      'rating': 4.5,
      'reviewCount': 12,
      'detailPage': const AppliancesProduct12(),
    },
    {
      'imagePath': 'assets/appliances/product11/1.png',
      'productName':
          'Fresh fan 50 watts 18 inches with charger with 3 blades, black and white',
      'price': '3983',
      'rating': 4.4,
      'reviewCount': 674,
      'detailPage': const AppliancesProduct11(),
    },
    {
      'imagePath': 'assets/appliances/product10/1.png',
      'productName': 'Fresh 1600W Faster Vacuum Cleaner with Bag, Black',
      'price': '2830',
      'rating': 4.6,
      'reviewCount': 4576,
      'detailPage': const AppliancesProduct10(),
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
      'imagePath': 'assets/appliances/product6/1.png',
      'productName':
          'deime Air Fryer 6.2 Quart, Large Air Fryer for Families, 5 Cooking Functions AirFryer, 400°F Temp Controls in 5° Increments, Ceramic Coated Nonstick',
      'price': '3629',
      'rating': 4.5,
      'reviewCount': 954,
      'detailPage': const AppliancesProduct6(),
    },
    {
      'imagePath': 'assets/appliances/product4/1.png',
      'productName':
          'Zanussi Automatic Washing Machine, Silver, 8 KG - ZWF8240SX5r',
      'price': '17023',
      'rating': 4.2,
      'reviewCount': 14,
      'detailPage': const AppliancesProduct4(),
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
