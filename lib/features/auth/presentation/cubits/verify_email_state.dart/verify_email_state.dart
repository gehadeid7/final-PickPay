part of 'verify_email_cubit.dart';

abstract class VerifyEmailState {}

class VerifyEmailInitial extends VerifyEmailState {}

class VerifyEmailLoading extends VerifyEmailState {}

class VerifyEmailSuccess extends VerifyEmailState {}

class VerifyEmailFailure extends VerifyEmailState {
  final String message;
  VerifyEmailFailure(this.message);
}

class VerifyEmailButtonDisabled extends VerifyEmailState {}

class VerifyEmailButtonEnabled extends VerifyEmailState {}

class VerifyEmailRefreshed extends VerifyEmailState {}
