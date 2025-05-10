import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this.authRepo) : super(ForgotPasswordInitial());

  final AuthRepo authRepo;
  Timer? _resendTimer;
  int _resendCooldown = 30;

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    if (email.isEmpty) {
      emit(ForgotPasswordFailure(message: 'Please enter your email'));
      return;
    }

    if (!_isValidEmail(email)) {
      emit(ForgotPasswordFailure(message: 'Please enter a valid email'));
      return;
    }

    emit(ForgotPasswordLoading());
    try {
      final result = await authRepo.sendPasswordResetEmail(email);
      result.fold(
        (failure) => emit(ForgotPasswordFailure(message: failure.message)),
        (_) {
          _startResendTimer();
          emit(ForgotPasswordSuccess(cooldown: _resendCooldown));
        },
      );
    } catch (e) {
      emit(ForgotPasswordFailure(
        message: 'Failed to send reset email: ${e.toString()}',
      ));
    }
  }

  void _startResendTimer() {
    _resendTimer?.cancel();
    _resendCooldown = 30;
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCooldown > 0) {
        _resendCooldown--;
        emit(ForgotPasswordSuccess(cooldown: _resendCooldown));
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Future<void> close() {
    _resendTimer?.cancel();
    return super.close();
  }
}
