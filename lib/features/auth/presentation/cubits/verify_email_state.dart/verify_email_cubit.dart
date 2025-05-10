import 'package:bloc/bloc.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';
import 'package:get_it/get_it.dart';

part 'verify_email_state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  final AuthRepo authRepo;

  VerifyEmailCubit()
      : authRepo = GetIt.I<AuthRepo>(),
        super(VerifyEmailInitial());

  Future<void> sendVerificationEmail() async {
    emit(VerifyEmailLoading());
    final result = await authRepo.sendEmailVerification();

    result.fold(
      (failure) => emit(VerifyEmailFailure(failure.message)),
      (_) => emit(VerifyEmailSuccess()),
    );
  }
}
