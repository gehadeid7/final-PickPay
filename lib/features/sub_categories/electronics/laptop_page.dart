import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/services/api_service.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product11.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product12.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product13.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product14.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product15.dart';

class LaptopPage extends StatefulWidget {
  const LaptopPage({super.key});

  @override
  State<LaptopPage> createState() => _LaptopPageState();
}

class _LaptopPageState extends State<LaptopPage> {
  late Future<List<ProductsViewsModel>> _productsFuture;

  // Map of laptop product detail pages
  static final Map<String, Widget> detailPages = {
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

    // Define actual brands for Laptops products
    final Map<String, String> productBrands = {
      '6819e22b123a4faad16613c9': 'Lenovo', // Laptop1
      '6819e22b123a4faad16613ca': 'Lenovo', // Laptop2
      '6819e22b123a4faad16613cb': 'HP', // Laptop3
      '6819e22b123a4faad16613cc': 'HP', // Laptop4
      '6819e22b123a4faad16613cd': 'Generic', // Laptop5
    };

    return apiProducts
        .where((apiProduct) => detailPages.containsKey(apiProduct.id))
        .map((apiProduct) {
      final productIndex = detailPages.keys.toList().indexOf(apiProduct.id) + 1;
      final imagePath =
          'assets/electronics_products/Laptop/Laptop$productIndex/1.png';

      return ProductsViewsModel(
        id: apiProduct.id,
        title: apiProduct.name,
        price: apiProduct.price,
        originalPrice: apiProduct.originalPrice,
        rating: 4.5,
        reviewCount: 100,
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
          categoryName: 'Laptops',
          products: products,
          productDetailBuilder: (String productId) {
            final detailPage = _findDetailPageById(productId);
            return detailPage ??
                const Scaffold(
                  body: Center(child: Text('Product detail view coming soon')),
                );
          },
        );
      },
    );
  }
}
