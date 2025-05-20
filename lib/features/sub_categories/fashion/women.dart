import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product5.dart';
import 'package:pickpay/features/categories_pages/widgets/brand_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/price_range_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';
import 'package:pickpay/features/categories_pages/widgets/rating_filter.dart';

class Women extends StatefulWidget {
  const Women({super.key});

  @override
  State<Women> createState() => _Women();
}

class _Women extends State<Women> {
  String? _selectedBrand;
  double _minRating = 0;
  RangeValues _priceRange = const RangeValues(0, 900); // Initial safe value

  final List<ProductsViewsModel> _allProducts = [
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da1',
      title: "Women's Chiffon Lining Batwing Sleeve Dress",
      price: 850.00,
      originalPrice: 970.00,
      rating: 5.0,
      reviewCount: 88,
      brand: 'Generic',
      imagePaths: [
        "assets/Fashion_products/Women_Fashion/women_fashion1/1.png"
      ],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da2',
      title: "adidas womens ULTIMASHOW Shoes",
      price: 1456.53,
      originalPrice: 2188.06,
      rating: 5.0,
      reviewCount: 88,
      brand: 'Adidas',
      imagePaths: [
        "assets/Fashion_products/Women_Fashion/women_fashion2/1.png"
      ],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da3',
      title: "American Eagle Womens Low-Rise Baggy Wide-Leg Jean",
      price: 2700.00,
      originalPrice: 0,
      rating: 5.0,
      reviewCount: 88,
      brand: 'American Eagle',
      imagePaths: [
        "assets/Fashion_products/Women_Fashion/women_fashion3/1.png"
      ],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da4',
      title: "Dejavu womens JAL-DJTF-058 Sandal",
      price: 1399.00,
      originalPrice: 0,
      rating: 5.0,
      reviewCount: 92,
      brand: 'Dejavu',
      imagePaths: [
        "assets/Fashion_products/Women_Fashion/women_fashion4/1.png"
      ],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da5',
      title: "Aldo Caraever Ladies Satchel Handbags, Khaki, Khaki",
      price: 799.00,
      originalPrice: 0,
      rating: 5.0,
      reviewCount: 88,
      brand: 'Aldo',
      imagePaths: [
        "assets/Fashion_products/Women_Fashion/women_fashion5/1.png"
      ],
    ),
  ];
  @override
  void initState() {
    super.initState();
    // Update price range after widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final maxPrice = _allProducts
          .map((product) => product.price)
          .reduce((a, b) => a > b ? a : b);
      setState(() {
        _priceRange = RangeValues(0, maxPrice);
      });
    });
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
      appBar: buildAppBar(context: context, title: "Women's fashion"),
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
                    onChanged: (range) {
                      setState(() {
                        _priceRange = range;
                      });
                    },
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
                      case '68132a95ff7813b3d47f9da1':
                        productDetailView = const FashionProduct1();
                        break;
                      case '68132a95ff7813b3d47f9da2':
                        productDetailView = const FashionProduct2();
                        break;
                      case '68132a95ff7813b3d47f9da3':
                        productDetailView = const FashionProduct3();
                        break;
                      case '68132a95ff7813b3d47f9da4':
                        productDetailView = const FashionProduct4();
                        break;
                      case '68132a95ff7813b3d47f9da5':
                        productDetailView = const FashionProduct5();
                        break;

                      default:
                        productDetailView = const FashionProduct1();
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
