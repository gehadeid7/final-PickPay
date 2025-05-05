import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pickpay/features/categories_pages/electronics/presentation/views/electronics_view.dart';
import 'package:pickpay/features/home/presentation/views/categories_view.dart';
import 'custom_card_items_feature.dart';
import 'featured_model.dart';

// Dummy destination views (replace with your real views)

class SlidingFeaturedList extends StatelessWidget {
  const SlidingFeaturedList({super.key});

  @override
  Widget build(BuildContext context) {
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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: CarouselSlider.builder(
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
          height: 200,
          autoPlay: true,
          viewportFraction: 1,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(seconds: 1),
        ),
      ),
    );
  }
}
