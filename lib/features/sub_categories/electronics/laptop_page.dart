import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product1.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product11.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product12.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product13.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product15.dart';
import 'package:pickpay/features/categories_pages/widgets/brand_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/price_range_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/rating_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';

class LaptopPage extends StatefulWidget {
  const LaptopPage({super.key});

  @override
  State<LaptopPage> createState() => _LaptopPage();
}

class _LaptopPage extends State<LaptopPage> {
  String? _selectedBrand;
  double _minRating = 0;
  late RangeValues _priceRange; // Changed to late initialization

  final List<ProductsViewsModel> _allProducts = [
    ProductsViewsModel(
      id: 'elec11',
      title: 'LENOVO ideapad slim3 15IRH8 -I5-13420H 8G-512SSD 83EM007LPS GREY',
      price: 24313.00,
      originalPrice: 0,
      rating: 4,
      reviewCount: 19,
      brand: 'Lenovo',
      imagePaths: ['assets/electronics_products/Laptop/Laptop1/1.png'],
    ),
    ProductsViewsModel(
      id: 'elec12',
      title:
          'Lenovo Legion 5 15ACH6 Gaming Laptop - Ryzen 5-5600H, 16 GB RAM, 512 GB SSD, NVIDIA GeForce RTX 3050 Ti 4GB GDDR6 Graphics, 15.6" FHD (1920x1080) IPS 120Hz, Backlit Keyboard, WIN 11',
      price: 36999.00,
      originalPrice: 0,
      rating: 4,
      reviewCount: 19,
      brand: 'Lenovo',
      imagePaths: ['assets/electronics_products/Laptop/Laptop2/1.png'],
    ),
    ProductsViewsModel(
      id: 'elec13',
      title:
          'HP Victus Gaming Laptop (15-fb1004ne), CPU: Ryzen 5-7535HS, 16GB DDR5 2DM 4800, NVIDIA RTX 2050, 15.6" FHD 144Hz, 512GB, Windows 11',
      price: 30999.00,
      originalPrice: 0,
      rating: 4,
      reviewCount: 19,
      brand: 'HP',
      imagePaths: ['assets/electronics_products/Laptop/Laptop3/1.png'],
    ),
    ProductsViewsModel(
      id: 'elec15',
      title: 'USB Cooling Pad Stand Fan Cooler for Laptop Notebook',
      price: 355.00,
      originalPrice: 0,
      rating: 4,
      reviewCount: 19,
      brand: 'Generic',
      imagePaths: ['assets/electronics_products/Laptop/Laptop5/1.png'],
    ),
  ];
  @override
  void initState() {
    super.initState();
    // Initialize price range after products are available
    final maxPrice = _allProducts
        .map((product) => product.price)
        .reduce((a, b) => a > b ? a : b);
    _priceRange = RangeValues(0, maxPrice);
  }

  List<ProductsViewsModel> get _filteredProducts {
    return _allProducts.where((product) {
      final brandMatch = _selectedBrand == null ||
          _selectedBrand!.isEmpty ||
          _selectedBrand == 'All Brands' ||
          product.brand == _selectedBrand;

      final ratingMatch =
          product.rating != null && product.rating! >= _minRating;

      final priceMatch = product.price >= _priceRange.start &&
          product.price <= _priceRange.end;

      return brandMatch && ratingMatch && priceMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final maxPrice = _allProducts
        .map((product) => product.price)
        .reduce((a, b) => a > b ? a : b);

    // Ensure current range values are within bounds
    final currentValues = RangeValues(
      _priceRange.start.clamp(0, maxPrice),
      _priceRange.end.clamp(0, maxPrice),
    );

    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Laptop'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          // Filters section
          Card(
            elevation: 2,
            child: BrandFilterWidget(
              products: _allProducts,
              selectedBrand: _selectedBrand,
              onBrandChanged: (newBrand) {
                setState(() {
                  _selectedBrand = newBrand;
                });
              },
            ),
          ),
          // Price and Rating filters in a row
          Row(
            children: [
              // Price Filter (left side)
              Expanded(
                child: Card(
                  elevation: 2,
                  child: PriceRangeFilterWidget(
                    values: currentValues,
                    maxPrice: maxPrice,
                    onChanged: (range) => setState(() => _priceRange = range),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Rating Filter (right side)
              Expanded(
                child: Card(
                  elevation: 2,
                  child: RatingFilterWidget(
                    value: _minRating,
                    onChanged: (rating) => setState(() => _minRating = rating),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Products list
          ..._filteredProducts.map((product) {
            return Column(
              children: [
                ProductCard(
                  id: product.id,
                  name: product.title,
                  imagePaths: product.imagePaths ?? [],
                  price: product.price,
                  originalPrice: product.originalPrice ?? 0,
                  rating: product.rating ?? 0,
                  reviewCount: product.reviewCount ?? 0,
                  onTap: () {
                    final productId = product.id;
                    Widget productDetailView;

                    switch (productId) {
                      case 'elec11':
                        productDetailView = const Product11View();
                        break;
                      case 'elec12':
                        productDetailView = const Product12View();
                        break;
                      case 'elec13':
                        productDetailView = const Product13View();
                        break;

                      case 'elec15':
                        productDetailView = const Product15View();
                        break;
                      default:
                        productDetailView = const Product1View();
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => productDetailView),
                    );
                  },
                ),
                const SizedBox(height: 10),
              ],
            );
            // ignore: unnecessary_to_list_in_spreads
          }).toList(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
