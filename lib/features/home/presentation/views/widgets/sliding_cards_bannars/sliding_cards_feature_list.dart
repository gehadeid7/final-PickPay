import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pickpay/features/home/presentation/views/widgets/sliding_cards_bannars/custom_card_items_feature.dart';
import 'package:pickpay/features/home/presentation/views/widgets/sliding_cards_bannars/featured_model.dart';

class SlidingFeaturedList extends StatelessWidget {
  const SlidingFeaturedList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FeaturedItem> featuredItems = [
      FeaturedItem(
          image: 'assets/banners/Banner1.jpg',
          title: 'Latest Electronics.',
          subtitle: 'Apple Vision Pro and more'),
      FeaturedItem(
          image: 'assets/banners/Banner2.jpg',
          title: 'Check our newest products.',
          subtitle: 'Electronics, Appliances and more'),
      FeaturedItem(
          image: 'assets/banners/Banner3.jpg',
          title: 'Good measures',
          subtitle: 'Take Your Time'),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: CarouselSlider.builder(
        itemCount: featuredItems.length,
        itemBuilder: (context, index, realIndex) {
          final item = featuredItems[index];
          return SlidingFeatureItem(
            imagePath: item.image,
            title: item.title,
            subtitle: item.subtitle,
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
