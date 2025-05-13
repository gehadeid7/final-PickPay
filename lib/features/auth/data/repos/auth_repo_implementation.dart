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
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthRepoImplementation extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;
  final ApiService apiService;

  AuthRepoImplementation({
    required this.databaseService,
    required this.firebaseAuthService,
    required this.apiService,
  });

  // 👤 Create User
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

      await user.sendEmailVerification();

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

  Future<void> deleteUser(User? user) async {
    if (user != null) {
      await firebaseAuthService.deleteUser();
    }
  }

  // 🔐 Sign in with email
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

      if (!user.emailVerified) {
        await FirebaseAuth.instance.signOut();
        return left(ServerFailure('يرجى تأكيد بريدك الإلكتروني قبل تسجيل الدخول'));
      }

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

  // 🔐 Google Sign-In
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

  // 🔐 Facebook Sign-In
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

  // 🔓 Sign out
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

  // 🧩 Optional: Add User Data
  @override
  Future<Either<Failure, void>> addUserData({required UserEntity user}) async {
    return right(null);
  }

  // 🧩 Get User Data
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

  // 💾 Save User Data to SharedPreferences
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

  // 🔁 Send Reset Password Email
  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuthService.sendPasswordResetEmail(email: email);
      return right(null);
    } catch (e) {
      return left(ServerFailure('Password reset failed: ${e.toString()}'));
    }
  }

  // 📧 Send Verification Email
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

  // 🔍 Check User Exists
  @override
  Future<Either<Failure, bool>> checkUserExists(String email) async {
    try {
      final methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.isNotEmpty) return right(true);

      final response = await apiService.post(
        endpoint: BackendEndpoints.checkUserExists,
        body: {'email': email},
      );

      final data = jsonDecode(response.body);
      return right(data['exists'] == true);
    } catch (e) {
      return left(ServerFailure('فشل التحقق من وجود المستخدم: ${e.toString()}'));
    }
  }

  // 🔐 Reset Password (Backend)
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

      if (response.statusCode == 200) return right(null);
      return left(ServerFailure('Reset password failed: ${response.body}'));
    } catch (e) {
      return left(ServerFailure('Reset password failed: ${e.toString()}'));
    }
  }

  // ✅ Auto-login
  @override
  Future<Either<Failure, bool>> isUserLoggedIn() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      return right(user != null);
    } catch (e) {
      return left(ServerFailure('فشل التحقق من تسجيل الدخول: ${e.toString()}'));
    }
  }

  // ✅ Get current user
  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final data = Prefs.getString(kUserData);
      if (data == null) {
        return left(ServerFailure('لا يوجد مستخدم محفوظ'));
      }
      final map = jsonDecode(data);
      final user = UserModel.fromMap(map);
      return right(user);
    } catch (e) {
      return left(ServerFailure('فشل في جلب المستخدم الحالي: ${e.toString()}'));
    }
  }

  // ✅ Check if Email Verified
  @override
  Future<Either<Failure, bool>> isEmailVerified() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return right(false);
      await user.reload();
      return right(user.emailVerified);
    } catch (e) {
      return left(ServerFailure('فشل التحقق من البريد الإلكتروني: ${e.toString()}'));
    }
  }

  // ✅ Update Profile
  @override
  Future<Either<Failure, void>> updateUserData(UserEntity user) async {
    try {
      final response = await apiService.put(
        endpoint: BackendEndpoints.updateUserProfile,
        body: UserModel.fromEntity(user).toMap(),
      );

      if (response.statusCode == 200) {
        await saveUserData(user: user);
        return right(null);
      } else {
        return left(ServerFailure('فشل تحديث البيانات: ${response.body}'));
      }
    } catch (e) {
      return left(ServerFailure('فشل تحديث البيانات: ${e.toString()}'));
    }
  }

  // 🍏 Sign in with Apple
  @override
  Future<Either<Failure, UserEntity>> signInWithApple() async {
    try {
      final AuthorizationCredentialAppleID appleIDCredential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final OAuthCredential credential = OAuthProvider('apple.com').credential(
        idToken: appleIDCredential.identityToken,
        accessToken: appleIDCredential.authorizationCode,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final syncedUser = await apiService.syncFirebaseUserToBackend(
        name: userCredential.user?.displayName ?? '',
        email: userCredential.user?.email ?? '',
        firebaseUid: userCredential.user?.uid ?? '',
      );

      await saveUserData(user: syncedUser);
      return right(syncedUser);
    } catch (e) {
      return left(ServerFailure('Apple sign-in failed: ${e.toString()}'));
    }
  }
}