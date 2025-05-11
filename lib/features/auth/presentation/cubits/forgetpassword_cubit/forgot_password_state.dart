part of 'forgot_password_cubit.dart';

@immutable
sealed class ForgotPasswordState {
  const ForgotPasswordState();
}

final class ForgotPasswordInitial extends ForgotPasswordState {
  const ForgotPasswordInitial();
}

class ForgotPasswordReadyToResend extends ForgotPasswordState {}

final class ForgotPasswordLoading extends ForgotPasswordState {
  const ForgotPasswordLoading();
}

final class ForgotPasswordSuccess extends ForgotPasswordState {
  final int cooldown;
  const ForgotPasswordSuccess({required this.cooldown});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ForgotPasswordSuccess && other.cooldown == cooldown;
  }

  @override
  int get hashCode => cooldown.hashCode;
}

final class ForgotPasswordFailure extends ForgotPasswordState {
  final String message;
  const ForgotPasswordFailure({required this.message});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ForgotPasswordFailure && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

final class ForgotPasswordInvalidEmail extends ForgotPasswordState {
  final String message;
  const ForgotPasswordInvalidEmail({required this.message});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ForgotPasswordInvalidEmail && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
