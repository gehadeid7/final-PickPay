import 'package:flutter/material.dart';
import 'dart:developer' as dev;
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
import 'package:flutter/foundation.dart';

class AppliancesViewBody extends StatelessWidget {
  const AppliancesViewBody({super.key});

  // Helper function to find the correct detail page for a product
  static Widget? findDetailPage(String productTitle) {
    // Map of key phrases to detail pages
    final Map<String, Widget> titleToPage = {
      'TORNADO': AppliancesProduct12(),
      'Vacuum Cleaner': AppliancesProduct10(),
      'Dough Mixer': AppliancesProduct15(),
      'Blender': AppliancesProduct13(),
      'Refrigerator': AppliancesProduct3(),
      'Air Fryer': AppliancesProduct6(),
      'Water Dispenser': AppliancesProduct1(),
      'Stainless Steel Potato': AppliancesProduct2(),
      'Washing Machine': AppliancesProduct4(),
      'Dishwasher': AppliancesProduct5(),
      'Coffee Maker': AppliancesProduct7(),
      'Toaster': AppliancesProduct8(),
      'Iron': AppliancesProduct9(),
      'fan': AppliancesProduct11(),
      'Kettle': AppliancesProduct14(),
    };

    // Find the first matching key phrase
    for (var key in titleToPage.keys) {
      if (productTitle.toLowerCase().contains(key.toLowerCase())) {
        return titleToPage[key];
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

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ProductCard(
                    id: product.id,
                    name: product.name,
                    imagePaths: product.imagePaths,
                    price: product.price,
                    originalPrice: product.originalPrice,
                    rating: product.rating,
                    reviewCount: product.reviewCount,
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
