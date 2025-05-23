import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class AppliancesProduct11 extends StatelessWidget {
  const AppliancesProduct11({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "68252918a68b49cb0616420e",
      title:
          'Fresh fan 50 watts 18 inches with charger with 3 blades, black and white',
      imagePaths: [
        'assets/appliances/product11/1.png',
      ],
      price: 3983,
      originalPrice: 4200,
      rating: 4.4,
      reviewCount: 674,
      brand: 'Fresh',
      category: 'Appliances',
      subcategory: 'Large Appliances',
      electricFanDesign: 'Floor Fan',
      powerSource: 'Battery Powered',
      dimensions: '51D x 51W x 153H',
      roomtype: 'Bedroom,Living Room,Home Office',
      specialfeatures: 'Rechargeable',
      recommendedUsesForProduct: 'Cooling',
      mountingType: 'Floor Mount',
      controllertype: 'Pull Chain Control',
      aboutThisItem: 'Fan Rechargeable',
      deliveryDate: 'Sunday, 9 March',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay Warehouse',
      soldBy: 'Pickpay Official',
    );

    return ProductDetailView(product: product);
  }
}
