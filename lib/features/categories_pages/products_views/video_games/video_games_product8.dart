import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class VideoGamesProduct8 extends StatelessWidget {
  const VideoGamesProduct8({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'vid8',
      title: 'PlayStation 5 DualSense Edge Wireless Controller (UAE Version)',
      imagePaths: [
        'assets/videogames_products/Controllers/controller4/1.png',
        'assets/videogames_products/Controllers/controller4/2.png',
        'assets/videogames_products/Controllers/controller4/3.png',
      ],
      price: 16500.00,
      originalPrice: 17000.00,
      rating: 4.3,
      reviewCount: 330,
      aboutThisItem:
          '''DualSense wireless controller features built in: Experience all the immersive features of the DualSense wireless controller, including haptic feedback, adaptive triggers, a built-in microphone, motion controls and more in supported titles. 

Signature comfort and slip-resistant inner grips: Enjoy the same signature comfort of the original DualSense wireless controller, now enhanced with slip-resistant inner grips. Ideal for long sessions in single player games and staying comfortable during intense competitive play.

Compatible with the DualSense charging station: Keep two controllers fully charged - including your DualSense Edge wireless controller - with the quick and easy click-in design of the DualSense charging station, available to buy now.

Keep everything together with the carrying case: Keep your DualSense Edge wireless controller and its components together and organized in one spot with an included carrying case. You can even charge the controller via USB connection while it's stored in the case to make sure you're always ready for your next play session.

Everything Included: DualSense Edge wireless controller, USB braided cable, 2 Standard Caps, 2 High Dome Caps, 2 Low Dome Caps, 2 Half Dome Back Buttons, 2 Lever Back Buttons, Connector Housing & Carrying Case.''',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
