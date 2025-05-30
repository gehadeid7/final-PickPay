import 'package:firebase_auth/firebase_auth.dart';

class UserEntity {
  final String fullName;
  final String email;
  final String uId;
  final bool emailVerified;
  final String? photoUrl;

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

  /// ✅ New: copyWith method
  UserEntity copyWith({
    String? fullName,
    String? email,
    String? uId,
    bool? emailVerified,
    String? photoUrl,
    String? phone,
    String? gender,
    String? dob,
    String? age,
    String? address,
  }) {
    return UserEntity(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      uId: uId ?? this.uId,
      emailVerified: emailVerified ?? this.emailVerified,
      photoUrl: photoUrl ?? this.photoUrl,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      age: age ?? this.age,
      address: address ?? this.address,
    );
  }
}
