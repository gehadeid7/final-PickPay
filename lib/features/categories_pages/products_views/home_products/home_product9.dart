import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class HomeProduct9 extends StatelessWidget {
  const HomeProduct9({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'home9',
      title:
          "Amotpo Indoor/Outdoor Wall Clock,12-Inch Waterproof Clock with Thermometer and Hygrometer Combo,Battery Operated Quality Quartz Round Clock,Silver",
      imagePaths: [
        'assets/Home_products/home-decor/home_decor4/1.png',
        'assets/Home_products/home-decor/home_decor4/2.png',
        'assets/Home_products/home-decor/home_decor4/3.png',
        'assets/Home_products/home-decor/home_decor4/4.png',
        'assets/Home_products/home-decor/home_decor4/5.png',
        'assets/Home_products/home-decor/home_decor4/6.png',
      ],
      price: 549.00,
      originalPrice: 600.00,
      rating: 4.2,
      reviewCount: 919,
      colorOptions: ['12" Silver'],
      colorAvailability: {'12" Silver': true},
      brand: 'Amotpo',
      displayType: 'Analog',
      dimensions: '30.5W x 30.5H centimeters',
      powerSource: 'Battery Powered',
      style: 'Modern',
      specialfeatures: 'Silent Clock - Waterproof - Temperature Display',
      itemShape: 'Round',
      roomType: 'Home Office',
      aboutThisItem:
          '''Analog Thermometer & Humidity Combo:Indoor/outdoor clock has built-in Analog hygrometer & thermometer combo. Automatically measures accurate temperature degree from -30℉ to 130℉(-30℃ to 50℃), humidity readings from 0% to 100% RH.

Waterproof Wall Clock:Double protection,Front rubber seal& Waterproof rear cover Which Keep the dial and movement of your wall clock away from rain.

Decorative Design: Retro frame with bright silver bezel, built-in Analog hygrometer & thermometer combo,ivory white dial face and large black numbers provide a good view,It is a very beautiful indoor and outdoor decorations.

Silent Non-ticking:quiet sweep and precise movements to guarantee accurate time and ultra-quiet environment.

Application: This ABS-framed wall clock measures 12 inches in diameter,1.7inches in Deep. Come with wide slot in back for easy hanging. It is perfect for office ,living room, classroom, bedroom, bathroom,Pool,Patio.''',
      deliveryDate: 'Sunday, 9 March',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
