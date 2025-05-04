import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/electronics/presentation/views/electronics_view.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product1.dart';
import 'package:pickpay/features/home/presentation/views/card_item.dart';

class RecommendedForuGridView extends StatelessWidget {
  const RecommendedForuGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> recommendedProducts = [
      {
        'imagePath': 'assets/appliances/product1/1.png',
        'productName':
            'Koldair Water Dispenser Cold And Hot 2 Tabs - Bottom Load KWDB Silver Cooler',
        'price': '10.499',
        'rating': 4.8,
        'reviewCount': 88,
        'detailPage': const AppliancesProduct1(),
      },
      {
        'imagePath': 'assets/electronics_products/Laptop/Laptop3/1.png',
        'productName':
            'HP Victus Gaming Laptop (15-fb1004ne), CPU: Ryzen 5-7535HS, 16GB DDR5 2DM 4800, NVIDIA RTX 2050, 15.6" FHD 144Hz, 512GB, Windows 11',
        'price': '33.199',
        'rating': 4.6,
        'reviewCount': 150,
        'detailPage': const ElectronicsView(),
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 16,
        childAspectRatio: 180 / 230,
      ),
      itemCount: recommendedProducts.length,
      itemBuilder: (context, index) {
        final product = recommendedProducts[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => product['detailPage']),
            );
          },
          child: CardItem(
            imagePath: product['imagePath'],
            productName: product['productName'],
            price: product['price'],
            rating: product['rating'],
            reviewCount: product['reviewCount'],
          ),
        );
      },
    );
  }
}
