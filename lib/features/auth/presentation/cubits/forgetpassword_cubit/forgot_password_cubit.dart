import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this.authRepo) : super(ForgotPasswordInitial());
  
  final AuthRepo authRepo;

  Future<void> sendPasswordResetEmail(String email) async {
    emit(ForgotPasswordLoading());
    try {
      await authRepo.sendPasswordResetEmail(email);
      emit(ForgotPasswordSuccess());
    } catch (e) {
      emit(ForgotPasswordFailure(message: e.toString()));
    }
  }
}