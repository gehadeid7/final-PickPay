import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String id;
  final String userId;
  final String userImage;
  final String userName;
  final String content;
  final double rating;
  final DateTime createdAt;
  final String? productId;

  Review({
    required this.id,
    required this.userId,
    required this.userImage,
    required this.userName,
    required this.content,
    required this.rating,
    required this.createdAt,
    this.productId,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userImage: json['userImage'] as String,
      userName: json['userName'] as String,
      content: json['content'] as String,
      rating: (json['rating'] as num).toDouble(),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      productId: json['productId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userImage': userImage,
      'userName': userName,
      'content': content,
      'rating': rating,
      'createdAt': Timestamp.fromDate(createdAt),
      'productId': productId,
    };
  }

  Review copyWith({
    String? id,
    String? userId,
    String? userImage,
    String? userName,
    String? content,
    double? rating,
    DateTime? createdAt,
    String? productId,
  }) {
    return Review(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userImage: userImage ?? this.userImage,
      userName: userName ?? this.userName,
      content: content ?? this.content,
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
      productId: productId ?? this.productId,
    );
  }
}
