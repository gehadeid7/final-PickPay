import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  const CardItem({super.key, 
  // required this.productEntity
  });

//  final ProductEntity productEntity;
  @override
  Widget build(BuildContext context) {
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
          Expanded(
            child: Stack(
              children: [
                // Product Image
                Center(
                  child: Image.asset(
                    'assets/Categories/Electronics/iPhone.png',
                    height: 130,
                    fit: BoxFit.contain,
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
          const Text(
            'AirPods Pro 2nd Gen',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),

          // Price and Original Price
          const Row(
            children: [
              Text(
                '\$199',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(width: 10),
              Text(
                '\$249',
                style: TextStyle(
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
                  Icon(Icons.star, color: Colors.amber, size: 16),
                  Icon(Icons.star, color: Colors.amber, size: 16),
                  Icon(Icons.star, color: Colors.amber, size: 16),
                  Icon(Icons.star_half, color: Colors.amber, size: 16),
                  Icon(Icons.star_border, color: Colors.amber, size: 16),
                  SizedBox(width: 4),
                  Text(
                    '(120)',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),

              // Plus Button
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.black,
                child: IconButton(
                  icon: Icon(Icons.add, color: Colors.white, size: 16),
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

// // THARWAT CODE:

// import 'package:dartz/dartz.dart';
// import 'package:flutter/material.dart';
// import 'package:pickpay/core/utils/app_text_styles.dart';

// class CardItem extends StatelessWidget {
//   const CardItem({super.key});

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
