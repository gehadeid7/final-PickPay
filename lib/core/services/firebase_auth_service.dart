import 'package:firebase_auth/firebase_auth.dart';
import 'package:pickpay/core/errors/exceptions.dart';

class FirebaseAuthService {
  Future<User> createUserWithEmailAndPassword({
    required String email, 
    required String password,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      if (credential.user == null) {
        throw CustomException(message: 'Something went wrong. User is null.');
      }

      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw CustomException(message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(
            message: 'The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        throw CustomException(message: 'The email address is badly formatted.');
      } else {
        throw CustomException(
            message: 'An error occurred. Please try again later.');
      }
    } catch (e) {
      throw CustomException(
          message: 'An unexpected error occurred. Please try again.');
    }
  }
}
