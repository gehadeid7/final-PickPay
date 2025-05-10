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
  StreamController<int> countdownController = StreamController<int>();

  VerifyEmailCubit() : authRepo = GetIt.I<AuthRepo>(), super(VerifyEmailInitial());

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

  Future<void> sendVerificationEmail(BuildContext context) async {
    if (isSending) return;
    isSending = true;
    emit(VerifyEmailLoading());

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(VerifyEmailFailure('لم يتم العثور على مستخدم حاليًا'));
      isSending = false;
      return;
    }

    if (user.emailVerified) {
      emit(VerifyEmailFailure('البريد الإلكتروني تم التحقق منه بالفعل'));
      isSending = false;
      return;
    }

    try {
      await user.sendEmailVerification();
      emit(VerifyEmailSuccess());
      startCountdown();
    } on FirebaseAuthException catch (e) {
      emit(VerifyEmailFailure('فشل إرسال رابط التحقق: ${e.message}'));
    } catch (e) {
      emit(VerifyEmailFailure('فشل غير متوقع: ${e.toString()}'));
    } finally {
      isSending = false;
    }
  }

  void startAutoRedirect(BuildContext context) {
    _autoCheckTimer = Timer.periodic(const Duration(seconds: 3), (_) async {
      final user = FirebaseAuth.instance.currentUser;
      await user?.reload();
      if (user?.emailVerified == true) {
        _autoCheckTimer?.cancel();
        Navigator.pushReplacementNamed(context, SigninView.routeName);
      }
    });
  }

  @override
  Future<void> close() {
    countdownController.close();
    _timer?.cancel();
    _autoCheckTimer?.cancel();
    return super.close();
  }
}
