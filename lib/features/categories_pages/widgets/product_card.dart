import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  // Constructor with parameters to receive product data
  const ProductCard({
    super.key,

    // These are the variables passed when creating a ProductCard
    required this.name, // Product name (e.g., "AirPods Pro")
    required this.imagePaths, // List of local asset image paths
    required this.price, // Discounted price (e.g., 199)
    required this.originalPrice, // Original price (e.g., 249)
    required this.rating, // Product rating out of 5 (e.g., 4.5)
    required this.reviewCount, // Number of reviews (e.g., 120)
  });

  // final ProductEntity productEntity;  <-- This comment is now restored!

  // Fields to hold the values received from the constructor
  final String name;
  final List<String> imagePaths; // <-- Now receives a list of asset image paths
  final double price;
  final double originalPrice;
  final double rating;
  final int reviewCount;

  @override
  Widget build(BuildContext context) {
    // Calculate number of full stars from rating
    int fullStars = rating.floor();

    // Check if there's a half star (e.g., 4.5 has a half star)
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
          // Stack: Image + Favorite Icon
          SizedBox(
            height: 180,
            child: Stack(
              children: [
                // Product Image Slider (using PageView)
                Center(
                  child: SizedBox(
                    height: 170, // Fixed height for image area
                    child: PageView.builder(
                      itemCount: imagePaths.length, // Number of images
                      itemBuilder: (context, index) {
                        return Image.asset(
                          imagePaths[index], // Show image at current index
                          fit: BoxFit.contain,
                        );
                      },
                    ),
                  ),
                ),

                // Favorite Icon (top right of image)
                Positioned(
                  top: 0,
                  right: -4,
                  child: IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {
                      // Add to wishlist logic
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Product Name
          Text(
            name, // Use the name passed from constructor
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),

          // Price and Original Price
          Row(
            children: [
              Text(
                '\$${price.toStringAsFixed(2)}', // Show dynamic price
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '\$${originalPrice.toStringAsFixed(2)}', // Show original price with strikethrough
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),

          // Rating & Reviews and Plus Button aligned horizontally
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Stars + Reviews
              Row(
                children: [
                  // Loop to display full stars
                  for (int i = 0; i < fullStars; i++)
                    const Icon(Icons.star, color: Colors.amber, size: 16),

                  // Show a half star if needed
                  if (hasHalfStar)
                    const Icon(Icons.star_half, color: Colors.amber, size: 16),

                  // Show remaining empty stars to make total 5
                  for (int i = 0;
                      i < (5 - fullStars - (hasHalfStar ? 1 : 0));
                      i++)
                    const Icon(Icons.star_border,
                        color: Colors.amber, size: 16),

                  const SizedBox(width: 4),

                  // Show number of reviews
                  Text(
                    '($reviewCount)',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),

              // Plus Button
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
