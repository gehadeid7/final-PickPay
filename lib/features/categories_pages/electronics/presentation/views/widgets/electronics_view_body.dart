import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product1.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product2.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product3.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product4.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product5.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product6.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product7.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product8.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product9.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product10.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product11.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product12.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product13.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product14.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product15.dart';
import 'package:pickpay/services/api_service.dart';

class ElectronicsViewBody extends StatefulWidget {
  const ElectronicsViewBody({super.key});

  @override
  State<ElectronicsViewBody> createState() => _ElectronicsViewBodyState();
}

class _ElectronicsViewBodyState extends State<ElectronicsViewBody> {
  late Future<List<ProductsViewsModel>> _productsFuture;

  // Map of product detail pages
  static final Map<String, Widget> detailPages = {
    '6819e22b123a4faad16613be': const Product1View(), // Samsung Galaxy S21
    '6819e22b123a4faad16613bf': const Product2View(), // Sony Xperia 1 III
    '6819e22b123a4faad16613c0': const Product3View(), // LG V60 ThinQ
    '6819e22b123a4faad16613c1': const Product4View(), // Panasonic Toughbook
    '6819e22b123a4faad16613c3': const Product5View(), // iPhone 13 Pro Max
    '6819e22b123a4faad16613c4': const Product6View(), // Samsung QLED TV
    '6819e22b123a4faad16613c5': const Product7View(), // LG OLED TV
    '6819e22b123a4faad16613c6': const Product8View(), // Sony Bravia TV
    '6819e22b123a4faad16613c7': const Product9View(), // TCL Smart TV
    '6819e22b123a4faad16613c8': const Product10View(), // Hisense ULED TV
    '6819e22b123a4faad16613c9': const Product11View(), // MacBook Pro
    '6819e22b123a4faad16613ca': const Product12View(), // Dell XPS
    '6819e22b123a4faad16613cb': const Product13View(), // HP Spectre
    '6819e22b123a4faad16613cc': const Product14View(), // HP OfficeJet
    '6819e22b123a4faad16613cd': const Product15View(), // ASUS ROG
  };

  @override
  void initState() {
    super.initState();
    _productsFuture = _loadProducts();
  }

  Future<List<ProductsViewsModel>> _loadProducts() async {
    final apiProducts = await ApiService().loadProducts();

    // Filter for electronics products and map them to our model
    return apiProducts
        .map((apiProduct) {
          // Generate the correct image path based on product category and ID
          String imagePath;
          final productIndex =
              detailPages.keys.toList().indexOf(apiProduct.id) + 1;

          if (productIndex <= 5) {
            // Mobile and tablet products (1-5)
            imagePath =
                'assets/electronics_products/mobile_and_tablet/mobile_and_tablet$productIndex/1.png';
          } else if (productIndex <= 10) {
            // TV products (6-10)
            imagePath =
                'assets/electronics_products/tvscreens/tv${productIndex - 5}/1.png';
          } else {
            // Laptop products (11-15)
            imagePath =
                'assets/electronics_products/Laptop/Laptop${productIndex - 10}/1.png';
          }

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
              'No electronics available at the moment.',
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return BaseCategoryView(
          categoryName: 'Electronics',
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
