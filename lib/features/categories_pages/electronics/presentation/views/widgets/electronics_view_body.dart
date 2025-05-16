import 'package:flutter/material.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product1.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product10.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product11.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product12.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product13.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product14.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product15.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product2.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product3.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product4.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product5.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product6.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product7.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product8.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product9.dart';
import 'package:pickpay/features/categories_pages/widgets/brand_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';

class ElectronicsViewBody extends StatefulWidget {
  const ElectronicsViewBody({super.key});

  @override
  State<ElectronicsViewBody> createState() => _ElectronicsViewBodyState();
}

class _ElectronicsViewBodyState extends State<ElectronicsViewBody> {
  String? _selectedBrand;
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
    ProductsViewsModel(
      id: 'elec6',
      title:
          'Samsung 55 Inch QLED Smart TV Neural HDR Quantum Processor Lite 4K - QA55QE1DAUXEG [2024 Model]',
      price: 18499.00,
      originalPrice: 0,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Samsung',
      imagePaths: ['assets/electronics_products/tvscreens/tv1/1.png'],
    ),
    ProductsViewsModel(
      id: 'elec7',
      title:
          'Xiaomi TV A 43 2025, 43", FHD, HDR, Smart Google TV with Dolby Atmos',
      price: 9999.00,
      originalPrice: 0,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Xiaomi',
      imagePaths: ['assets/electronics_products/tvscreens/tv2/1.png'],
    ),
    ProductsViewsModel(
      id: 'elec8',
      title:
          'Samsung 50 Inch TV Crystal Processor 4K LED - Titan Gray - UA50DU8000UXEG [2024 Model]',
      price: 16299.00,
      originalPrice: 20999.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Samsung',
      imagePaths: ['assets/electronics_products/tvscreens/tv3/1.png'],
    ),
    ProductsViewsModel(
      id: 'elec9',
      title:
          'SHARP 4K Smart Frameless TV 55 Inch Built-In Receiver 4T-C55FL6EX',
      price: 16999.00,
      originalPrice: 23499.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'SHARP',
      imagePaths: ['assets/electronics_products/tvscreens/tv4/1.png'],
    ),
    ProductsViewsModel(
      id: 'elec10',
      title:
          'LG UHD 4K TV 60 Inch UQ7900 Series, Cinema Screen Design WebOS Smart AI ThinQ',
      price: 18849.00,
      originalPrice: 23999.00,
      rating: 4.5,
      reviewCount: 19,
      brand: 'LG',
      imagePaths: ['assets/electronics_products/tvscreens/tv5/1.png'],
    ),
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
      id: 'elec14',
      title:
          'HP OfficeJet Pro 9720 Wide Format All-in-One Printer - Print, Scan, Copy, Wireless, ADF, Duplex, Touchscreen - [53N94C]',
      price: 7199.00,
      originalPrice: 0,
      rating: 4,
      reviewCount: 19,
      brand: 'HP',
      imagePaths: ['assets/electronics_products/Laptop/Laptop4/1.png'],
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

  List<ProductsViewsModel> get _filteredProducts {
    if (_selectedBrand == null ||
        _selectedBrand!.isEmpty ||
        _selectedBrand == 'All Brands') {
      return _allProducts;
    }
    return _allProducts
        .where((product) => product.brand == _selectedBrand)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Electronics'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          SizedBox(height: kTopPadding),
          BrandFilterWidget(
            products: _allProducts,
            selectedBrand: _selectedBrand,
            onBrandChanged: (newBrand) {
              setState(() {
                _selectedBrand = newBrand;
              });
            },
          ),
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
                      case 'elec6':
                        productDetailView = const Product6View();
                        break;
                      case 'elec7':
                        productDetailView = const Product7View();
                        break;
                      case 'elec8':
                        productDetailView = const Product8View();
                        break;
                      case 'elec9':
                        productDetailView = const Product9View();
                        break;
                      case 'elec10':
                        productDetailView = const Product10View();
                        break;
                      case 'elec11':
                        productDetailView = const Product11View();
                        break;
                      case 'elec12':
                        productDetailView = const Product12View();
                        break;
                      case 'elec13':
                        productDetailView = const Product13View();
                        break;
                      case 'elec14':
                        productDetailView = const Product14View();
                        break;
                      case 'elec15':
                        productDetailView = const Product15View();
                        break;
                      default:
                        productDetailView =
                            const Product1View(); // Default fallback
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
