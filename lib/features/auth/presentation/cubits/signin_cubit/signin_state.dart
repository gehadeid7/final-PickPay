part of 'signin_cubit.dart';

@immutable
sealed class SigninState {
  const SigninState();
}

// الحالة الابتدائية عند تحميل صفحة تسجيل الدخول أو إعادة التعيين
final class SigninInitial extends SigninState {
  const SigninInitial();
}

// حالة أثناء تنفيذ عملية تسجيل الدخول (تحميل)
final class SigninLoading extends SigninState {
  const SigninLoading();
}

// حالة نجاح تسجيل الدخول مع حفظ بيانات المستخدم
final class SigninSuccess extends SigninState {
  final UserEntity userEntity;
  const SigninSuccess({required this.userEntity});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SigninSuccess && userEntity == other.userEntity);

  @override
  int get hashCode => userEntity.hashCode;
}

// حالة فشل تسجيل الدخول مع رسالة الخطأ
final class SigninFailure extends SigninState {
  final String message;
  const SigninFailure({required this.message});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SigninFailure && message == other.message);

  @override
  int get hashCode => message.hashCode;
}
