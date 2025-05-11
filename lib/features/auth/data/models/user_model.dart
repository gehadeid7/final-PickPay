import 'package:firebase_auth/firebase_auth.dart';
import 'package:pickpay/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  // Constructor for UserModel
  UserModel({
    required String fullName,
    required String email,
    required String uId,
    required bool emailVerified,
  }) : super(
          fullName: fullName,
          email: email,
          uId: uId,
          emailVerified: emailVerified,
        );

  // Factory method to create a UserModel from Firebase User
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      fullName: user.displayName ?? 'Unknown', // Provide a default value
      email: user.email ?? 'Unknown', // Provide a default value
      uId: user.uid,
      emailVerified: user.emailVerified,
    );
  }

  // Factory method to create a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['name'] ?? json['fullName'] ?? 'Unknown', // Default to 'Unknown'
      email: json['email'] ?? 'Unknown', // Default to 'Unknown'
      uId: json['uId'] ?? json['_id'] ?? 'Unknown', // Default to 'Unknown'
      emailVerified: json['emailVerified'] ?? false, // Default to false
    );
  }

  // Method to convert UserModel from a Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fullName: map['fullName'] ?? 'Unknown',
      email: map['email'] ?? 'Unknown',
      uId: map['uId'] ?? 'Unknown',
      emailVerified: map['emailVerified'] ?? false,
    );
  }

  // Add the fromEntity method to convert a UserEntity to a UserModel
  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      fullName: user.fullName,
      email: user.email,
      uId: user.uId,
      emailVerified: user.emailVerified,
    );
  }

  // Convert UserModel to Map (useful for saving to a database)
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'uId': uId,
      'emailVerified': emailVerified,
    };
  }

  // Convert UserModel to JSON (useful for sending to backend)
  Map<String, dynamic> toJson() {
    return {
      'name': fullName,
      'email': email,
      'uId': uId,
      'emailVerified': emailVerified,
    };
  }
}
