import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pickpay/features/auth/presentation/views/signin_view.dart';

part 'verify_email_state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  final AuthRepo authRepo;
  Timer? _timer;
  Timer? _autoCheckTimer;
  int _countdown = 10;
  bool isSending = false;
  bool isRedirectingAllowed = true; // Flag to control redirection
  StreamController<int> countdownController = StreamController<int>();

  VerifyEmailCubit()
      : authRepo = GetIt.I<AuthRepo>(),
        super(VerifyEmailInitial());

  // Start the countdown for resending the email
  void startCountdown() {
    _countdown = 10;
    emit(VerifyEmailButtonDisabled());
    countdownController.add(_countdown);

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _countdown--;
      countdownController.add(_countdown);
      if (_countdown <= 0) {
        timer.cancel();
        emit(VerifyEmailButtonEnabled());
      }
    });
  }

  // Send verification email
  Future<void> sendVerificationEmail(BuildContext context) async {
    print('[DEBUG] Resend verification triggered');

    if (isSending) {
      print('[DEBUG] Email is already being sent. Ignoring request.');
      return;
    }

    isSending = true;
    emit(VerifyEmailLoading());

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('[ERROR] No current user found');
      emit(VerifyEmailFailure('لم يتم العثور على مستخدم حاليًا'));
      isSending = false;
      return;
    }

    if (user.emailVerified) {
      print('[INFO] Email already verified');
      emit(VerifyEmailFailure('البريد الإلكتروني تم التحقق منه بالفعل'));
      isSending = false;
      return;
    }

    try {
      print('[INFO] Sending email verification...');
      await user.sendEmailVerification();
      print('[SUCCESS] Verification email sent.');
      emit(VerifyEmailSuccess());
      startCountdown();
    } on FirebaseAuthException catch (e) {
      print('[FIREBASE ERROR] ${e.message}');
      emit(VerifyEmailFailure('فشل إرسال رابط التحقق: ${e.message}'));
    } catch (e) {
      print('[UNEXPECTED ERROR] $e');
      emit(VerifyEmailFailure('فشل غير متوقع: ${e.toString()}'));
    } finally {
      isSending = false;
      print('[DEBUG] Finished sendVerificationEmail process');
    }
  }

  // Check if the email has been verified and automatically redirect
  void startAutoRedirect(BuildContext context) {
    // Allow redirection only if it's not in the process of resending the email
    if (isRedirectingAllowed) {
      _autoCheckTimer = Timer.periodic(const Duration(seconds: 3), (_) async {
        final user = FirebaseAuth.instance.currentUser;
        await user?.reload();
        if (user?.emailVerified == true) {
          _autoCheckTimer?.cancel();
          Navigator.pushReplacementNamed(context, SigninView.routeName);
        }
      });
    }
  }

  // Prevent auto redirection when the user interacts with resending
  void stopAutoRedirect() {
    _autoCheckTimer?.cancel();
    isRedirectingAllowed = false;
  }

  @override
  Future<void> close() {
    countdownController.close();
    _timer?.cancel();
    _autoCheckTimer?.cancel();
    return super.close();
  }
}
