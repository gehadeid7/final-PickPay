import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pickpay/features/home/presentation/views/widgets/custom_card.dart';

class SlidingCards extends StatelessWidget {
  const SlidingCards({super.key});

  final List<String> bannerTexts = const [
    'Latest Electronics.                                                        Apple Vision Pro and more..',
    'Check our newest products.                      Electronics, Appliances and more...',
    'Good measures.                                                   Take your tiiiiiiiiiiiiiiiiime........',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        viewportFraction: 1,
        autoPlayCurve: Curves.fastOutSlowIn,
        autoPlayAnimationDuration: const Duration(seconds: 1),
      ),
      itemCount: 3,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return CustomCard(
          image: 'assets/banners/Banner${index + 1}.jpg',
          text: bannerTexts[index], 
        );
      },
    );
  }
}
