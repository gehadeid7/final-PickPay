import 'package:flutter/material.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/widgets/custom_app.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';

class VideogamesViewBody extends StatelessWidget {
  const VideogamesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: [
          SizedBox(height: kTopPadding),
          buildAppBar(context: context, title: 'Video Games'),
          ProductCard(
            name: 'Sony PlayStation 5 SLIM Disc',
            imagePaths: [
              'assets/Categories/VideoGames/products/ps5/ps5.png',
              'assets/Categories/VideoGames/products/ps5/ps52.png',
              'assets/Categories/VideoGames/products/ps5/ps53.png',
            ],
            price: 449.99,
            originalPrice: 499.99,
            rating: 4.8,
            reviewCount: 2571,
          ),
          SizedBox(
            height: 10,
          ),
          ProductCard(
            name: 'Sony DualSense Wireless Controller for PlayStation 5',
            imagePaths: [
              'assets/Categories/VideoGames/products/ps5controller/whitecontroller2.png',
              'assets/Categories/VideoGames/products/ps5controller/whitecontroller.png',
            ],
            price: 66.99,
            originalPrice: 124.89,
            rating: 4.7,
            reviewCount: 3538,
          ),
          SizedBox(
            height: 10,
          ),
          ProductCard(
            name:
                'Sony DualSense Wireless Controller for PlayStation 5 (Black)',
            imagePaths: [
              'assets/Categories/VideoGames/products/ps5controller/blackcontroller.png',
            ],
            price: 66.99,
            originalPrice: 124.89,
            rating: 4.7,
            reviewCount: 3538,
          ),
          SizedBox(
            height: 10,
          ),
          ProductCard(
            name: 'The Last of Us Part I - PlayStation 5',
            imagePaths: [
              'assets/Categories/VideoGames/products/games/lastofuspt11.png',
              'assets/Categories/VideoGames/products/games/lastofuspt1.png',
            ],
            price: 48.99,
            originalPrice: 69.99,
            rating: 4.9,
            reviewCount: 814,
          ),
          SizedBox(
            height: 10,
          ),
          ProductCard(
            name: 'Call of Duty: Modern Warfare II - Xbox Series X',
            imagePaths: [
              'assets/Categories/VideoGames/products/games/cod.png',
              'assets/Categories/VideoGames/products/games/cod1.png'
            ],
            price: 44.89,
            originalPrice: 69.99,
            rating: 4.4,
            reviewCount: 557,
          ),
          SizedBox(
            height: 10,
          ),
          ProductCard(
            name: 'Gaming Headset for PS4, PS5, Xbox One, Switch & PC',
            imagePaths: [
              'assets/Categories/VideoGames/products/headset/headset.png',
              'assets/Categories/VideoGames/products/headset/headset1.png',
            ],
            price: 19.99,
            originalPrice: 29.99,
            rating: 4.2,
            reviewCount: 698,
          ),
        ],
      ),
    );
  }
}
