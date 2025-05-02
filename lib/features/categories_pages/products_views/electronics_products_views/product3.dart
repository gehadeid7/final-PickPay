import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class Product3View extends StatelessWidget {
  const Product3View({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      title: "Samsung 55-Inch QLED 4K Smart TV",
      imagePaths: ['assets/Categories/Electronics/samsung_galaxys23ultra.png'],
      price: 699.99,
      category: 'Electronics',
      originalPrice: 899.99,
      rating: 4.7,
      reviewCount: 1542,
      brand: "Samsung",
      color: "Black",
      material: "Metal, Glass",
      dimensions: "1230.4 x 710.4 x 59.5 mm",
      style: "TV",
      installationType: "Wall Mount, Stand Mount",
      accessLocation: "Front",
      settingsCount: 1,
      powerSource: "Corded Electric",
      manufacturer: "Samsung",
      description:
          "55-inch QLED Smart TV with 4K resolution, HDR support, and Tizen OS.",
      deliveryDate: "Monday, May 5th",
      deliveryTimeLeft: "2 hours 30 minutes",
      deliveryLocation: "Cairo, Egypt",
      inStock: true,
      shipsFrom: "Egypt",
      soldBy: "Samsung Official Store",
    );

    return ProductDetailView(product: product);
  }
}
