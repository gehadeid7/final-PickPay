import 'package:flutter/material.dart';
import 'package:pickpay/core/entities/product_entity.dart';
import 'package:pickpay/features/home/presentation/views/card_item.dart';

class ElectronicsGridView extends StatelessWidget {
  const ElectronicsGridView({super.key, required this.products});

  final List<ProductEntity> products;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: products.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 180 / 230,
          mainAxisSpacing: 12,
          crossAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          return CardItem(
            productEntity : products[index],
          );
        });
  }
}
