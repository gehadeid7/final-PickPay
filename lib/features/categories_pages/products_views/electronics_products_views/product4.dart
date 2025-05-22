import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class Product4View extends StatelessWidget {
  const Product4View({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '6819e22b123a4faad16613c1',
      title:
          "CANSHN Magnetic for iPhone 16 Pro Max Case Clear, Upgraded [Full Camera Protection] [Compatible with Magsafe] Non-Yellowing Protective Shockproof Bumper - Clear",
      imagePaths: [
        'assets/electronics_products/mobile_and_tablet/mobile_and_tablet4/1.png',
        'assets/electronics_products/mobile_and_tablet/mobile_and_tablet4/2.png',
      ],
      price: 110.00,
      originalPrice: 399.99,
      rating: 4.7,
      reviewCount: 237,
      category: 'Electronics',
      subcategory: 'Mobile & Tablets',
      colorOptions: ['Clear'],
      colorAvailability: {'Clear': true},
      size: 'iPhone 16 Pro Max (6.9 Inch,3 Lens)',
      brand: 'CANSHN',
      compatiblePhoneModels: 'iPhone 16 Pro Max',
      compatibleDevices: 'For Phone Pro Max Case',
      material: 'Thermoplastic Polyurethane',
      pattern: 'Solid',
      embellishmentFeature: 'No Embellishment',
      theme: 'Floral',
      specialfeatures:
          'Heavy Duty Protection, Magnetic, Shock-Absorbent, Wireless Charging Compatible',
      aboutThisItem:
          '''Powerful Magnetic Attraction: compatible with MagSafe and Qi wireless chargers. It securely connects to magnetic accessories like wallets, power banks, and car mounts for a stable connection during rotation or movement

Upgraded Full Coverage Camera Protection: full coverage protection for the camera, with a 2.5 mm raised border around the lens. It provides comprehensive protection for the lens without affecting photography

Crystal Clear & Anti-Yellow: made with TPU and PC material, showcasing your phone's original beauty. The Nano Antioxidant coating resists 99.9% of yellowing from UV rays and sweat

Excellent Anti-drop Capability: made of thick shockproof TPU material for enhanced drop resistance. Each corner has shock-absorbing airbags for extra protection

Perfect Compatibility & Reliable Service: specifically designed for iPhone 16 ProMax 6.9 inch. Formed flawlessly to fit every curve, button, and cut out''',
      deliveryDate: "Friday, May 8th",
      deliveryTimeLeft: "1 hour 15 minutes",
      deliveryLocation: "Cairo, Egypt",
      inStock: true,
      shipsFrom: "PickPay",
      soldBy: "PickPay",
    );

    return ProductDetailView(product: product);
  }
}
