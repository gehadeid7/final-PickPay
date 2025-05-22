import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class HomeProduct4 extends StatelessWidget {
  const HomeProduct4({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'home4',
      title:
          "Furgle Gocker Gaming Chair - Ergonomic 3D Swivel, One-Piece Steel Frame, Adjustable Tilt Angle, PU Leather, Gas Lift",
      imagePaths: [
        'assets/Home_products/furniture/furniture4/1.png',
        'assets/Home_products/furniture/furniture4/2.png',
        'assets/Home_products/furniture/furniture4/3.png',
        'assets/Home_products/furniture/furniture4/4.png',
        'assets/Home_products/furniture/furniture4/5.png',
      ],
      price: 9696.00,
      originalPrice: 9988.00,
      rating: 3.1,
      reviewCount: 81228,
      category: 'home',
      subcategory: 'Furniture',
      colorOptions: ['Black'],
      colorAvailability: {'Black': true},
      itemWeight: '21 Kilograms',
      brand: 'Furgle',
      size: '86D x 57W x 31H cm',
      backStyle: 'Solid Back',
      frameMaterial: 'Alloy Steel',
      specialfeatures: 'Adjustable',
      productCareInstructions: 'Wipe Clean',
      seatMaterial: 'Faux Leather',
      material: 'Leather',
      aboutThisItem:
          '''Original design for professional gamers: Inspired by the sports seat, it creates a sense of space to focus on the game. Designed for all-day gaming or working, ergonomically designed for games. In addition, the PU leather offers you the feeling of texture as well as the best sitting experience. And combined with futuristic design and excellent function, suitable for any spike style.

Striving for quality detail: sturdy one-piece metal frame. Class 3 explosion-proof gas spring, the best class for stability and safety, the adjustable length meets your different requirements for chair height. Furgle strives for the best comfort without compromising the details. The chair consists of a steel frame support, it can easily carry loads of more than 150 kg, no worry.

【Backrest Adjustment】Unparalleled comfort with a softer seat for a cashier feel and a firmer seat back for solid support. The angle of the backrest can be freely adjusted between 90° and 160°, it is also adjustable with rocker function 15° - 20°. You can adjust to the best support based on your posture changes between work and leisure. The best choice for office and lunch breaks.

Designed for all-day gaming: Whether you are playing a video game in your room or working in the office, the new gaming chair comes in different variants from racing to vintage style, making it suitable for all areas. Based on ergonomic design, provides quite comfortable support for the head, shoulders and waist to achieve the best sitting experience. Lumbar cushion provides you with the most comfortable support for your spine, free yourself from back pain.

Our gaming chair is the ideal seat for working, learning and playing. It will make your room more modern and elegant and make you more comfortable. Detailed instruction manual included (English language not guaranteed). 24/7 customer service team everything for shopping experience. One month replacement service and 2 year quality warranty on parts as a promise. If you have any questions, just contact us!''',
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
