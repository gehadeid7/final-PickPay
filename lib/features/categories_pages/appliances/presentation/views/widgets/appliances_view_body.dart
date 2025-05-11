import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product15.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product5.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product9.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';
import 'package:pickpay/services/api_service.dart'; // Import ApiService

class AppliancesViewBody extends StatelessWidget {
  const AppliancesViewBody({super.key});

  // Mapping of product IDs to corresponding product details (Widget, Rating, Review Count)
  final Map<String, Map<String, dynamic>> productData = const {
    '68132a95ff7813b3d47f9da5': {
      'widget': AppliancesProduct1(),
      'rating': 3.1,
      'reviewCount': 9,
    },
    '68132a95ff7813b3d47f9da6': {
      'widget': AppliancesProduct2(),
      'rating': 3.1,
      'reviewCount': 9,
    },
    '68132a95ff7813b3d47f9da7': {
      'widget': AppliancesProduct3(),
      'rating': 4.5,
      'reviewCount': 12,
    },
    '68132a95ff7813b3d47f9da8': {
      'widget': AppliancesProduct4(),
      'rating': 4.2,
      'reviewCount': 14,
    },
    '68132a95ff7813b3d47f9da9': {
      'widget': AppliancesProduct5(),
      'rating': 4.0,
      'reviewCount': 11,
    },
    '68132a95ff7813b3d47f9daa': {
      'widget': AppliancesProduct6(),
      'rating': 3.9,
      'reviewCount': 9,
    },
    '68132a95ff7813b3d47f9dab': {
      'widget': AppliancesProduct7(),
      'rating': 3.1,
      'reviewCount': 1288,
    },
    '68132a95ff7813b3d47f9dac': {
      'widget': AppliancesProduct8(),
      'rating': 4.6,
      'reviewCount': 884,
    },
    '68132a95ff7813b3d47f9dad': {
      'widget': AppliancesProduct9(),
      'rating': 4.8,
      'reviewCount': 1193,
    },
    '68132a95ff7813b3d47f9dae': {
      'widget': AppliancesProduct10(),
      'rating': 4.6,
      'reviewCount': 4576,
    },
    '68132a95ff7813b3d47f9daf': {
      'widget': AppliancesProduct11(),
      'rating': 4.4,
      'reviewCount': 674,
    },
    '68132a95ff7813b3d47f9db0': {
      'widget': AppliancesProduct12(),
      'rating': 4.5,
      'reviewCount': 12,
    },
    '68132a95ff7813b3d47f9db1': {
      'widget': AppliancesProduct13(),
      'rating': 4.9,
      'reviewCount': 1439,
    },
    '68132a95ff7813b3d47f9db2': {
      'widget': AppliancesProduct14(),
      'rating': 4.5,
      'reviewCount': 1162,
    },
    '68132a95ff7813b3d47f9db3': {
      'widget': AppliancesProduct15(),
      'rating': 4.6,
      'reviewCount': 1735,
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Appliances'),
      body: FutureBuilder<List<ProductCard>>(
        // Fetch products from the API
        future: ApiService().loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show loading spinner while waiting for data
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Show error message if there is an error
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // If data is available, display the list of products
            final products = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: products.length,
              itemBuilder: (context, index) {
                var product = products[index];

                // Get the product details dynamically
                var productDetails = productData[product.id];

                if (productDetails != null) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        bottom: 16), // Add space below each item
                    child: ProductCard(
                      id: product.id,
                      name: product.name,
                      imagePaths: product.imagePaths,
                      price: product.price,
                      originalPrice: product.originalPrice,
                      rating: productDetails['rating'], // Dynamic rating
                      reviewCount:
                          productDetails['reviewCount'], // Dynamic review count
                      onTap: () {
                        // Single line for navigation and dynamic product details
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => productDetails['widget']),
                        );
                      },
                    ),
                  );
                } else {
                  return SizedBox
                      .shrink(); // If no product data found, return an empty widget
                }
              },
            );
          } else {
            return Center(child: Text('No products available.'));
          }
        },
      ),
    );
  }
}
