import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class Product2View extends StatelessWidget {
  const Product2View({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'elec2',
      title:
          'Xiaomi Redmi Pad SE WiFi 11" FHD+ 90HZ refresh rate, Snapdragon 680 CPU, 8GB Ram+256GB ROM, Quad Speakers with Dolby Atmos, 8000mAh Bluetooth 5.3 8MP + Graphite Gray |1 year manufacturer warranty',
      imagePaths: [
        'assets/electronics_products/mobile_and_tablet/mobile_and_tablet2/1.png',
      ],
      price: 9888.00,
      originalPrice: 10000.00,
      rating: 4.7,
      reviewCount: 2019,
      colorOptions: ['Graphite Gray'],
      colorAvailability: {'Graphite Gray': true},
      size: '8GB RAM | 256GB ROM',
      brand: 'Xiaomi',
      style: 'Pad SE',
      modelName: 'Xiaomi Redmi Pad SE',
      memoryStorageCapacity: '256 GB',
      screenSize: '11 Inches',
      displayResolutionMaximum: '1900x1200',
      operatingSystem: 'Android 13.3',
      ramMemoryInstalled: '8 GB',
      generation: '4th Generation',
      modelYear: '2023',
      aboutThisItem:
          '''WIFI Version, NO SIM CARD. GLOBAL VERSION GLOBAL ROM FCC ID: 2AFZZRPBFL

Display 26.94cm(11") 1 Billion Colours 1900 x 1200 px FHD Refresh Rate: 90Hz 400 nits(typ) . Micro SD port Slot

Octa Core 4x2.4 GHz Kryo 265 Gold + 4x1.9GHz Kryo 265 Silver Qualcomm Snapdragon 680 (SM6225). Jack 3.5mm port

Camera Rear Camera: 8MP Full HD Video Recording Front Camera: 8MP (FOV - 105°) Speaker Quad Speakers Dolby Atmos supported

The device will boot MIUI 14 based on Android 13. Lastly, it will be backed by an 8,000mAh battery with support for 22.5W charging.''',
      deliveryDate: 'Monday, 10 March',
      deliveryTimeLeft: '18hrs 22 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
