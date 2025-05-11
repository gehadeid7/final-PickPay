import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pickpay/core/errors/exceptions.dart';

class FirebaseAuthService {
  Future<void> deleteUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw CustomException(message: 'لا يوجد مستخدم مسجل حالياً');
      }
      await user.delete();
    } catch (e, stackTrace) {
      log('Error @deleteUser: $e', stackTrace: stackTrace);
      throw CustomException(message: 'حدث خطأ أثناء حذف الحساب.');
    }
  }

  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (credential.user == null) {
        throw CustomException(
            message: 'حدث خطأ غير متوقع. المستخدم غير موجود.');
      }

      return credential.user!;
    } on FirebaseAuthException catch (e, stackTrace) {
      log('FirebaseAuthException @createUserWithEmailAndPassword: ${e.code}',
          stackTrace: stackTrace);

      switch (e.code) {
        case 'weak-password':
          throw CustomException(message: 'كلمة المرور ضعيفة جداً.');
        case 'email-already-in-use':
          throw CustomException(
              message: 'هذا البريد الإلكتروني مستخدم بالفعل.');
        case 'invalid-email':
          throw CustomException(message: 'صيغة البريد الإلكتروني غير صحيحة.');
        case 'network-request-failed':
          throw CustomException(message: 'تحقق من اتصالك بالإنترنت.');
        default:
          throw CustomException(message: 'حدث خطأ، حاول مرة أخرى.');
      }
    } catch (e, stackTrace) {
      log('Unexpected error @createUserWithEmailAndPassword: $e',
          stackTrace: stackTrace);
      throw CustomException(message: 'حدث خطأ غير متوقع، حاول لاحقًا.');
    }
  }

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (credential.user == null) {
        throw CustomException(message: 'حدث خطأ. المستخدم غير موجود.');
      }

      return credential.user!;
    } on FirebaseAuthException catch (e, stackTrace) {
      log("FirebaseAuthException @signInWithEmailAndPassword: ${e.code}",
          stackTrace: stackTrace);
      switch (e.code) {
        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-credential':
          throw CustomException(
              message: 'البريد الإلكتروني أو كلمة المرور غير صحيحة.');
        case 'network-request-failed':
          throw CustomException(message: 'تأكد من اتصالك بالإنترنت.');
        default:
          throw CustomException(message: 'حدث خطأ، حاول مجددًا.');
      }
    } catch (e, stackTrace) {
      log("Unexpected error @signInWithEmailAndPassword: $e",
          stackTrace: stackTrace);
      throw CustomException(message: 'حدث خطأ، حاول مرة أخرى.');
    }
  }

  Future<User> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        throw CustomException(
            message: 'تم إلغاء تسجيل الدخول باستخدام Google.');
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user == null) {
        throw CustomException(message: 'فشل تسجيل الدخول باستخدام Google.');
      }

      return userCredential.user!;
    } catch (e, stackTrace) {
      log("Error signing in with Google: $e", stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<User> signInWithFacebook() async {
    try {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);
      final loginResult = await FacebookAuth.instance.login();

      if (loginResult.accessToken == null) {
        throw CustomException(
            message: 'تم إلغاء تسجيل الدخول باستخدام Facebook.');
      }

      OAuthCredential facebookAuthCredential;

      if (Platform.isIOS) {
        switch (loginResult.accessToken!.type) {
          case AccessTokenType.classic:
            final token = loginResult.accessToken as ClassicToken;
            facebookAuthCredential = FacebookAuthProvider.credential(
              token.authenticationToken!,
            );
            break;
          case AccessTokenType.limited:
            final token = loginResult.accessToken as LimitedToken;
            facebookAuthCredential = OAuthCredential(
              providerId: 'facebook.com',
              signInMethod: 'oauth',
              idToken: token.tokenString,
              rawNonce: rawNonce,
            );
            break;
          default:
            throw CustomException(message: 'نوع رمز غير معروف من Facebook.');
        }
      } else {
        facebookAuthCredential = FacebookAuthProvider.credential(
          loginResult.accessToken!.tokenString,
        );
      }

      final userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

      if (userCredential.user == null) {
        throw CustomException(message: 'فشل تسجيل الدخول باستخدام Facebook.');
      }

      return userCredential.user!;
    } catch (e, stackTrace) {
      log("Error signing in with Facebook: $e", stackTrace: stackTrace);
      rethrow;
    }
  }

  bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e, stackTrace) {
      log('FirebaseAuthException @sendPasswordResetEmail: ${e.code}',
          stackTrace: stackTrace);

      switch (e.code) {
        case 'invalid-email':
          throw CustomException(message: 'صيغة البريد الإلكتروني غير صحيحة.');
        case 'user-not-found':
          throw CustomException(
              message: 'لا يوجد مستخدم بهذا البريد الإلكتروني.');
        case 'network-request-failed':
          throw CustomException(message: 'تحقق من اتصالك بالإنترنت.');
        case 'too-many-requests':
          throw CustomException(message: 'طلبات كثيرة جداً. حاول لاحقًا.');
        default:
          throw CustomException(message: 'حدث خطأ، حاول مرة أخرى.');
      }
    } catch (e, stackTrace) {
      log('Unexpected error @sendPasswordResetEmail: $e',
          stackTrace: stackTrace);
      throw CustomException(message: 'حدث خطأ غير متوقع، حاول لاحقًا.');
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e, stackTrace) {
      log('Error signing out: $e', stackTrace: stackTrace);
      throw CustomException(message: 'حدث خطأ أثناء تسجيل الخروج.');
    }
  }

  // Generates a secure random nonce
  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = math.Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  // Returns SHA256 hash of input
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
