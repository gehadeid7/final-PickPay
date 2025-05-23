import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class Product11View extends StatelessWidget {
  const Product11View({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '6819e22b123a4faad16613c9',
      title: 'LENOVO ideapad slim3 15IRH8 -I5-13420H 8G-512SSD 83EM007LPS GREY',
      imagePaths: [
        'assets/electronics_products/Laptop/Laptop1/1.png',
        'assets/electronics_products/Laptop/Laptop1/2.png',
        'assets/electronics_products/Laptop/Laptop1/3.png',
      ],
      price: 22999.00,
      originalPrice: 23823.00,
      rating: 5.0,
      reviewCount: 2,
      screenSize: '15.6 Inches',
      color: 'grey',
      brand: 'Lenovo',
      category: 'Electronics',
      subcategory: 'Laptop',
      graphicsDescription: 'Integrated',
      operatingSystem: 'Windows 11',
      ramMemoryInstalled: '8 GB',
      specialfeatures: 'Fingerprint Reader',
      cpuModel: 'Core i5',
      hardDiskSize: '512 GB',
      aboutThisItem:
          '''{Processor} Intel Core i5-13420H, 8C (4P + 4E) / 12T, P-core 2.1 / 4.6GHz, E-core 1.5 / 3.4GHz, 12MB

{Memory} 8GB Soldered LP DDR5-4800

{Storage} 512GB SSD M.2 2242 PCIe 4.0x4 NVMe

{Display} 15.6" FHD (1920x1080) IPS 300nits Anti-glare

Ethernet No Onboard Ethernet WLAN + Bluetooth Wi-Fi 6, 802.11ax 2x2 + BT5.2 Standard Ports 2x USB 3.2 Gen 1 1x USB-C 3.2 Gen 1 (support data transfer, Power Delivery and DisplayPort 1.2) 1x HDMI 1.4''',
      modelName: 'IdeaCentre AIO 3',
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
