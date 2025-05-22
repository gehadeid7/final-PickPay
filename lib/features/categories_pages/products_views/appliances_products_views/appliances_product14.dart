import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class AppliancesProduct14 extends StatelessWidget {
  const AppliancesProduct14({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "68252918a68b49cb06164211",
      title:
          'Black & Decker 1.7L Concealed Coil Stainless Steel Kettle, Jc450-B5, Silver',
      imagePaths: [
        'assets/appliances/product14/1.png',
        'assets/appliances/product14/2.png',
        'assets/appliances/product14/3.png',
        'assets/appliances/product14/4.png',
        'assets/appliances/product14/5.png',
        'assets/appliances/product14/6.png',
      ],
      price: 1594,
      originalPrice: 1730,
      rating: 4.5,
      reviewCount: 1162,
      brand: 'Black & Decker',
      category: 'Appliances',
      subcategory: 'Small Appliances',
      color: 'Silver',
      specialfeatures: 'Programmable',
      containerType: 'Kettle',
      voltage: '240',
      finishType: 'Powder Coated',
      dimensions: '20.3L x 20.3W x 21.6H',
      wattage: '2000 watts',
      aboutThisItem:
          '''Model Number : JC450-B5Type : Electric KettleCapacity : 1.7

LiterMaterial : Stainless SteelColor : SilverBrand : Black & Decker

Voltage : 220-240VFrequency : 50-60 HzÂ 2 Years warranty 19311 Anasia Egypt''',
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
