import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product5.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product9.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product15.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';
import 'package:pickpay/services/api_service.dart';

class AppliancesViewBody extends StatelessWidget {
  const AppliancesViewBody({super.key});

  // Map of key phrases to detail pages with their static data
  static final Map<String, Map<String, dynamic>> productData = {
    'TORNADO': {
      'page': AppliancesProduct12(),
      'rating': 4.5,
      'reviewCount': 12,
      'image': 'assets/appliances/product12/1.png',
    },
    'Vacuum Cleaner': {
      'page': AppliancesProduct10(),
      'rating': 4.6,
      'reviewCount': 4576,
      'image': 'assets/appliances/product10/1.png',
    },
    'Dough Mixer': {
      'page': AppliancesProduct15(),
      'rating': 4.6,
      'reviewCount': 1735,
      'image': 'assets/appliances/product15/1.png',
    },
    'Blender': {
      'page': AppliancesProduct13(),
      'rating': 4.9,
      'reviewCount': 1439,
      'image': 'assets/appliances/product13/1.png',
    },
    'Refrigerator': {
      'page': AppliancesProduct3(),
      'rating': 4.5,
      'reviewCount': 12,
      'image': 'assets/appliances/product3/1.png',
    },
    'Air Fryer': {
      'page': AppliancesProduct6(),
      'rating': 3.1,
      'reviewCount': 9,
      'image': 'assets/appliances/product6/1.png',
    },
    'Water Dispenser': {
      'page': AppliancesProduct1(),
      'rating': 3.9,
      'reviewCount': 9,
      'image': 'assets/appliances/product1/1.png',
    },
    'Stainless Steel Potato': {
      'page': AppliancesProduct2(),
      'rating': 3.1,
      'reviewCount': 9,
      'image': 'assets/appliances/product2/1.png',
    },
    'Washing Machine': {
      'page': AppliancesProduct4(),
      'rating': 4.2,
      'reviewCount': 14,
      'image': 'assets/appliances/product4/1.png',
    },
    'Dishwasher': {
      'page': AppliancesProduct5(),
      'rating': 4.0,
      'reviewCount': 11,
      'image': 'assets/appliances/product5/1.png',
    },
    'Coffee Maker': {
      'page': AppliancesProduct7(),
      'rating': 3.1,
      'reviewCount': 1288,
      'image': 'assets/appliances/product7/1.png',
    },
    'Toaster': {
      'page': AppliancesProduct8(),
      'rating': 4.6,
      'reviewCount': 884,
      'image': 'assets/appliances/product8/1.png',
    },
    'Iron': {
      'page': AppliancesProduct9(),
      'rating': 4.8,
      'reviewCount': 1193,
      'image': 'assets/appliances/product9/1.png',
    },
    'fan': {
      'page': AppliancesProduct11(),
      'rating': 4.4,
      'reviewCount': 674,
      'image': 'assets/appliances/product11/1.png',
    },
    'Kettle': {
      'page': AppliancesProduct14(),
      'rating': 4.5,
      'reviewCount': 1162,
      'image': 'assets/appliances/product14/1.png',
    },
  };

  // Helper function to find the correct detail page for a product
  static Widget? findDetailPage(String productTitle) {
    // Find the first matching key phrase
    for (var key in productData.keys) {
      if (productTitle.toLowerCase().contains(key.toLowerCase())) {
        return productData[key]!['page'] as Widget;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Appliances'),
      body: FutureBuilder<List<ProductCard>>(
        future: ApiService().loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Trigger a rebuild to retry loading
                      (context as Element).markNeedsBuild();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No appliances available at the moment.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          final products = snapshot.data!;

          return RefreshIndicator(
            onRefresh: () async {
              // Trigger a rebuild to refresh the data
              (context as Element).markNeedsBuild();
            },
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final productPage = findDetailPage(product.name);

                if (productPage == null) {
                  return const SizedBox.shrink();
                }

                // Get the static data for this product
                String? key;
                for (var k in productData.keys) {
                  if (product.name.toLowerCase().contains(k.toLowerCase())) {
                    key = k;
                    break;
                  }
                }

                if (key == null) return const SizedBox.shrink();

                final staticData = productData[key]!;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ProductCard(
                    id: product.id,
                    name: product.name,
                    imagePaths: [staticData['image'] as String],
                    price: product.price,
                    originalPrice: product.originalPrice,
                    rating: staticData['rating'] as double,
                    reviewCount: staticData['reviewCount'] as int,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => productPage,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
