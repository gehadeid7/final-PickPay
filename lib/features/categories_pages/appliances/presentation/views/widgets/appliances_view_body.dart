import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
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
import 'package:pickpay/services/api_service.dart';

class AppliancesViewBody extends StatefulWidget {
  const AppliancesViewBody({super.key});

  @override
  State<AppliancesViewBody> createState() => _AppliancesViewBodyState();
}

class _AppliancesViewBodyState extends State<AppliancesViewBody> {
  late Future<List<ProductsViewsModel>> _productsFuture;

  // Map of product detail pages
  static final Map<String, Widget> detailPages = {
    '68252918a68b49cb06164204':
        const AppliancesProduct1(), // Koldair Water Dispenser
    '68252918a68b49cb06164205':
        const AppliancesProduct2(), // Fresh Jumbo Stainless Steel
    '68252918a68b49cb06164206':
        const AppliancesProduct3(), // Midea Refrigerator
    '68252918a68b49cb06164207':
        const AppliancesProduct4(), // Zanussi Washing Machine
    '68252918a68b49cb06164208': const AppliancesProduct5(), // Midea Dishwasher
    '68252918a68b49cb06164209': const AppliancesProduct6(), // deime Air Fryer
    '68252918a68b49cb0616420a':
        const AppliancesProduct7(), // Black & Decker Coffee Maker
    '68252918a68b49cb0616420b':
        const AppliancesProduct8(), // Black & Decker Toaster
    '68252918a68b49cb0616420c': const AppliancesProduct9(), // Panasonic Iron
    '68252918a68b49cb0616420d':
        const AppliancesProduct10(), // Fresh Vacuum Cleaner
    '68252918a68b49cb0616420e': const AppliancesProduct11(), // Fresh Wall Fan
    '68252918a68b49cb0616420f':
        const AppliancesProduct12(), // Tornado Water Heater
    '68252918a68b49cb06164210':
        const AppliancesProduct13(), // Black & Decker Blender
    '68252918a68b49cb06164211':
        const AppliancesProduct14(), // Black & Decker Kettle
    '68252918a68b49cb06164212':
        const AppliancesProduct15(), // Black & Decker Dough Mixer
  };

  @override
  void initState() {
    super.initState();
    _productsFuture = _loadProducts();
  }

  Future<List<ProductsViewsModel>> _loadProducts() async {
    final apiProducts = await ApiService().loadProducts();

    // Filter for appliance products and map them to our model
    return apiProducts
        .map((apiProduct) {
          // Generate a default image path based on product ID
          final imagePath =
              'assets/appliances/product${detailPages.keys.toList().indexOf(apiProduct.id) + 1}/1.png';

          return ProductsViewsModel(
            id: apiProduct.id,
            title: apiProduct.name,
            price: apiProduct.price,
            originalPrice: apiProduct.originalPrice,
            rating:
                4.5, // Default rating - could be fetched from a reviews service
            reviewCount:
                100, // Default review count - could be fetched from a reviews service
            imagePaths: [imagePath],
          );
        })
        .where((product) => detailPages.containsKey(product.id))
        .toList();
  }

  Widget? _findDetailPageById(String productId) {
    return detailPages[productId];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductsViewsModel>>(
      future: _productsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 60),
                const SizedBox(height: 16),
                Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () =>
                      setState(() => _productsFuture = _loadProducts()),
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

        return BaseCategoryView(
          categoryName: 'Appliances',
          products: snapshot.data!,
          productDetailBuilder: (productId) {
            final detailPage = _findDetailPageById(productId);
            if (detailPage != null) {
              return detailPage;
            }
            return Scaffold(
              appBar: AppBar(title: const Text('Product Not Found')),
              body: const Center(child: Text('Product details not available')),
            );
          },
        );
      },
    );
  }
}
