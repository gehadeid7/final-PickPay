import 'package:firebase_auth/firebase_auth.dart';
import 'package:pickpay/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  // Constructor for UserModel
  UserModel({
    required String fullName,
    required String email,
    required String uId,
    required bool emailVerified, // Accept emailVerified as a parameter
  }) : super(
          fullName: fullName,
          email: email,
          uId: uId,
          emailVerified: emailVerified, // Pass emailVerified to the UserEntity constructor
        );

  // Factory method to create a UserModel from Firebase User
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      fullName: user.displayName ?? '',
      email: user.email ?? '',
      uId: user.uid,
      emailVerified: user.emailVerified, // Set emailVerified from Firebase
    );
  }

  // Factory method to create a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['name'] ?? json['fullName'],
      email: json['email'],
      uId: json['uId'] ?? json['_id'],
      emailVerified: json['emailVerified'] ?? false, // Assuming emailVerified is available in JSON
    );
  }

  // Add the fromEntity method to convert a UserEntity to a UserModel
  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      fullName: user.fullName,
      email: user.email,
      uId: user.uId,
      emailVerified: user.emailVerified, // Access emailVerified from UserEntity
    );
  }

  // Convert UserModel to Map (useful for saving to a database)
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'uId': uId,
      'emailVerified': emailVerified, // Add emailVerified to map
    };
  }
}
