part of 'change_password_cubit.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {
  const ChangePasswordInitial();
}

class ChangePasswordLoading extends ChangePasswordState {
  const ChangePasswordLoading();
}

class ChangePasswordSuccess extends ChangePasswordState {
  const ChangePasswordSuccess();
}

class ChangePasswordFailure extends ChangePasswordState {
  final String message;
  const ChangePasswordFailure(this.message);

  @override
  List<Object> get props => [message];
}
