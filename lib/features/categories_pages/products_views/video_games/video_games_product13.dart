import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class VideoGamesProduct13 extends StatelessWidget {
  const VideoGamesProduct13({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '682b00a46977bd89257c0e8c',
      title:
          'Mcbazel PS5 Cooling Station and Charging Station, 3 Speed Fan, Controller Dock with LED Indicator and 11 Storage Discs - White(Not for PS5 Pro)',
      imagePaths: [
        'assets/videogames_products/Accessories/accessories4/1.png',
        'assets/videogames_products/Accessories/accessories4/2.png',
        'assets/videogames_products/Accessories/accessories4/3.png',
        'assets/videogames_products/Accessories/accessories4/4.png',
      ],
      price: 1999.00,
      originalPrice: 2100.00,
      rating: 3.9,
      reviewCount: 38,
      category: 'Video Games',
      subcategory: 'Accessories',
      amperage: '3 Amps',
      brand: 'Mcbazel',
      connectivityTechnology: 'USB',
      compatibleDevices: 'PlayStation 5 and PlayStation 5 Slim Consoles',
      connectorType: 'USB',
      includedComponents:
          '1 x Universal Multifunctional Charging Dock, 1 x Type C Power Cable, 1 x Fixing Screw, 1 x User Manual',
      inputVoltage: '5 Volts',
      mountingType: 'No assembly',
      specialfeatures:
          'Dual fan cooling system, Dual controller simultaneous charging, Large storage capacity',
      aboutThisItem:
          '''UNIVERSAL DESIGN FOR PS5 SERIES - The charging dock is expertly crafted to complement both the PS5 and PS5 Slim. This stylish white accessory is not only a visual match, but also offers a perfect fit for your console, ensuring stability and security. Not for ps5 pro

Advanced Cooling System: Equipped with two high-efficiency cooling fans, the dock is essential to maintain the optimum console temperature. With three adjustable settings High, Middle, Low meets different cooling needs, ensuring that the PS5/PS5 Slim runs smoothly during extended gaming sessions.

Dual controller charging with indicator lights: The dock can charge two Dualsense controllers simultaneously, a feature underlined by the visual signals of red (charging) and blue (full/standby). The fast charging capacity (about 3 hours) is ideal for avid gamers, ensuring minimal downtime.

SPACIOUS AND ORGANIZED STORAGE SPACE - This multifunctional dock is also a storage shelter, capable of holding up to 11 boxes of game discs and a remote control. The inclusion of fixing screws further improves organization, keeping the game console well organized and accessible.

PROTECTIVE AND PRACTICAL DESIGN - The station layout is designed to protect and organize your PS5/PS5 Slim and accessories. Prevents clutter and potential damage, making it a practical addition to your game setup. The combination of functionality, protection and style makes this dock a valuable investment for PS5 enthusiasts.''',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
