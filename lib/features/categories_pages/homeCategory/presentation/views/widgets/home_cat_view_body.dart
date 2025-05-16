import 'package:flutter/material.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
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
import 'package:pickpay/features/categories_pages/widgets/brand_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/price_range_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/rating_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';

class HomeCategoryViewBody extends StatefulWidget {
  const HomeCategoryViewBody({super.key});

  @override
  State<HomeCategoryViewBody> createState() => _HomeCategoryViewBodyState();
}

class _HomeCategoryViewBodyState extends State<HomeCategoryViewBody> {
  String? _selectedBrand;
  double _minRating = 0;
  RangeValues _priceRange = const RangeValues(0, 10000);

  final List<ProductsViewsModel> _allProducts = [
    ProductsViewsModel(
      id: 'home1',
      title: 'Golden Life Sofa Bed - Size 190 cm - Beige',
      price: 7850.00,
      originalPrice: 0,
      rating: 5.0,
      reviewCount: 88,
      brand: 'Golden Life',
      imagePaths: ['assets/Home_products/furniture/furniture1/1.png'],
    ),
    ProductsViewsModel(
      id: 'home2',
      title: 'Star Bags Bean Bag Chair - Purple, 95*95*97 cm, Unisex Adults',
      price: 1699.00,
      originalPrice: 2499.00,
      rating: 5.0,
      reviewCount: 88,
      brand: 'Star Bags',
      imagePaths: ['assets/Home_products/furniture/furniture2/1.png'],
    ),
    ProductsViewsModel(
      id: 'home3',
      title: 'Generic Coffee Table, Round, 71 cm x 45 cm, Black',
      price: 3600.00,
      originalPrice: 0,
      rating: 5.0,
      reviewCount: 88,
      brand: 'Generic',
      imagePaths: ['assets/Home_products/furniture/furniture3/1.png'],
    ),
    ProductsViewsModel(
      id: 'home4',
      title: 'Gaming Chair, Furgle Gocker Ergonomic Adjustable 3D Swivel Chair',
      price: 9696.55,
      originalPrice: 12071.00,
      rating: 5.0,
      reviewCount: 92,
      brand: 'Furgle',
      imagePaths: ['assets/Home_products/furniture/furniture4/1.png'],
    ),
    ProductsViewsModel(
      id: 'home5',
      title: 'Janssen Almany Innerspring Mattress Height 25 cm - 120 x 195 cm',
      price: 5060.03,
      originalPrice: 0,
      rating: 5.0,
      reviewCount: 88,
      brand: 'Janssen',
      imagePaths: ['assets/Home_products/furniture/furniture5/1.png'],
    ),
    ProductsViewsModel(
      id: 'home6',
      title: 'Golden Lighting LED Gold Lampshade + 1 Crystal Cylinder Bulb.',
      price: 1128.00,
      originalPrice: 0.0,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Golden Lighting',
      imagePaths: ['assets/Home_products/home-decor/home_decor1/1.png'],
    ),
    ProductsViewsModel(
      id: 'home7',
      title:
          'Luxury Bathroom Rug Shaggy Bath Mat 60x40 Cm, Washable Non Slip, Soft Chenille, Gray',
      price: 355.00,
      originalPrice: 0.0,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Luxury',
      imagePaths: ['assets/Home_products/home-decor/home_decor2/1.png'],
    ),
    ProductsViewsModel(
      id: 'home8',
      title: 'Glass Vase 15cm',
      price: 250.00,
      originalPrice: 0.0,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Generic',
      imagePaths: ['assets/Home_products/home-decor/home_decor3/1.png'],
    ),
    ProductsViewsModel(
      id: 'home9',
      title:
          'Amotpo Indoor/Outdoor Wall Clock, 12-Inch Waterproof with Thermometer & Hygrometer',
      price: 549.00,
      originalPrice: 0.0,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Amotpo',
      imagePaths: ['assets/Home_products/home-decor/home_decor4/1.png'],
    ),
    ProductsViewsModel(
      id: 'home10',
      title:
          'Oliruim Black Home Decor Accent Art Woman Face Statue - 2 Pieces Set',
      price: 650.00,
      originalPrice: 0.0,
      rating: 5.0,
      reviewCount: 19,
      brand: 'Oliruim',
      imagePaths: ['assets/Home_products/home-decor/home_decor5/1.png'],
    ),
    ProductsViewsModel(
      id: 'home11',
      title: 'Neoflam Pote Cookware Set 11-Pieces, Pink Marble',
      price: 15795.00,
      originalPrice: 18989.00,
      rating: 4.8,
      reviewCount: 19,
      brand: 'Neoflam',
      imagePaths: ['assets/Home_products/kitchen/kitchen1/1.png'],
    ),
    ProductsViewsModel(
      id: 'home12',
      title: 'Pasabahce Set of 6 Large Mug with Handle -340ml Turkey Made',
      price: 495.00,
      originalPrice: 590.99,
      rating: 4.9,
      reviewCount: 1439,
      brand: 'Pasabahce',
      imagePaths: ['assets/Home_products/kitchen/kitchen2/1.png'],
    ),
    ProductsViewsModel(
      id: 'home13',
      title:
          'P&P CHEF 13½ Inch Pizza Pan Set, 3 Pack Nonstick Pizza Pans, Round Pizza Tray Bakeware for Oven Baking',
      price: 276.00,
      originalPrice: 300.00,
      rating: 4.5,
      reviewCount: 1162,
      brand: 'P&P CHEF',
      imagePaths: ['assets/Home_products/kitchen/kitchen3/1.png'],
    ),
    ProductsViewsModel(
      id: 'home14',
      title:
          'LIANYU 20 Piece Silverware Flatware Cutlery Set, Stainless Steel Utensils Service for 4',
      price: 50099.00,
      originalPrice: 69990.00,
      rating: 4.6,
      reviewCount: 1735,
      brand: 'LIANYU',
      imagePaths: ['assets/Home_products/kitchen/kitchen4/1.png'],
    ),
    ProductsViewsModel(
      id: 'home15',
      title:
          'Dish Rack Dish Drying Stand Dish Drainer Plate Rack Dish rake Kitchen Organizer',
      price: 400.00,
      originalPrice: 550.99,
      rating: 4.6,
      reviewCount: 4576,
      brand: 'Generic',
      imagePaths: ['assets/Home_products/kitchen/kitchen5/1.png'],
    ),
    ProductsViewsModel(
      id: 'home16',
      title: 'Banotex Cotton Towel 50x100 (Sugar)',
      price: 170.00,
      originalPrice: 200.99,
      rating: 4.6,
      reviewCount: 4576,
      brand: 'Banotex',
      imagePaths: ['assets/Home_products/bath_and_bedding/bath1/1.png'],
    ),
    ProductsViewsModel(
      id: 'home17',
      title: 'Fiber pillow 2 pieces size 40x60',
      price: 180.00,
      originalPrice: 200.99,
      rating: 4.6,
      reviewCount: 4576,
      brand: 'Generic',
      imagePaths: ['assets/Home_products/bath_and_bedding/bath2/1.png'],
    ),
    ProductsViewsModel(
      id: 'home18',
      title:
          'Bedsure 100% Cotton Blankets Queen Size for Bed - Waffle Weave Blankets for Summer',
      price: 604.00,
      originalPrice: 700.99,
      rating: 4.6,
      reviewCount: 4576,
      brand: 'Bedsure',
      imagePaths: ['assets/Home_products/bath_and_bedding/bath3/1.png'],
    ),
    ProductsViewsModel(
      id: 'home19',
      title: 'Home of linen-fitted sheet set, size 120 * 200cm, offwhite',
      price: 369.00,
      originalPrice: 400.99,
      rating: 4.6,
      reviewCount: 4576,
      brand: 'Home of linen',
      imagePaths: ['assets/Home_products/bath_and_bedding/bath4/1.png'],
    ),
    ProductsViewsModel(
      id: 'home20',
      title:
          'Home of Linen - Duvet Cover Set - 3 Pieces for Double Bed - 1 Duvet Cover (185cm*235cm) + 2 Pillow Cases',
      price: 948.00,
      originalPrice: 1000.99,
      rating: 4.6,
      reviewCount: 4576,
      brand: 'Home of Linen',
      imagePaths: ['assets/Home_products/bath_and_bedding/bath5/1.png'],
    ),
  ];

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

    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Home'),
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
                    values: _priceRange,
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
                    // Navigate to the appropriate product detail view
                    // based on the product ID
                    final productId = product.id;
                    Widget productDetailView;

                    switch (productId) {
                      case 'home1':
                        productDetailView = const HomeProduct1();
                        break;
                      case 'home2':
                        productDetailView = const HomeProduct2();
                        break;
                      case 'home3':
                        productDetailView = const HomeProduct3();
                        break;
                      case 'home4':
                        productDetailView = const HomeProduct4();
                        break;
                      case 'home5':
                        productDetailView = const HomeProduct5();
                        break;
                      case 'home6':
                        productDetailView = const HomeProduct6();
                        break;
                      case 'home7':
                        productDetailView = const HomeProduct7();
                        break;
                      case 'home8':
                        productDetailView = const HomeProduct8();
                        break;
                      case 'home9':
                        productDetailView = const HomeProduct9();
                        break;
                      case 'home10':
                        productDetailView = const HomeProduct10();
                        break;
                      case 'home11':
                        productDetailView = const HomeProduct11();
                        break;
                      case 'home12':
                        productDetailView = const HomeProduct12();
                        break;
                      case 'home13':
                        productDetailView = const HomeProduct13();
                        break;
                      case 'home14':
                        productDetailView = const HomeProduct14();
                        break;
                      case 'home15':
                        productDetailView = const HomeProduct15();
                        break;
                      case 'home16':
                        productDetailView = const HomeProduct16();
                        break;
                      case 'home17':
                        productDetailView = const HomeProduct17();
                        break;
                      case 'home18':
                        productDetailView = const HomeProduct18();
                        break;
                      case 'home19':
                        productDetailView = const HomeProduct19();
                        break;
                      case 'home20':
                        productDetailView = const HomeProduct20();
                        break;
                      default:
                        productDetailView =
                            const HomeProduct1(); // Default fallback
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
          }).toList(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
