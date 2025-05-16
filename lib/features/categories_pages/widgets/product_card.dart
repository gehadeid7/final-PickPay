import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.id,
    required this.name,
    required this.imagePaths,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.reviewCount,
    this.onTap,
  });

  final String id;
  final String name;
  final List<String> imagePaths;
  final double price;
  final double originalPrice;
  final double rating;
  final int reviewCount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey.shade900 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade200,
          ),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: theme.shadowColor.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 180,
              child: Stack(
                children: [
                  SizedBox(
                    height: 170,
                    width: double.infinity,
                    child: PageView.builder(
                      itemCount: imagePaths.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          imagePaths[index],
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.image_not_supported,
                            // ignore: deprecated_member_use
                            color: colorScheme.onSurface.withOpacity(0.3),
                            size: 40,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: isDarkMode
                    ? colorScheme.onSurface
                    : Colors.black, // Black text in light mode
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green, // Keeping green for price
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '\$${originalPrice.toStringAsFixed(2)}',
                  style: textTheme.bodyMedium?.copyWith(
                    color: isDarkMode
                        // ignore: deprecated_member_use
                        ? colorScheme.onSurface.withOpacity(0.6)
                        : Colors.grey[600],
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    for (int i = 0; i < fullStars; i++)
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                    if (hasHalfStar)
                      const Icon(Icons.star_half,
                          color: Colors.amber, size: 16),
                    for (int i = 0;
                        i < (5 - fullStars - (hasHalfStar ? 1 : 0));
                        i++)
                      const Icon(Icons.star_border,
                          color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '($reviewCount)',
                      style: textTheme.bodySmall?.copyWith(
                        color: isDarkMode
                            // ignore: deprecated_member_use
                            ? colorScheme.onSurface.withOpacity(0.6)
                            : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
