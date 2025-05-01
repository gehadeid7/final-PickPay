import 'package:flutter/material.dart';

class ProductRating extends StatelessWidget {
  final double rating;
  final int reviewCount;

  const ProductRating({
    super.key,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.orange, size: 18),
        Text(rating.toString(), style: const TextStyle(fontSize: 14)),
        Text(" ($reviewCount reviews)",
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
