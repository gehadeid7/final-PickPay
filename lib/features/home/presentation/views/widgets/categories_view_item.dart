import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';

class CategoriesViewItem extends StatelessWidget {
  final String categoryName;
  final String imagePath;

  const CategoriesViewItem({
    super.key,
    required this.categoryName,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6FE),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFFEDEDED),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Category Name
          Text(
            categoryName,
            textAlign: TextAlign.center,
            style: TextStyles.semiBold16.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
