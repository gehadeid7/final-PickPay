import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/features/categories_pages/widgets/product_rating.dart';

class CardItem extends StatelessWidget {
  final String imagePath;
  final String productName;
  final String price;
  final double rating;
  final int reviewCount;

  const CardItem({
    super.key,
    required this.imagePath,
    required this.productName,
    required this.price,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 260,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F5F7),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Center(
            child: Image.asset(
              imagePath,
              height: 120, // Adjusted image height for better spacing
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 10),

          // Product Name
          Text(
            productName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.semiBold13.copyWith(
              color: Colors.black87,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 6),

          // Product Rating
          ProductRating(
            rating: rating,
            reviewCount: reviewCount,
          ),

          const SizedBox(height: 10), // Added space between rating and price

          // Price
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                '\$$price',
                style: TextStyles.bold13.copyWith(
                  fontSize: 16,
                  color: Colors.green[700],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
