import 'package:firebase_auth/firebase_auth.dart';
import 'package:pickpay/features/auth/domain/entities/user_entity.dart';
import 'package:pickpay/services/api_service.dart';

class UserModel extends UserEntity {
  UserModel({
    required String fullName,
    required String email,
    required String uId,
    required bool emailVerified,
    String? photoUrl,
    String? phone,
    String? gender,
    String? dob,
    String? age,
    String? address,
  }) : super(
          fullName: fullName,
          email: email,
          uId: uId,
          emailVerified: emailVerified,
          photoUrl: photoUrl,
          phone: phone,
          gender: gender,
          dob: dob,
          age: age,
          address: address,
        );

  /// Create from Firebase `User`
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      fullName: user.displayName ?? 'Unknown',
      email: user.email ?? 'Unknown',
      uId: user.uid,
      emailVerified: user.emailVerified,
      photoUrl: user.photoURL,
    );
  }

  /// Create from a JSON object (API response)
  factory UserModel.fromJson(Map<String, dynamic> json) {    
    // Handle both backend and Firebase user data formats
    final fullName = json['fullName'] ?? json['name'] ?? 'Unknown';
    final email = json['email'] ?? 'Unknown';
    final uId = json['uId'] ?? json['_id'] ?? json['id'] ?? 'Unknown';
    final emailVerified = json['emailVerified'] ?? false;
    
    // Handle photo URL - could be in different fields
    String? photoUrl = json['photoUrl'];
    
    // If we don't have a photoUrl, check other fields
    if (photoUrl == null || photoUrl.isEmpty) {
      // First check if we have a full URL in profileImgUrl
      photoUrl = json['profileImgUrl'];
      
      // If still no URL, check profileImg
      if (photoUrl == null || photoUrl.isEmpty) {
        photoUrl = json['profileImg'];
        // Only construct URL if profileImg is not already a full URL
        if (photoUrl != null && !photoUrl.startsWith('http')) {
          // Get base URL without trailing slash and remove /api/v1
          final baseUrl = ApiService.baseUrl.replaceAll('/api/v1/', '').replaceAll(RegExp(r'/$'), '');
          photoUrl = '$baseUrl/uploads/users/$photoUrl';
        } else {
        }
      } else {
      }
    } else {
    }
    

    return UserModel(
      fullName: fullName,
      email: email,
      uId: uId,
      emailVerified: emailVerified,
      photoUrl: photoUrl,
      phone: json['phone'],
      gender: json['gender'],
      dob: json['dob'],
      age: json['age']?.toString(),
      address: json['address'],
    );
  }

  /// Create from a Map (e.g., local storage)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fullName: map['fullName'] ?? 'Unknown',
      email: map['email'] ?? 'Unknown',
      uId: map['uId'] ?? 'Unknown',
      emailVerified: map['emailVerified'] ?? false,
      photoUrl: map['photoUrl'],
      phone: map['phone'],
      gender: map['gender'],
      dob: map['dob'],
      age: map['age'],
      address: map['address'],
    );
  }

  /// Create from a UserEntity
  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      fullName: user.fullName,
      email: user.email,
      uId: user.uId,
      emailVerified: user.emailVerified,
      photoUrl: user.photoUrl,
      phone: user.phone,
      gender: user.gender,
      dob: user.dob,
      age: user.age,
      address: user.address,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'uId': uId,
      'emailVerified': emailVerified,
      'photoUrl': photoUrl,
      'phone': phone,
      'gender': gender,
      'dob': dob,
      'age': age,
      'address': address,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'name': fullName,
      'email': email,
      'uId': uId,
      'emailVerified': emailVerified,
      'photoUrl': photoUrl,
      'phone': phone,
      'gender': gender,
      'dob': dob,
      'age': age,
      'address': address,
    };
  }
}
