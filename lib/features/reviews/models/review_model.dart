export 'review_model.dart';

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
      createdAt: DateTime.parse(json['createdAt'] as String),
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
      'createdAt': createdAt.toIso8601String(),
      'productId': productId,
    };
  }
}
