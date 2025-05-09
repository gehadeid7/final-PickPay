import 'package:bloc/bloc.dart';
import 'package:pickpay/core/errors/failures.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'verify_email_state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  final AuthRepo authRepo;

  VerifyEmailCubit() : 
    authRepo = GetIt.I<AuthRepo>(), 
    super(VerifyEmailInitial());

  Future<void> sendVerificationEmail(BuildContext context) async {
    emit(VerifyEmailLoading());

    final result = await authRepo.sendEmailVerification();

    result.fold(
      (failure) => emit(VerifyEmailFailure(failure.message)),
      (_) {
        emit(VerifyEmailSuccess());
        // After sending the email verification link, check the status
        _checkEmailVerificationStatus(context);
      },
    );
  }

  // Method to check email verification status
  Future<void> _checkEmailVerificationStatus(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;

    // Reload the user data to check for verification
    await user?.reload();

    if (user != null && user.emailVerified) {
      // If email is verified, navigate to the Home screen
      Navigator.pushReplacementNamed(context, '/homecategory_view');
    } else {
      // If email is not verified, show the user an alert
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى التحقق من بريدك الإلكتروني')),
      );
      // Optionally, set a timer to keep checking email verification status in the background
    }
  }
}
