import 'package:flutter/material.dart';

class HomeItem extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final double price;
  final double originalPrice;
  final double rating;
  final int reviews;

  const HomeItem({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F5F7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 👇 Stack: Image + Favorite Icon
          Stack(
            children: [
              // Product Image
              Center(
                child: Image.asset(
                  imageUrl,
                  height: 130,
                  fit: BoxFit.contain,
                ),
              ),
              // Favorite Icon (top right of image)
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {
                    // Add to wishlist logic
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Product Name
          Text(
            productName,
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
                '\$$price',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '\$$originalPrice',
                style: const TextStyle(
                  fontSize: 12,
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
                  for (int i = 0; i < 5; i++)
                    Icon(
                      i < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 16,
                    ),
                  const SizedBox(width: 4),
                  Text(
                    '($reviews)',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),

              // Plus Button
              CircleAvatar(
                radius: 19,
                backgroundColor: Colors.black,
                child: IconButton(
                  icon: const Icon(Icons.add, color: Colors.white, size: 16),
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

//THARWAT CODE:

// import 'package:dartz/dartz.dart';
// import 'package:flutter/material.dart';
// import 'package:pickpay/core/utils/app_text_styles.dart';

// class HomeItem extends StatelessWidget {
//   const HomeItem({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 180,
//       height: 260,
//       decoration: ShapeDecoration(
//         color: Color(0xFFF3F5F7),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
//       ),
//       child: Stack(
//         children: [
//           Positioned(
//             top: 0,
//             right: 0,
//             child: IconButton(
//               onPressed: () {},
//               icon: Icon(Icons.favorite_outline),
//             ),
//           ),
//           Positioned.fill(
//             child: Column(
//               children: [
//                 SizedBox(height: 15),
//                 Image.asset('assets/elecCat/AirPodsPro.png'),
//                 ListTile(
//                   title: Text(
//                     'AirPods Pro 2nd generation',
//                     textAlign: TextAlign.left,
//                     style: TextStyles.regular16.copyWith(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
