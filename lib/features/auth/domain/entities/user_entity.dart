import 'package:firebase_auth/firebase_auth.dart';

class UserEntity {
  final String fullName;
  final String email;
  final String uId;
  final bool emailVerified;

  UserEntity({
    required this.fullName,
    required this.email,
    required this.uId,
    required this.emailVerified,
  });

  // Factory constructor to create UserEntity from Firebase User
  factory UserEntity.fromFirebaseUser(User user) {
    return UserEntity(
      fullName: user.displayName ?? '', // Firebase displayName might be null
      email: user.email ?? '', // Firebase email might be null
      uId: user.uid,
      emailVerified: user.emailVerified,
    );
  }
}
