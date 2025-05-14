import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  ChangePasswordCubit() : super(const ChangePasswordInitial());

  void changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(const ChangePasswordLoading());

    // Validate inputs
    if (newPassword != confirmPassword) {
      emit(const ChangePasswordFailure('Passwords do not match.'));
      return;
    }

    if (newPassword.length < 6) {
      emit(const ChangePasswordFailure('Password must be at least 6 characters.'));
      return;
    }

    // Prevent change if the current and new passwords are the same
    if (currentPassword == newPassword) {
      emit(const ChangePasswordFailure('New password cannot be the same as the current password.'));
      return;
    }

    try {
      // Reauthenticate the user
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        emit(const ChangePasswordFailure('You must be logged in to change your password.'));
        return;
      }

      // Reauthenticate with the current password
      final credentials = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credentials);

      // If successful, update the password
      await user.updatePassword(newPassword);

      emit(const ChangePasswordSuccess());
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuthException errors with professional messages
      if (e.code == 'wrong-password') {
        emit(const ChangePasswordFailure('The current password you entered is incorrect. Please try again.'));
      } else if (e.code == 'user-not-found') {
        emit(const ChangePasswordFailure('No user found with this email. Please check your credentials.'));
      } else if (e.code == 'requires-recent-login') {
        emit(const ChangePasswordFailure('You need to reauthenticate to change your password.'));
      } else {
        emit(ChangePasswordFailure('An unexpected error occurred. Please try again later.'));
      }
    } catch (e) {
      emit(ChangePasswordFailure('Something went wrong. Please try again later.'));
    }
  }

  void resetState() {
    emit(const ChangePasswordInitial());
  }
}
