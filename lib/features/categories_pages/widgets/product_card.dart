import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.name,
    required this.imagePaths,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.reviewCount,
  });

  final String name;
  final List<String> imagePaths;
  final double price;
  final double originalPrice;
  final double rating;
  final int reviewCount;

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F5F7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stack with product image and favorite icon
          SizedBox(
            height: 180,
            child: Stack(
              children: [
                // Image carousel
                SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: PageView.builder(
                    itemCount: imagePaths.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        imagePaths[index],
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                ),

                // Favorite icon top right
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: IconButton(
                      icon: const Icon(Icons.favorite_border),
                      onPressed: () {
                        // Wishlist logic
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Product name
          Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),

          // Price row
          Row(
            children: [
              Text(
                '\$${price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '\$${originalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),

          // Rating and plus button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Full stars
                  for (int i = 0; i < fullStars; i++)
                    const Icon(Icons.star, color: Colors.amber, size: 16),

                  // Half star
                  if (hasHalfStar)
                    const Icon(Icons.star_half, color: Colors.amber, size: 16),

                  // Empty stars
                  for (int i = 0;
                      i < (5 - fullStars - (hasHalfStar ? 1 : 0));
                      i++)
                    const Icon(Icons.star_border,
                        color: Colors.amber, size: 16),

                  const SizedBox(width: 4),

                  // Review count
                  Text(
                    '($reviewCount)',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),

              // Plus button
              CircleAvatar(
                radius: 17,
                backgroundColor: Colors.black,
                child: IconButton(
                  icon: const Icon(Icons.add, color: Colors.white, size: 23),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    // Add to cart logic
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
