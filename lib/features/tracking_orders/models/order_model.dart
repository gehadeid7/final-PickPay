import 'package:flutter/foundation.dart';

enum OrderStatus {
  pending,
  paid,
  delivered,
}

class OrderModel {
  final String id;
  final String userId;
  final List<Map<String, dynamic>> cartItems;
  final Map<String, dynamic> shippingAddress;
  final double totalAmount;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime? paidAt;
  final DateTime? deliveredAt;

  OrderModel({
    required this.id,
    required this.userId,
    required this.cartItems,
    required this.shippingAddress,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    this.paidAt,
    this.deliveredAt,
  });

  OrderModel copyWith({
    String? id,
    String? userId,
    List<Map<String, dynamic>>? cartItems,
    Map<String, dynamic>? shippingAddress,
    double? totalAmount,
    OrderStatus? status,
    DateTime? createdAt,
    DateTime? paidAt,
    DateTime? deliveredAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      cartItems: cartItems ?? this.cartItems,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      paidAt: paidAt ?? this.paidAt,
      deliveredAt: deliveredAt ?? this.deliveredAt,
    );
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'] ?? json['id'],
userId: json['user'] is Map
    ? json['user']['_id'] ?? ''
    : json['user'] ?? '',
      cartItems: (json['cartItems'] as List<dynamic>? ?? [])
          .map((item) {
            if (item is String) {
              return {
                'product': {'id': item},
                'quantity': 1,
              };
            }
            if (item is Map<String, dynamic>) {
              final map = Map<String, dynamic>.from(item);
              if (map['product'] is String) {
                map['product'] = {'id': map['product']};
              }
              if (map['product'] == null) {
                map['product'] = {};
              }
              return map;
            }
            return {
              'product': {'id': 'unknown'},
              'quantity': 1,
            };
          })
          .toList(),
shippingAddress: (json['shippingAddress'] is Map)
    ? Map<String, dynamic>.from(json['shippingAddress'])
    : {},
      totalAmount: (json['totalOrderPrice'] ?? 0).toDouble(),
      status: _parseStatus(
        isPaid: json['isPaid'] == true,
        isDelivered: json['isDelivered'] == true,
      ),
      createdAt: DateTime.parse(json['createdAt']),
      paidAt: json['paidAt'] != null ? DateTime.tryParse(json['paidAt']) : null,
      deliveredAt: json['deliveredAt'] != null
          ? DateTime.tryParse(json['deliveredAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'cartItems': cartItems.map((item) {
        final product = item['product'];
        return {
          ...item,
          'product': product is Map ? product : {'id': product.toString()},
        };
      }).toList(),
      'shippingAddress': shippingAddress,
      'totalOrderPrice': totalAmount,
      'status': status.toString(),
      'createdAt': createdAt.toIso8601String(),
      'paidAt': paidAt?.toIso8601String(),
      'deliveredAt': deliveredAt?.toIso8601String(),
    };
  }

  static OrderStatus _parseStatus({
    required bool isPaid,
    required bool isDelivered,
  }) {
    if (isDelivered) return OrderStatus.delivered;
    if (isPaid) return OrderStatus.paid;
    return OrderStatus.pending;
  }
}
