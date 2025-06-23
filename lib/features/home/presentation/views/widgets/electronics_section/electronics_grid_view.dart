import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product1.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product12.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product13.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product3.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product5.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product6.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product7.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product9.dart';
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
          'assets/electronics_products/mobile_and_tablet/mobile_and_tablet1/1.png',
      'productName':
          'Samsung Galaxy Tab A9 4G LTE, 8.7 Inch Android Tablet, 8GB RAM, 128GB Storage, 8MP Rear Camera, Navy-1 Year Warranty/Local Version',
      'price': '9399.00',
      'rating': 3.1,
      'reviewCount': 9,
      'detailPage': const Product1View(),
    },
    {
      'imagePath':
          'assets/electronics_products/mobile_and_tablet/mobile_and_tablet3/1.png',
      'productName': 'Apple iPhone 16 (128GB)',
      'price': '53550.00',
      'rating': 4.7,
      'reviewCount': 330,
      'detailPage': const Product3View(),
    },
    {
      'imagePath':
          'assets/electronics_products/mobile_and_tablet/mobile_and_tablet5/1.png',
      'productName':
          "Oraimo 18W USB Type-C Dual Output Super Fast Charger Wall Adapter QC3.0& PD3.0 & PE2.0 Compatible for iPhone 15/15 Plus/15 Pro/15 Pro Max, 14/13/12 Series, Galaxy, Pixel 4/3, iPad and More",
      'price': '199.00',
      'rating': 4.7,
      'reviewCount': 380,
      'detailPage': const Product5View(),
    },
    {
      'imagePath': 'assets/electronics_products/tvscreens/tv1/1.png',
      'productName':
          "Samsung 55 Inch QLED Smart TV Neural HDR Quantum Processor Lite 4K - QA55QE1DAUXEG [2024 Model]",
      'price': '23499.00',
      'rating': 4.5,
      'reviewCount': 46,
      'detailPage': const Product6View(),
    },
    {
      'imagePath': 'assets/electronics_products/tvscreens/tv2/1.png',
      'productName':
          'Xiaomi TV A 43 2025, 43", FHD, HDR, Cinematic Smart TV, 43-Inch Screen Size Google Assistant platform built-in receiver and Chromecast, metal finish Dolby Atoms 2 years local warranty',
      'price': '9999.00',
      'rating': 3.8,
      'reviewCount': 264,
      'detailPage': const Product7View(),
    },
    {
      'imagePath': 'assets/electronics_products/tvscreens/tv4/1.png',
      'productName':
          'SHARP 4K Smart Frameless TV 55 Inch Built-In Receiver 4T-C55FL6EX',
      'price': '17849.00',
      'rating': 4.7,
      'reviewCount': 4,
      'detailPage': const Product9View(),
    },
    {
      'imagePath': 'assets/electronics_products/Laptop/Laptop2/1.png',
      'productName':
          'Lenovo Legion 5 15ACH6 Gaming Laptop - Ryzen 5-5600H, 16 GB RAM, 512 GB SSD, NVIDIA GeForce RTX 3050 Ti 4GB GDDR6 Graphics, 15.6" FHD (1920x1080) IPS 120Hz, Backlit Keyboard, WIN 11',
      'price': '38749.00',
      'rating': 3.4,
      'reviewCount': 14,
      'detailPage': const Product12View(),
    },
    {
      'imagePath': 'assets/electronics_products/Laptop/Laptop3/1.png',
      'productName':
          'HP Victus Gaming Laptop 15-fb1004ne, CPU: Ryzen 5-7535HS, 16GB RAM,512GB SSD, Graphics Card: NVIDIA GeForce RTX 2050, VRAM: 4GB, Display: 15.6 FHD Antiglare IPS 250 nits 144Hz, Windows 11',
      'price': '29999.00',
      'rating': 4.2,
      'reviewCount': 13,
      'detailPage': const Product13View(),
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
