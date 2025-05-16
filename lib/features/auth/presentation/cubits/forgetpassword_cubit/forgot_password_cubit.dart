import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this.authRepo) : super(ForgotPasswordInitial());

  final AuthRepo authRepo;
  Timer? _resendTimer;
  static const int _maxCooldown = 30;
  int _resendCooldown = 0;

  int get cooldown => _resendCooldown;

  bool _isValidEmail(String email) {
    // يمكن تحسين Regex لاحقًا أو استخدام مكتبة تحقق متخصصة
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    if (email.isEmpty) {
      emit(ForgotPasswordFailure(message: 'Please enter your email'));
      return;
    }
    if (!_isValidEmail(email)) {
      emit(ForgotPasswordInvalidEmail(message: 'Please enter a valid email'));
      return;
    }

    emit(ForgotPasswordLoading());

    try {
      final resetResult = await authRepo.sendPasswordResetEmail(email);

      resetResult.fold(
        (failure) {
          emit(ForgotPasswordFailure(message: failure.message));
          _cancelResendTimer();
        },
        (_) {
          emit(ForgotPasswordLinkSent());
          _startResendTimer();
        },
      );
    } catch (e) {
      emit(ForgotPasswordFailure(message: 'Failed to send reset email: ${e.toString()}'));
      _cancelResendTimer();
    }
  }

  void _startResendTimer() {
    _cancelResendTimer();
    _resendCooldown = _maxCooldown;

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCooldown > 0) {
        _resendCooldown--;
        emit(ForgotPasswordSuccess(cooldown: _resendCooldown));
      } else {
        _cancelResendTimer();
        emit(ForgotPasswordReadyToResend());
      }
    });
  }

  void _cancelResendTimer() {
    if (_resendTimer != null) {
      _resendTimer!.cancel();
      _resendTimer = null;
    }
  }

  void resetResendCooldown() {
    _startResendTimer();
  }

  @override
  Future<void> close() {
    _cancelResendTimer();
    return super.close();
  }
}
