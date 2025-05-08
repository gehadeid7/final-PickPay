import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class Product5View extends StatelessWidget {
  const Product5View({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'elec5',
      title:
          "Oraimo 18W USB Type-C Dual Output Super Fast Charger Wall Adapter QC3.0& PD3.0 & PE2.0 Compatible for iPhone 15/15 Plus/15 Pro/15 Pro Max, 14/13/12 Series, Galaxy, Pixel 4/3, iPad and More",
      imagePaths: [
        'assets/electronics_products/mobile_and_tablet/mobile_and_tablet5/1.png',
        'assets/electronics_products/mobile_and_tablet/mobile_and_tablet5/2.png',
        'assets/electronics_products/mobile_and_tablet/mobile_and_tablet5/3.png',
        'assets/electronics_products/mobile_and_tablet/mobile_and_tablet5/4.png',
        'assets/electronics_products/mobile_and_tablet/mobile_and_tablet5/5.png',
      ],
      price: 199.00,
      originalPrice: 220.00,
      rating: 4.7,
      reviewCount: 380,
      colorOptions: ['white'],
      colorAvailability: {'White': true},
      connectivityTechnology: 'USB',
      brand: 'Oraimo',
      compatibleDevices:
          'Smartphones - Headphones - Game Consoles - Tablets - Smartwatches',
      compatiblePhoneModels:
          'Compatible with iPhone 15/15 Plus/15 Pro/15 Pro Max, 14/13/12 Series and later models / iPad Mini 5 and later models Pixel 3XL / 3 / 2 / Galaxy S20 / S10 / S9 / S8 / S7, Moto ,Note 8 / 7 / LG and More.',
      includedComponents: 'Wall Adapter',
      inputVoltage: '120 Volts',
      mountingType: 'Wall Mount',
      specialfeatures: 'Short Circuit Protection, Fast Charging',
      aboutThisItem:
          '''🥇【Dual Port 18W Super Fast Charger】Equipped with USB-C (PD Power Delivery) and USB-A (Quick Charger), Fast charge two devices simultaneously.it can provide a maximum of 18W output power to charge your device,this lastest PD3.0 Type-C Fast Charger can make you enjoy 90Mins usage time only charge 15Mins.

🥇【3X Faster than Normal Charger】3 times faster than the original 5W charger, and this oraimo 18W PD 3.0 Type C Adapter Charger only takes 30 minutes to charge for iPhone up to 55%, saving you more than 1.5 hours.Engineered for excellence, the advanced AniFast technology now offers a remarkable 5% increase in charging speed and an astounding 30% increase in compatibility.

🥇【Muti-protection Safe and Reliable】With the intelligent chip inside, The Power Delivery Wall Charger owns bulit-in multi-protection system，it matches the current as your device's need automatically. Over-current, over-voltage and short-circuit protection also effectively protect your smartphones from damage

🥇【Widely Compatibility】This dual port wall charger support for iPhone and Android Fast Charge, QuickCharge protocols like PD3.0, QC3.0,PE2.0, etc.it's compatible with iPhone 15/15 Plus/15 Pro/15 Pro Max, 14/13/12 Series and later models / iPad Mini 5 and later models Pixel 3XL / 3 / 2 /Galaxy S20 / S10 / S9 / S8 / S7, Moto ,Note 8 / 7 / LG and More.

🥇【Smart Temperature ManagementSmart Control, Safe Charging】oraimo Cannon 18D actively monitors and regulates temperature, ensuring your devices charge at optimal conditions while preventing overheating. Enjoy safer and more efficient charging.''',
      deliveryDate: "Wednesday, May 10th",
      deliveryTimeLeft: "2 hours 30 minutes",
      deliveryLocation: "Cairo, Egypt",
      inStock: true,
      shipsFrom: "PickPay",
      soldBy: "PickPay",
    );

    return ProductDetailView(product: product);
  }
}
