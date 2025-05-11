import 'package:flutter/material.dart';

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
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? theme.cardColor : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode
              ? Colors.grey[800]!
              : const Color.fromARGB(67, 158, 158, 158),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: theme.shadowColor.withOpacity(isDarkMode ? 0.2 : 0.1),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            productName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "\$$price",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.green,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.star, color: Colors.orange[400], size: 14),
              const SizedBox(width: 4),
              Text(
                '$rating',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(width: 4),
              Text(
                '($reviewCount reviews)',
                style: theme.textTheme.bodySmall?.copyWith(
                  // ignore: deprecated_member_use
                  color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
