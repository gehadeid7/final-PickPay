import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product1.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product2.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product3.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product4.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product5.dart';
import 'package:pickpay/features/categories_pages/widgets/brand_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/price_range_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/rating_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';

class MobileAndTabletsPage extends StatefulWidget {
  const MobileAndTabletsPage({super.key});

  @override
  State<MobileAndTabletsPage> createState() => _MobileAndTabletsPage();
}

class _MobileAndTabletsPage extends State<MobileAndTabletsPage> {
  String? _selectedBrand;
  double _minRating = 0;
  late RangeValues _priceRange; // Changed to late initialization

  final List<ProductsViewsModel> _allProducts = [
    ProductsViewsModel(
      id: 'elec1',
      title:
          'Samsung Galaxy Tab A9 4G LTE, 8.7 Inch Android Tablet, 8GB RAM, 128GB Storage, 8MP Rear Camera, Navy-1 Year Warranty/Local Version',
      price: 9399.00,
      originalPrice: 9655.00,
      rating: 3.1,
      reviewCount: 9,
      brand: 'Samsung',
      imagePaths: [
        'assets/electronics_products/mobile_and_tablet/mobile_and_tablet1/1.png'
      ],
    ),
    ProductsViewsModel(
      id: 'elec2',
      title:
          'Xiaomi Redmi Pad SE WiFi 11" FHD+ 90HZ refresh rate, Snapdragon 680 CPU, 8GB Ram+256GB ROM, Quad Speakers with Dolby Atmos, 8000mAh Bluetooth 5.3 8MP + Graphite Gray |1 year manufacturer warranty',
      price: 9888.00,
      originalPrice: 10000.00,
      rating: 4.7,
      reviewCount: 2019,
      brand: 'Xiaomi',
      imagePaths: [
        'assets/electronics_products/mobile_and_tablet/mobile_and_tablet2/1.png'
      ],
    ),
    ProductsViewsModel(
      id: 'elec3',
      title: 'Apple iPhone 16 (128 GB) - Ultramarine',
      price: 57555.00,
      originalPrice: 0,
      rating: 5.0,
      reviewCount: 88,
      brand: 'Apple',
      imagePaths: [
        'assets/electronics_products/mobile_and_tablet/mobile_and_tablet3/1.png'
      ],
    ),
    ProductsViewsModel(
      id: 'elec4',
      title:
          'CANSHN Magnetic iPhone 16 Pro Max Case, Clear, Magsafe Compatible',
      price: 110.00,
      originalPrice: 129.00,
      rating: 4.7,
      reviewCount: 237,
      brand: 'CANSHN',
      imagePaths: [
        'assets/electronics_products/mobile_and_tablet/mobile_and_tablet4/1.png'
      ],
    ),
    ProductsViewsModel(
      id: 'elec5',
      title: 'Oraimo 18W USB-C Fast Charger, Dual Output, QC3.0 & PD3.0',
      price: 199.00,
      originalPrice: 220.00,
      rating: 4.7,
      reviewCount: 380,
      brand: 'Oraimo',
      imagePaths: [
        'assets/electronics_products/mobile_and_tablet/mobile_and_tablet5/1.png'
      ],
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
      appBar: buildAppBar(context: context, title: 'Mobile & Tablets'),
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
                      case 'elec1':
                        productDetailView = const Product1View();
                        break;
                      case 'elec2':
                        productDetailView = const Product2View();
                        break;
                      case 'elec3':
                        productDetailView = const Product3View();
                        break;
                      case 'elec4':
                        productDetailView = const Product4View();
                        break;
                      case 'elec5':
                        productDetailView = const Product5View();
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
