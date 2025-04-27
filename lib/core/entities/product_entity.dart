import 'dart:io';

import 'package:pickpay/core/entities/review_entity.dart';

class ProductEntity {
  final String name;
  final String code;
  final String description;
  final num price;
  final bool isFeatured;
  String? imageUrl;
  final num avgRating = 0;
  final num ratingCount = 0;
  final List<ReviewEntity> reviews;

  ProductEntity({
    required this.name,
    required this.code,
    required this.description,
    required this.price,
    required this.isFeatured,
    this.imageUrl,
    required this.reviews,
  });

  // Add copyWith method to ProductEntity
  ProductEntity copyWith({
    String? name,
    String? code,
    String? description,
    num? price,
    File? image,
    bool? isFeatured,
    String? imageUrl,
    List<ReviewEntity>? reviews,
  }) {
    return ProductEntity(
      name: name ?? this.name,
      code: code ?? this.code,
      description: description ?? this.description,
      price: price ?? this.price,
      isFeatured: isFeatured ?? this.isFeatured,
      imageUrl: imageUrl ?? this.imageUrl,
      reviews: reviews ?? this.reviews,
    );
  }
}
