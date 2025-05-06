import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/custom_app.dart';
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

                return ProductCard(
                  id: product.id,
                  name: product.name,
                  imagePaths: product.imagePaths,
                  price: product.price,
                  originalPrice: product.originalPrice,
                  rating: product.rating,
                  reviewCount: product.reviewCount,
                  onTap: () {
                    if (product.id == '68132a95ff7813b3d47f9da5') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppliancesProduct1()),
                      );
                    } else if (product.id == '68132a95ff7813b3d47f9da6') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppliancesProduct2()),
                      );
                    } else if (product.id == '68132a95ff7813b3d47f9da7') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppliancesProduct3()),
                      );
                    } else if (product.id == '68132a95ff7813b3d47f9da8') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppliancesProduct4()),
                      );
                    } else if (product.id == '68132a95ff7813b3d47f9da9') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppliancesProduct5()),
                      );
                    } else if (product.id == '68132a95ff7813b3d47f9daa') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppliancesProduct6()),
                      );
                    } else if (product.id == '68132a95ff7813b3d47f9dab') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppliancesProduct7()),
                      );
                    } else if (product.id == '68132a95ff7813b3d47f9dac') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppliancesProduct8()),
                      );
                    } else if (product.id == '68132a95ff7813b3d47f9dad') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppliancesProduct9()),
                      );
                    } else if (product.id == '68132a95ff7813b3d47f9dae') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppliancesProduct10()),
                      );
                    } else if (product.id == '68132a95ff7813b3d47f9daf') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppliancesProduct11()),
                      );
                    } else if (product.id == '68132a95ff7813b3d47f9db0') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppliancesProduct12()),
                      );
                    } else if (product.id == '68132a95ff7813b3d47f9db1') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppliancesProduct13()),
                      );
                    } else if (product.id == '68132a95ff7813b3d47f9db2') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppliancesProduct14()),
                      );
                    } else if (product.id == '68132a95ff7813b3d47f9db3') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppliancesProduct15()),
                      );
                    }
                    // Add more else if for every product id
                  },
                );
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
