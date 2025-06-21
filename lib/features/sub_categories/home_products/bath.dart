import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product16.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product17.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product18.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product19.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product20.dart';
import 'package:pickpay/services/api_service.dart';

class BathView extends StatefulWidget {
  const BathView({super.key});

  @override
  State<BathView> createState() => _BathViewState();
}

class _BathViewState extends State<BathView> {
  late Future<List<ProductsViewsModel>> _productsFuture;

  // Map of product detail pages
  static final Map<String, Widget> detailPages = {
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

    // Define actual brands for Bath & Bedding products
    final Map<String, String> productBrands = {
      '681dab0df9c9147444b452dc': 'Bedsure', // HomeProduct16 - Bath
      '681dab0df9c9147444b452dd': 'Home of Linen', // HomeProduct17 - Bath
      '681dab0df9c9147444b452de': 'Banotex', // HomeProduct18 - Bath
      '681dab0df9c9147444b452df': 'Generic', // HomeProduct19 - Bath
      '681dab0df9c9147444b452e0': 'Generic', // HomeProduct20 - Bath
    };

    return apiProducts
        .where((product) => detailPages.containsKey(product.id))
        .map((apiProduct) {
      final imagePath =
          'assets/Home_products/bath_and_bedding/bath${detailPages.keys.toList().indexOf(apiProduct.id) + 1}/1.png';

      return ProductsViewsModel(
        id: apiProduct.id,
        title: apiProduct.name,
        price: apiProduct.price,
        originalPrice: apiProduct.originalPrice,
        rating: apiProduct.rating ?? 4.5,
        reviewCount: apiProduct.reviewCount ?? 100,
        brand: productBrands[apiProduct.id] ?? 'Generic', // Use actual brand
        imagePaths: [imagePath],
        soldBy: 'PickPay',
        isPickPayFulfilled: true,
        hasFreeDelivery: true,
      );
    }).toList();
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
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final products = snapshot.data ?? [];

        return BaseCategoryView(
          categoryName: 'Bath & Bedding',
          products: products,
          productDetailBuilder: (String productId) {
            final detailPage = _findDetailPageById(productId);
            if (detailPage != null) {
              return detailPage;
            }
            return const Scaffold(
              body: Center(child: Text('Product detail view coming soon')),
            );
          },
        );
      },
    );
  }
}
