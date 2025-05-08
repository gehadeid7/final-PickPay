import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class FashionProduct10 extends StatelessWidget {
  const FashionProduct10({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da10',
      title:
          "Timberland Men's Leather Trifold Wallet Hybrid, Brown/Black, One Size",
      imagePaths: [
        "assets/Fashion_products/Men_Fashion/men_fashion5/1.png",
        "assets/Fashion_products/Men_Fashion/men_fashion5/2.png",
        "assets/Fashion_products/Men_Fashion/men_fashion5/3.png"
      ],
      price: 1399,
      originalPrice: 1511,
      rating: 4.6,
      reviewCount: 1118,
      materialcomposition: '100% genuine leather',
      careInstruction: 'Dry Cloth Clean',
      closureType: 'Bifold',
      lining: 'Leather',
      aboutThisItem:
          '''GENUINE LEATHER WALLET - 100% Genuine Leather wallet made from a nice soft luxury leather that is smooth to the touch and will look terrific even as it ages with everyday use includes a bonus flip out ID pocket

FUNCTIONAL DESIGN WITH STORAGE - Features 8 card slots, 3 slip pockets, 1 cash bill pocket, 1 ID window plus an additional ID window with its unique horizontal flip pocket design which provides easy access to frequently used cards

BIFOLD TRIFOLD DESIGN – designed as a men's bifold wallet we included a side flip out pocket with two clear id windows so you can easily display your id or a commuter, transferring this wallet into a leather trifold wallet

SOPHISTICATED AND ELEGANT WITH 2 ID WINDOWS - This slim mens leather wallet has 2 ID windows and features beautiful bi-level contrast stitching design, an embossed circular Timberland logo in the front right-hand corner, and an embossed Timberland logo on the interior

TIMBERLAND QUALITY AND FUNCTION - We stand by our product and believe you will too. Our Timberland Men's fashionable leather trifold wallet is the best mens wallet for all occasions and combines durability and fashion''',
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
