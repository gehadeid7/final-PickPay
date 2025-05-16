import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product15.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product16.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product17.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product18.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product19.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product20.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product5.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product9.dart';
import 'package:pickpay/features/categories_pages/widgets/brand_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';
import 'package:pickpay/features/categories_pages/widgets/price_range_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/rating_filter.dart';

class BeautyViewBody extends StatefulWidget {
  const BeautyViewBody({super.key});

  @override
  State<BeautyViewBody> createState() => _BeautyViewBodyState();
}

class _BeautyViewBodyState extends State<BeautyViewBody> {
  String? _selectedBrand;
  double _minRating = 0;
  RangeValues _priceRange =
      const RangeValues(0, 1500); // Initial safe value for beauty products

  final List<ProductsViewsModel> _allProducts = [
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da1',
      title:
          'L\'Oréal Paris Volume Million Lashes Panorama Mascara in Black, 9.9 ml',
      price: 401.00,
      originalPrice: 730.00,
      rating: 5.0,
      reviewCount: 88,
      brand: 'L\'Oréal Paris',
      imagePaths: ['assets/beauty_products/makeup_1/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da2',
      title:
          'L\'Oréal Paris Infaillible 24H Matte Cover Foundation 200 Sable Dore - Oil Control, High Coverage',
      price: 509.00,
      originalPrice: 575.00,
      rating: 5.0,
      reviewCount: 88,
      brand: 'L\'Oréal Paris',
      imagePaths: ['assets/beauty_products/makeup_2/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da3',
      title: 'Cybele Smooth N`Wear Powder Blush Corail 17 - 3.7gm',
      price: 227.20,
      originalPrice: 240.00,
      rating: 5.0,
      reviewCount: 88,
      brand: 'Cybele',
      imagePaths: ['assets/beauty_products/makeup_3/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da4',
      title:
          'Eva skin care cleansing & makeup remover facial wipes for normal/dry skin 20%',
      price: 63.00,
      originalPrice: 63.00,
      rating: 5.0,
      reviewCount: 92,
      brand: 'Eva',
      imagePaths: ['assets/beauty_products/makeup_4/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da5',
      title: 'Maybelline New York Lifter Lip Gloss, 005 Petal',
      price: 300.00,
      originalPrice: 310.00,
      rating: 5.0,
      reviewCount: 88,
      brand: 'Maybelline',
      imagePaths: ['assets/beauty_products/makeup_5/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da6',
      title: 'Care & More Soft Cream With Glycerin Mixed berries 75 ML',
      price: 31.00,
      originalPrice: 44.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Care & More',
      imagePaths: ['assets/beauty_products/skincare_1/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da7',
      title:
          'La Roche-Posay Anthelios XL Non-perfumed Dry Touch oil control gel cream SPF50+ 50ml',
      price: 1168.70,
      originalPrice: 1168.70,
      rating: 4.0,
      reviewCount: 19,
      brand: 'La Roche-Posay',
      imagePaths: ['assets/beauty_products/skincare_2/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da8',
      title:
          'Eva Aloe skin clinic anti-ageing collagen toner for firmed and refined skin - 200ml',
      price: 138.60,
      originalPrice: 210.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Eva',
      imagePaths: ['assets/beauty_products/skincare_3/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da9',
      title:
          'Eucerin DermoPurifyer Oil Control Skin Renewal Treatment Face Serum, 40ml',
      price: 658.93,
      originalPrice: 775.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Eucerin',
      imagePaths: ['assets/beauty_products/skincare_4/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da10',
      title: 'L\'Oréal Paris Hyaluron Expert Eye Serum - 20ml',
      price: 429.00,
      originalPrice: 0.00,
      rating: 4.8,
      reviewCount: 19,
      brand: 'L\'Oréal Paris',
      imagePaths: ['assets/beauty_products/skincare_5/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da11',
      title: 'L\'Oréal Paris Elvive Hyaluron Pure Shampoo 400ML',
      price: 142.20,
      originalPrice: 0.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'L\'Oréal Paris',
      imagePaths: ['assets/beauty_products/haircare_1/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da12',
      title: 'Raw African Booster Shea Set',
      price: 650.00,
      originalPrice: 0.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Raw African',
      imagePaths: ['assets/beauty_products/haircare_2/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da13',
      title:
          'Garnier Color Naturals Permanent Crème Hair Color - 8.1 Light Ash Blonde',
      price: 132.00,
      originalPrice: 0.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Garnier',
      imagePaths: ['assets/beauty_products/haircare_3/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da14',
      title:
          'L\'Oreal Professionnel Absolut Repair 10-In-1 Hair Serum Oil - 90ml',
      price: 965.00,
      originalPrice: 1214.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'L\'Oreal Professionnel',
      imagePaths: ['assets/beauty_products/haircare_4/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da15',
      title:
          'CORATED Heatless Curling Rod Headband Kit with Clips and Scrunchie',
      price: 94.96,
      originalPrice: 111.98,
      rating: 4.0,
      reviewCount: 19,
      brand: 'CORATED',
      imagePaths: ['assets/beauty_products/haircare_5/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da16',
      title: 'Avon Far Away for Women, Floral Eau de Parfum 50ml',
      price: 534.51,
      originalPrice: 0.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Avon',
      imagePaths: ['assets/beauty_products/fragrance_1/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da17',
      title:
          'Memwa Coco Memwa Long Lasting Perfume Fragrance Luxury Eau De Parfum EDP Perfume for Women',
      price: 624.04,
      originalPrice: 624.04,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Memwa',
      imagePaths: ['assets/beauty_products/fragrance_2/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da18',
      title:
          'Bath Body Gingham Gorgeous Fine Fragrance Mist, Size/Volume: 8 fl oz / 236 mL',
      price: 1350.00,
      originalPrice: 1350.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Bath Body',
      imagePaths: ['assets/beauty_products/fragrance_3/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da19',
      title:
          'NIVEA Antiperspirant Spray for Women, Pearl & Beauty Pearl Extracts, 150ml',
      price: 123.00,
      originalPrice: 123.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'NIVEA',
      imagePaths: ['assets/beauty_products/fragrance_4/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da20',
      title: 'Jacques Bogart One Man Show for Men, Eau de Toilette - 100ml',
      price: 840.00,
      originalPrice: 900.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Jacques Bogart',
      imagePaths: ['assets/beauty_products/fragrance_5/1.png'],
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
      appBar: buildAppBar(context: context, title: 'Beauty & Fragrance'),
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
                        productDetailView = const BeautyProduct1();
                        break;
                      case '68132a95ff7813b3d47f9da2':
                        productDetailView = const BeautyProduct2();
                        break;
                      case '68132a95ff7813b3d47f9da3':
                        productDetailView = const BeautyProduct3();
                        break;
                      case '68132a95ff7813b3d47f9da4':
                        productDetailView = const BeautyProduct4();
                        break;
                      case '68132a95ff7813b3d47f9da5':
                        productDetailView = const BeautyProduct5();
                        break;
                      case '68132a95ff7813b3d47f9da6':
                        productDetailView = const BeautyProduct6();
                        break;
                      case '68132a95ff7813b3d47f9da7':
                        productDetailView = const BeautyProduct7();
                        break;
                      case '68132a95ff7813b3d47f9da8':
                        productDetailView = const BeautyProduct8();
                        break;
                      case '68132a95ff7813b3d47f9da9':
                        productDetailView = const BeautyProduct9();
                        break;
                      case '68132a95ff7813b3d47f9da10':
                        productDetailView = const BeautyProduct10();
                        break;
                      case '68132a95ff7813b3d47f9da11':
                        productDetailView = const BeautyProduct11();
                        break;
                      case '68132a95ff7813b3d47f9da12':
                        productDetailView = const BeautyProduct12();
                        break;
                      case '68132a95ff7813b3d47f9da13':
                        productDetailView = const BeautyProduct13();
                        break;
                      case '68132a95ff7813b3d47f9da14':
                        productDetailView = const BeautyProduct14();
                        break;
                      case '68132a95ff7813b3d47f9da15':
                        productDetailView = const BeautyProduct15();
                        break;
                      case '68132a95ff7813b3d47f9da16':
                        productDetailView = const BeautyProduct16();
                        break;
                      case '68132a95ff7813b3d47f9da17':
                        productDetailView = const BeautyProduct17();
                        break;
                      case '68132a95ff7813b3d47f9da18':
                        productDetailView = const BeautyProduct18();
                        break;
                      case '68132a95ff7813b3d47f9da19':
                        productDetailView = const BeautyProduct19();
                        break;
                      case '68132a95ff7813b3d47f9da20':
                        productDetailView = const BeautyProduct20();
                        break;
                      default:
                        productDetailView =
                            const BeautyProduct1(); // Default fallback
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
