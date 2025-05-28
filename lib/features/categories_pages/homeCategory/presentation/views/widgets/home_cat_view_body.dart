import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product15.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product16.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product17.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product18.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product19.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product20.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product5.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product9.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/services/api_service.dart';

class HomeCategoryViewBody extends StatefulWidget {
  const HomeCategoryViewBody({super.key});

  @override
  State<HomeCategoryViewBody> createState() => _HomeCategoryViewBodyState();
}

class _HomeCategoryViewBodyState extends State<HomeCategoryViewBody> {
  late Future<List<ProductsViewsModel>> _productsFuture;

  // Map product ID to detail page
  static final Map<String, Widget> detailPages = {
    '681dab0df9c9147444b452cd': const HomeProduct1(),
    '681dab0df9c9147444b452ce': const HomeProduct2(),
    '681dab0df9c9147444b452cf': const HomeProduct3(),
    '681dab0df9c9147444b452d0': const HomeProduct4(),
    '681dab0df9c9147444b452d1': const HomeProduct5(),
    '681dab0df9c9147444b452d2': const HomeProduct6(),
    '681dab0df9c9147444b452d3': const HomeProduct7(),
    '681dab0df9c9147444b452d4': const HomeProduct8(),
    '681dab0df9c9147444b452d5': const HomeProduct9(),
    '681dab0df9c9147444b452d6': const HomeProduct10(),
    '681dab0df9c9147444b452d7': const HomeProduct11(),
    '681dab0df9c9147444b452d8': const HomeProduct12(),
    '681dab0df9c9147444b452d9': const HomeProduct13(),
    '681dab0df9c9147444b452da': const HomeProduct14(),
    '681dab0df9c9147444b452db': const HomeProduct15(),
    '681dab0df9c9147444b452dc': const HomeProduct16(),
    '681dab0df9c9147444b452dd': const HomeProduct17(),
    '681dab0df9c9147444b452de': const HomeProduct18(),
    '681dab0df9c9147444b452df': const HomeProduct19(),
    '681dab0df9c9147444b452e0': const HomeProduct20(),
  };

  @override
  void initState() {
    super.initState();
    _productsFuture = _loadProducts();
  }

  Future<List<ProductsViewsModel>> _loadProducts() async {
    final apiProducts = await ApiService().loadProducts();

    return apiProducts
        .map((apiProduct) {
          final productIndex = detailPages.keys.toList().indexOf(apiProduct.id) + 1;

          // Home category asset structure
          final imagePath = 'assets/home_products/home$productIndex/1.png';

          return ProductsViewsModel(
            id: apiProduct.id,
            title: apiProduct.name,
            price: apiProduct.price,
            originalPrice: apiProduct.originalPrice,
            rating: apiProduct.rating ?? 4.5,
            reviewCount: apiProduct.reviewCount ?? 100,
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
                  onPressed: () => setState(() => _productsFuture = _loadProducts()),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              'No home products available at the moment.',
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return BaseCategoryView(
          categoryName: 'Home',
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
