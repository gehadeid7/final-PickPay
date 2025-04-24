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
  final num sellingCount;

  ProductModel({
    required this.name,
    required this.code,
    required this.description,
    required this.price,
    required this.image,
    required this.isFeatured,
    this.imageUrl,
    required this.reviews,
    required this.sellingCount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'],
      code: json['code'],
      description: json['description'],
      price: json['price'],
      image: File(json['image']),
      isFeatured: json['isFeatured'],
      imageUrl: json['imageUrl'],
      reviews: json['reviews'] != null
          ? List<ReviewModel>.from(
              json[' reviews'].map((e) => ReviewModel.fromJson(e))) 
          : [],
      sellingCount: json['sellingCount'], 
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
