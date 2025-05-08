import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class Product4View extends StatelessWidget {
  const Product4View({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'electronics_product4',
      title:
          "CANSHN Magnetic iPhone 16 Pro Max Case, Clear, Magsafe Compatible",
      imagePaths: [
        'assets/electronics_products/mobile_and_tablet/mobile_and_tablet4/1.png',
      ],
      price: 141.25,
      originalPrice: 399.99,
      rating: 4.9,
      reviewCount: 3120,
      brand: "Sony",
      color: "Black",
      material: "Plastic, Memory Foam",
      dimensions: "18.4 x 7.4 x 23.9 cm",
      style: "Headphones",
      installationType: "N/A",
      accessLocation: "N/A",
      settingsCount: 1,
      powerSource: "Rechargeable Battery",
      manufacturer: "Sony",
      aboutThisItem:
          "Experience industry-leading noise cancellation and high-resolution audio with the Sony WH-1000XM5 wireless headphones, perfect for music lovers and frequent travelers.",
      deliveryDate: "Friday, May 8th",
      deliveryTimeLeft: "1 hour 15 minutes",
      deliveryLocation: "Cairo, Egypt",
      inStock: true,
      shipsFrom: "Egypt",
      soldBy: "Sony Official Store",
    );

    return ProductDetailView(product: product);
  }
}
