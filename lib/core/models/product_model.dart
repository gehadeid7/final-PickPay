import 'dart:io';

import 'package:pickpay/core/entities/product_entity.dart';
import 'package:pickpay/core/models/review_model.dart';


class ProductModel {
  final String name;
  final String code;
  final String description;
  final num price;
  final File image;
  final bool isFeatured;
  String? imageUrl;
  final num avgRating = 0;
  final num ratingCount = 0;
  final List<ReviewModel> reviews;

  ProductModel({
    required this.name,
    required this.code,
    required this.description,
    required this.price,
    required this.image,
    required this.isFeatured,
    this.imageUrl,
    required this.reviews,
  });

  factory ProductModel.fromEntity(
    ProductEntity addProductInputEntity,
  ) {
    return ProductModel(
      name: addProductInputEntity.name,
      code: addProductInputEntity.code,
      description: addProductInputEntity.description,
      price: addProductInputEntity.price,
      image: addProductInputEntity.image,
      isFeatured: addProductInputEntity.isFeatured,
      imageUrl: addProductInputEntity.imageUrl,
      reviews:
          addProductInputEntity.reviews
              .map((e) => ReviewModel.fromEntity(e))
              .toList(),
    );
  }

  toJson() {
    return {
      'name': name,
      'code': code,
      'description': description,
      'price': price,
      'isFeatured': isFeatured,
      'imageUrl': imageUrl,
      'reviews': reviews.map((e) => e.toJson()).toList(),
    };
  }
}
