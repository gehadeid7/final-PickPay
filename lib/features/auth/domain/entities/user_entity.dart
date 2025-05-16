import 'package:firebase_auth/firebase_auth.dart';

class UserEntity {
  final String fullName;
  final String email;
  final String uId;
  final bool emailVerified;
  final String? photoUrl;

  // ✅ Add optional fields
  final String? phone;
  final String? gender;
  final String? dob;
  final String? age;
  final String? address;

  UserEntity({
    required this.fullName,
    required this.email,
    required this.uId,
    required this.emailVerified,
    this.photoUrl,
    this.phone,
    this.gender,
    this.dob,
    this.age,
    this.address,
  });

  factory UserEntity.fromFirebaseUser(User user) {
    return UserEntity(
      fullName: user.displayName ?? '',
      email: user.email ?? '',
      uId: user.uid,
      emailVerified: user.emailVerified,
      photoUrl: user.photoURL,
    );
  }

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

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      uId: map['uId'] ?? '',
      emailVerified: map['emailVerified'] ?? false,
      photoUrl: map['photoUrl'],
      phone: map['phone'],
      gender: map['gender'],
      dob: map['dob'],
      age: map['age'],
      address: map['address'],
    );
  }
}
