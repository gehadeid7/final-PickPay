import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(const ChangePasswordInitial());

  void changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(const ChangePasswordLoading());

    // Validate inputs
    if (newPassword != confirmPassword) {
      emit(const ChangePasswordFailure('Passwords do not match'));
      return;
    }

    if (newPassword.length < 6) {
      emit(const ChangePasswordFailure(
          'Password must be at least 6 characters'));
      return;
    }

    // Here you would typically call your authentication service
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // If successful
      emit(const ChangePasswordSuccess());
    } catch (e) {
      emit(ChangePasswordFailure(e.toString()));
    }
  }

  void resetState() {
    emit(const ChangePasswordInitial());
  }
}
