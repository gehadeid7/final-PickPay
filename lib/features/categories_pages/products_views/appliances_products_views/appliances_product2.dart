import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class AppliancesProduct2 extends StatelessWidget {
  const AppliancesProduct2({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "68252918a68b49cb06164205",
      title: 'Fresh Jumbo Stainless Steel Potato CB90"',
      imagePaths: [
        'assets/appliances/product2/1.png',
      ],
      price: 10525,
      originalPrice: 10968,
      rating: 3.1,
      reviewCount: 9,
      category: 'Appliances',
      subcategory: 'Large Appliances',
      drawertype: 'Storage',
      material: 'Stainless Steel',
      finishType: 'Polished',
      brand: 'Fresh',
      modelName: 'CB90',
      formFactor: 'Freestanding',
      controlsType: 'Knob',
      itemWeight: '110.23 Pounds',
      efficiency: 'Efficient',
      mountingType: 'Freestanding',
      aboutThisItem:
          '''Fresh gas cookers are known as the best selling cookers in Egypt. Enjoy buying Fresh Gas Cooker Jumbo Stainless CB 90*60 at a competitive price with high quality.

Fresh Gas Cooker Jumbo Stainless CB 90*60 has very unique features such as thermostat. It is also characterised with its distinguished full glass easy clean oven door and closed door grilling system.

full ignition at oven and grill burners.

Fresh Gas Cooker provide with one Knob for oven and grill burners with safety and Self Igition feature''',
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
