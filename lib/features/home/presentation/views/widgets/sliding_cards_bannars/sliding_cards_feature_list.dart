import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pickpay/features/categories_pages/electronics/presentation/views/electronics_view.dart';
import 'package:pickpay/features/home/presentation/views/categories_view.dart';
import 'custom_card_items_feature.dart';
import 'featured_model.dart';

class SlidingFeaturedList extends StatefulWidget {
  const SlidingFeaturedList({super.key});

  @override
  State<SlidingFeaturedList> createState() => _SlidingFeaturedListState();
}

class _SlidingFeaturedListState extends State<SlidingFeaturedList> {
  int _currentIndex = 0;

  final List<FeaturedItem> featuredItems = [
    FeaturedItem(
      image: 'assets/banners/Banner1.jpg',
      title: 'Latest Electronics.',
      subtitle: 'Apple Vision Pro and more',
      destinationView: ElectronicsView(),
    ),
    FeaturedItem(
      image: 'assets/banners/Banner2.jpg',
      title: 'Check our newest products.',
      subtitle: 'Electronics, Appliances and more',
      destinationView: CategoriesView(),
    ),
    FeaturedItem(
      image: 'assets/banners/Banner3.jpg',
      title: 'Good measures',
      subtitle: 'Take Your Time',
      destinationView: CategoriesView(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: featuredItems.length,
          itemBuilder: (context, index, realIndex) {
            final item = featuredItems[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => item.destinationView),
                );
              },
              child: SlidingFeatureItem(
                imagePath: item.image,
                title: item.title,
                subtitle: item.subtitle,
              ),
            );
          },
          options: CarouselOptions(
            height: 220,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 700),
            autoPlayCurve: Curves.easeInOut,
            viewportFraction: 0.98,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
            },
          ),
        ),
        const SizedBox(height: 12),
        // Indicator dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: featuredItems.asMap().entries.map((entry) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              margin: const EdgeInsets.symmetric(horizontal: 6),
              width: _currentIndex == entry.key ? 16 : 10,
              height: 10,
              decoration: BoxDecoration(
                color: _currentIndex == entry.key
                    ? const Color.fromRGBO(62, 133, 255, 1)
                    : Colors.blueAccent.withOpacity(0.3),
                borderRadius: BorderRadius.circular(6),
                boxShadow: _currentIndex == entry.key
                    ? [
                        BoxShadow(
                          color: const Color.fromARGB(255, 30, 56, 102)
                              .withOpacity(0.6),
                          blurRadius: 4,
                          offset: const Offset(0, 3),
                        )
                      ]
                    : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
