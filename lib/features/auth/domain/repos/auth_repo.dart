import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pickpay/core/errors/failures.dart';
import 'package:pickpay/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  // 👤 Account Creation
  Future<Either<Failure, bool>> checkUserExists(String email);
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
    String email,
    String password,
    String fullName,
  );
  Future<Either<Failure, String>> uploadProfileImage(String userId, File image);

  /// 🆕 Upload profile image and update backend user profile
  Future<Either<Failure, UserEntity>> uploadProfileImageAndUpdate(File image);

  // 🔐 Authentication
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  );
  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future<Either<Failure, UserEntity>> signInWithFacebook();

  // 🍏 Added: Sign in with Apple
  Future<Either<Failure, UserEntity>> signInWithApple();

  Future<Either<Failure, void>> signOut();

  // 🧩 Account Management
  Future<Either<Failure, void>> addUserData({required UserEntity user});
  Future<Either<Failure, void>> saveUserData({required UserEntity user});
  Future<Either<Failure, UserEntity>> getUserData({required String userId});
  Future<Either<Failure, void>> sendPasswordResetEmail(String email);
  Future<Either<Failure, void>> sendEmailVerification();

  // 🔒 Backend Password Reset
  Future<Either<Failure, void>> resetPassword({
    required String token,
    required String password,
    required String passwordConfirm,
  });

  // ✅ Added: Useful Real-World Features
  Future<Either<Failure, bool>> isUserLoggedIn();
  Future<Either<Failure, UserEntity>> getCurrentUser();
  Future<Either<Failure, bool>> isEmailVerified();
  Future<Either<Failure, void>> updateUserData(UserEntity user);
  Future<Either<Failure, bool>> checkIfImageExists(String imageUrl);
}
