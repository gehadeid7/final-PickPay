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
    final createdAtData = json['createdAt'];
    DateTime createdAt;
    if (createdAtData is Timestamp) {
      createdAt = createdAtData.toDate();
    } else if (createdAtData is String) {
      createdAt = DateTime.tryParse(createdAtData) ?? DateTime.now();
    } else {
      createdAt = DateTime.now(); // Fallback
    }

    // userId extraction
    String userId = '';
    if (json['user'] is String) {
      userId = json['user'];
    } else if (json['user'] != null && json['user']['_id'] != null) {
      userId = json['user']['_id'];
    } else if (json['userId'] != null) {
      userId = json['userId'];
    }

    // Robust id and productId extraction
    String id = json['id'] as String? ?? json['_id'] as String? ?? '';
    String? productId = json['productId'] as String? ?? json['product'] as String?;

    return Review(
      id: id,
      userId: userId,
      userImage: json['userImage'] as String? ?? '',
      userName: (json['user'] != null && json['user']['name'] != null)
          ? json['user']['name']
          : 'User',
      content: json['content'] ?? json['review'] ?? json['text'] ?? '',
      rating: (json['ratings'] as num?)?.toDouble() ?? 0.0,
      createdAt: createdAt,
      productId: productId,
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
