import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product5.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product9.dart';
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
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product20.dart';

class BeautyViewBody extends StatelessWidget {
  BeautyViewBody({super.key});

  final List<ProductsViewsModel> _products = [
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

  Widget _buildProductDetail(String productId) {
    switch (productId) {
      case '68132a95ff7813b3d47f9da1':
        return const BeautyProduct1();
      case '68132a95ff7813b3d47f9da2':
        return const BeautyProduct2();
      case '68132a95ff7813b3d47f9da3':
        return const BeautyProduct3();
      case '68132a95ff7813b3d47f9da4':
        return const BeautyProduct4();
      case '68132a95ff7813b3d47f9da5':
        return const BeautyProduct5();
      case '68132a95ff7813b3d47f9da6':
        return const BeautyProduct6();
      case '68132a95ff7813b3d47f9da7':
        return const BeautyProduct7();
      case '68132a95ff7813b3d47f9da8':
        return const BeautyProduct8();
      case '68132a95ff7813b3d47f9da9':
        return const BeautyProduct9();
      case '68132a95ff7813b3d47f9da10':
        return const BeautyProduct10();
      case '68132a95ff7813b3d47f9da11':
        return const BeautyProduct11();
      case '68132a95ff7813b3d47f9da12':
        return const BeautyProduct12();
      case '68132a95ff7813b3d47f9da13':
        return const BeautyProduct13();
      case '68132a95ff7813b3d47f9da14':
        return const BeautyProduct14();
      case '68132a95ff7813b3d47f9da15':
        return const BeautyProduct15();
      case '68132a95ff7813b3d47f9da16':
        return const BeautyProduct16();
      case '68132a95ff7813b3d47f9da17':
        return const BeautyProduct17();
      case '68132a95ff7813b3d47f9da18':
        return const BeautyProduct18();
      case '68132a95ff7813b3d47f9da19':
        return const BeautyProduct19();
      case '68132a95ff7813b3d47f9da20':
        return const BeautyProduct20();
      default:
        return const BeautyProduct1();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseCategoryView(
      categoryName: 'Beauty & Fragrance',
      products: _products,
      productDetailBuilder: _buildProductDetail,
    );
  }
}
