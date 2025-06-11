import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class VideoGamesProduct12 extends StatelessWidget {
  const VideoGamesProduct12({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '682b00a46977bd89257c0e8b',
      title:
          'fanxiang S770 4TB NVMe M.2 SSD for PS5 - with Heatsink and DRAM, Up to 7300MB/s, PCIe 4.0, Suitable for Playstation 5 Memory Expansion, Game Enthusiasts, IT Professionals',
      imagePaths: [
        'assets/videogames_products/Accessories/accessories3/1.png',
        'assets/videogames_products/Accessories/accessories3/2.png',
        'assets/videogames_products/Accessories/accessories3/3.png',
        'assets/videogames_products/Accessories/accessories3/4.png',
      ],
      price: 26200.00,
      originalPrice: 26999.00,
      rating: 4.3,
      reviewCount: 230,
      category: 'Video Games',
      subcategory: 'Accessories',
      color: 'Black',
      compatibleDevices: 'Laptop, Gaming Console, Desktop',
      brand: 'fanxiang',
      digitalStorageCapacity: '4 TB',
      connectivityTechnology: 'M.2',
      installationType: 'Internal Hard Drive',
      hardDiskDescription: 'Solid State Drive, nvme',
      hardDiskFormFactor: '2280 Inches',
      specialfeatures: 'Heat, Stable',
      aboutThisItem:
          '''Exclusive Upgrade】: The NVMe 4TB SSD boasts speeds of up to 7300MB/s on Windows and 6300MB/s on PS5, ensuring efficient loading and seamless data transfer on both PC and PS5 platforms

【Storage Expansion】: M.2 SSD perfectly compatible with PS5, offers an impressive 4TB capacity with outstanding read and write speeds, providing impeccable storage and transfer for your gaming and entertainment files

【Cool and Quiet Operation】: The unique heatsink design ensures the SSD operates at low temperatures, maintaining excellent performance even during prolonged and intensive usage. The 4TB M.2 SSD provides reliable memory expansion for your PS5 game consoles

【Seamless Connectivity】: The S770 4TB Internal SSD not only delivers ultra-fast storage for your PS5 but also seamlessly connects to various platforms, including PC. It provides robust support for diverse applications in multiple scenarios

【Quality Assurance】: Purchasing the S770 NVMe SSD 4TB guarantees you a 5 year warranty, with a professional after-sales support team ready to assist, ensuring long-lasting shopping confidence and peace of mind''',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
