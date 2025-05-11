import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/errors/failures.dart';
import 'package:pickpay/core/services/database_services.dart';
import 'package:pickpay/core/services/firebase_auth_service.dart';
import 'package:pickpay/core/services/shared_preferences_singletone.dart';
import 'package:pickpay/core/utils/backend_endpoints.dart';
import 'package:pickpay/features/auth/data/models/user_model.dart';
import 'package:pickpay/features/auth/domain/entities/user_entity.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';
import 'package:pickpay/services/api_service.dart';

class AuthRepoImplementation extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;
  final ApiService apiService;

  AuthRepoImplementation({
    required this.databaseService,
    required this.firebaseAuthService,
    required this.apiService,
  });

  // Create User
  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
    String email,
    String password,
    String fullName,
  ) async {
    User? user;
    try {
      user = await firebaseAuthService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send email verification
      await user.sendEmailVerification();

      // Sync Firebase user to backend
      final syncedUser = await apiService.syncFirebaseUserToBackend(
        name: fullName,
        email: email,
        firebaseUid: user.uid,
      );

      await saveUserData(user: syncedUser);

      return right(syncedUser);
    } catch (e) {
      await deleteUser(user);
      return left(ServerFailure('Signup failed: ${e.toString()}'));
    }
  }

  // Delete User
  Future<void> deleteUser(User? user) async {
    if (user != null) {
      await firebaseAuthService.deleteUser();
    }
  }

  // Sign in with email and password
  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final user = await firebaseAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if email is verified
      if (!user.emailVerified) {
        await FirebaseAuth.instance.signOut();
        return left(ServerFailure('يرجى تأكيد بريدك الإلكتروني قبل تسجيل الدخول'));
      }

      // Sync Firebase user to backend
      final syncedUser = await apiService.syncFirebaseUserToBackend(
        name: user.displayName ?? '',
        email: user.email ?? '',
        firebaseUid: user.uid,
      );

      await saveUserData(user: syncedUser);

      return right(syncedUser);
    } catch (e) {
      return left(ServerFailure('Login failed: ${e.toString()}'));
    }
  }

  // Sign in with Google
  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithGoogle();

      final syncedUser = await apiService.syncFirebaseUserToBackend(
        name: user.displayName ?? '',
        email: user.email ?? '',
        firebaseUid: user.uid,
      );

      await saveUserData(user: syncedUser);
      return right(syncedUser);
    } catch (e) {
      await deleteUser(user);
      return left(ServerFailure('Google sign-in failed: ${e.toString()}'));
    }
  }

  // Sign in with Facebook
  @override
  Future<Either<Failure, UserEntity>> signInWithFacebook() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithFacebook();

      final syncedUser = await apiService.syncFirebaseUserToBackend(
        name: user.displayName ?? '',
        email: user.email ?? '',
        firebaseUid: user.uid,
      );

      await saveUserData(user: syncedUser);
      return right(syncedUser);
    } catch (e) {
      await deleteUser(user);
      return left(ServerFailure('Facebook sign-in failed: ${e.toString()}'));
    }
  }

  // Sign out
  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await firebaseAuthService.signOut();
      await Prefs.remove(kUserData);
      return right(null);
    } catch (e) {
      return left(ServerFailure('Sign out failed: ${e.toString()}'));
    }
  }

  // Add User Data (if required in future)
  @override
  Future<Either<Failure, void>> addUserData({required UserEntity user}) async {
    // Implement this method if needed
    return right(null);
  }

  // Get User Data (optional method)
  @override
  Future<Either<Failure, UserEntity>> getUserData({required String userId}) async {
    try {
      final response = await apiService.get(
        endpoint: '${BackendEndpoints.getUserData}/$userId',
      );

      final data = jsonDecode(response.body);
      final userModel = UserModel.fromMap(data);
      return right(userModel);
    } catch (e) {
      return left(ServerFailure('Failed to get user data: ${e.toString()}'));
    }
  }

  // Save User Data in SharedPreferences
  @override
  Future<Either<Failure, void>> saveUserData({required UserEntity user}) async {
    try {
      final jsonData = jsonEncode(UserModel.fromEntity(user).toMap());
      await Prefs.setString(kUserData, jsonData);
      return right(null);
    } catch (e) {
      return left(ServerFailure('Failed to save user data: ${e.toString()}'));
    }
  }

  // Send Password Reset Email
  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuthService.sendPasswordResetEmail(email: email);
      return right(null);
    } catch (e) {
      return left(ServerFailure('Password reset failed: ${e.toString()}'));
    }
  }

  // Send Email Verification
  @override
  Future<Either<Failure, void>> sendEmailVerification() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        return right(null);
      } else if (user == null) {
        return left(ServerFailure('لم يتم العثور على مستخدم مسجل حاليًا'));
      } else {
        return left(ServerFailure('البريد الإلكتروني تم التحقق منه بالفعل'));
      }
    } catch (e) {
      return left(ServerFailure('فشل إرسال رابط التحقق: ${e.toString()}'));
    }
  }

  // Check if User Exists
  @override
  Future<Either<Failure, bool>> checkUserExists(String email) async {
    try {
      // Check in Firebase
      final methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.isNotEmpty) {
        return right(true);
      }

      // Check in backend if needed
      final response = await apiService.post(
        endpoint: BackendEndpoints.checkUserExists,
        body: {'email': email},
      );

      final data = jsonDecode(response.body);
      final exists = data['exists'] == true;

      return right(exists);
    } catch (e) {
      log('Check user exists error: $e');
      return left(ServerFailure('فشل التحقق من وجود المستخدم: ${e.toString()}'));
    }
  }

  // Reset Password via Backend
  @override
  Future<Either<Failure, void>> resetPassword({
    required String token,
    required String password,
    required String passwordConfirm,
  }) async {
    try {
      final response = await apiService.post(
        endpoint: BackendEndpoints.resetPassword,
        body: {
          'token': token,
          'password': password,
          'passwordConfirm': passwordConfirm,
        },
      );

      if (response.statusCode == 200) {
        return right(null);
      } else {
        return left(ServerFailure('Reset password failed: ${response.body}'));
      }
    } catch (e) {
      return left(ServerFailure('Reset password failed: ${e.toString()}'));
    }
  }
}
