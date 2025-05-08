import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct6 extends StatelessWidget {
  const BeautyProduct6({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "",
      title: 'Care & More Soft Cream With Glycerin Mixed berries 75 ML',
      imagePaths: [
        'assets/beauty_products/skincare_1/1.png',
        'assets/beauty_products/skincare_1/2.png',
      ],
      price: 31.00,
      originalPrice: 44.00,
      rating: 4.3,
      reviewCount: 769,
      scentOption: [
        'Glycerin Mixed Berries',
        'Strawberry',
        'Vanilla & Cookies'
      ],
      itemvolume: '75 Milliliters',
      dimensions: '25.4 x 5.1 x 6.9 centimeters',
      brand: 'Care & More',
      ageRangeDescription: 'Adult',
      specialfeatures: 'Water Resistant',
      activeIngredients: 'Glycerin',
      skintype: 'All',
      numberofitems: '1',
      itemform: 'Cream',
      aboutThisItem: '''Brand: Care And More

Item Form: Cream

Skin type: All

Target gender: Unisex''',
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
