import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';
import 'package:get_it/get_it.dart';

part 'verify_email_state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  final AuthRepo authRepo;
  Timer? _countdownTimer;
  Timer? _autoCheckTimer;
  int _countdownSeconds = 10;
  bool _isSending = false;
  bool _isAutoRedirectAllowed = true;

  /// Stream controller to emit countdown seconds to UI
  final StreamController<int> countdownController = StreamController<int>.broadcast();

  VerifyEmailCubit()
      : authRepo = GetIt.I<AuthRepo>(),
        super(VerifyEmailInitial());

  /// Starts countdown timer to disable resend button for [_countdownSeconds] seconds
  void startCountdown() {
    _countdownSeconds = 10;
    emit(VerifyEmailButtonDisabled());
    countdownController.add(_countdownSeconds);

    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _countdownSeconds--;
      countdownController.add(_countdownSeconds);

      if (_countdownSeconds <= 0) {
        timer.cancel();
        emit(VerifyEmailButtonEnabled());
      }
    });
  }

  /// Sends verification email to the current user if possible
  Future<void> sendVerificationEmail() async {
    if (_isSending) return; // Prevent multiple concurrent sends
    _isSending = true;
    emit(VerifyEmailLoading());

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(VerifyEmailFailure('لم يتم العثور على مستخدم حاليًا'));
      _isSending = false;
      return;
    }

    if (user.emailVerified) {
      emit(VerifyEmailFailure('البريد الإلكتروني تم التحقق منه بالفعل'));
      _isSending = false;
      return;
    }

    try {
      await user.sendEmailVerification();
      emit(VerifyEmailSuccess());
      startCountdown();
    } catch (e) {
      emit(VerifyEmailFailure('فشل إرسال رابط التحقق: ${e.toString()}'));
    } finally {
      _isSending = false;
    }
  }

  /// Starts periodic check every 3 seconds to detect if email has been verified
  /// When detected, emits [VerifyEmailRefreshed] state
  void startAutoRedirect() {
    _isAutoRedirectAllowed = true;
    _autoCheckTimer?.cancel();
    _autoCheckTimer = Timer.periodic(const Duration(seconds: 3), (_) async {
      if (!_isAutoRedirectAllowed) return;

      final user = FirebaseAuth.instance.currentUser;
      await user?.reload();

      if (user?.emailVerified == true) {
        _autoCheckTimer?.cancel();
        emit(VerifyEmailRefreshed());
      }
    });
  }

  /// Stops the automatic redirect timer and disables auto redirect
  void stopAutoRedirect() {
    _isAutoRedirectAllowed = false;
    _autoCheckTimer?.cancel();
  }

  @override
  Future<void> close() {
    countdownController.close();
    _countdownTimer?.cancel();
    _autoCheckTimer?.cancel();
    return super.close();
  }
}
