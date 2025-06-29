// models/order_model.dart
import 'package:pickpay/features/cart/cart_item_model.dart';

class OrderModel {
  final String id;
  final DateTime date;
  final List<CartItemModel> items;
  final double total;
  final ShippingInfo shippingInfo;
  final PaymentInfo paymentInfo;
  final String status;

  OrderModel({
    required this.id,
    required this.date,
    required this.items,
    required this.total,
    required this.shippingInfo,
    required this.paymentInfo,
    this.status = 'Processing',
  });
}

class ShippingInfo {
  final String name;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String phone;
  final String email;

  ShippingInfo({
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.phone,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'phone': phone,
      'email': email,
    };
  }

  factory ShippingInfo.fromJson(Map<String, dynamic> json) {
    return ShippingInfo(
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      zipCode: json['zipCode'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
    );
  }
}

class PaymentInfo {
  final String method;
  final String cardLastFour;
  final String transactionId;

  PaymentInfo({
    required this.method,
    required this.cardLastFour,
    required this.transactionId,
  });
}
