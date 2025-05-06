// import 'package:pickpay/core/entities/product_entity.dart';
// import 'package:pickpay/core/helper_functions/get_avg_rating.dart';
// import 'package:pickpay/core/models/review_model.dart';

// class ProductModel {
//   final String name;
//   final String code;
//   final String description;
//   final num price;
//   final bool isFeatured;
//   String? imageUrl;
//   final num avgRating;
//   final num ratingCount = 0;
//   final List<ReviewModel> reviews;
//   final num sellingCount;

//   ProductModel({
//     required this.name,
//     required this.code,
//     required this.description,
//     required this.price,
//     required this.avgRating,
//     required this.isFeatured,
//     this.imageUrl,
//     required this.reviews,
//     required this.sellingCount,
//   });

//   factory ProductModel.fromJson(Map<String, dynamic> json) {
//     return ProductModel(
//       name: json['name'],
//       code: json['code'],
//       description: json['description'],
//       price: json['price'],
//       avgRating: getAvgRating(json['reviews']),
//       isFeatured: json['isFeatured'],
//       imageUrl: json['imageUrl'],
//       reviews: json['reviews'] != null
//           ? List<ReviewModel>.from(
//               json[' reviews'].map((e) => ReviewModel.fromJson(e)))
//           : [],
//       sellingCount: json['sellingCount'],
//     );
//   }

//   // ProductEntity toEntity() {
//   //   return ProductEntity(
//   //     name: name,
//   //     code: code,
//   //     description: description,
//   //     price: price,
//   //     isFeatured: isFeatured,
//   //     reviews: reviews.map((e) => e.toEntity()).toList(),
//   //   );
//   // }

//   toJson() {
//     return {
//       'name': name,
//       'code': code,
//       'description': description,
//       'price': price,
//       'isFeatured': isFeatured,
//       'imageUrl': imageUrl,
//       'reviews': reviews.map((e) => e.toJson()).toList(),
//     };
//   }
// }

// // .........................................................
// // import 'package:pickpay/core/entities/product_entity.dart';

// // class ProductModel {
// //   final String name;
// //   final String code;
// //   final String description;
// //   final num price;
// //   final num originalPrice;
// //   final String imageUrl;
// //   final num rating;
// //   final int sellingCount;
// //   final List<Map<String, dynamic>> reviews; // this should match your real review format
// //   final bool isFeatured;

// //   ProductModel({
// //     required this.name,
// //     required this.code,
// //     required this.description,
// //     required this.price,
// //     required this.originalPrice,
// //     required this.imageUrl,
// //     required this.rating,
// //     required this.reviews,
// //     required this.sellingCount,
// //     required this.isFeatured,
// //   });

// //   factory ProductModel.fromJson(Map<String, dynamic> json) {
// //     return ProductModel(
// //       name: json['name'],
// //       code: json['code'],
// //       description: json['description'],
// //       price: json['price'],
// //       originalPrice: json['original_price'],
// //       imageUrl: json['image_url'],
// //       rating: json['rating'],
// //       reviews: List<Map<String, dynamic>>.from(json['reviews'] ?? []),
// //       sellingCount: json['selling_count'] ?? 0,
// //       isFeatured: json['is_featured'] ?? false,
// //     );
// //   }

// //   ProductEntity toEntity() {
// //     return ProductEntity(
// //       name: name,
// //       code: code,
// //       description: description,
// //       price: price,
// //       imageUrl: imageUrl,
// //       avgRating: rating,
// //       reviews: [], // You can map reviews to List<ReviewEntity> if needed
// //       isFeatured: isFeatured,
// //       sellingCount: sellingCount,
// //     );
// //   }
// // }
