import 'package:bloc/bloc.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';
import 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitial());

  final AuthRepo authRepo;

  Future<void> createUserWithEmailAndPassword(
      String email, String password, String fullName) async {
    emit(SignupLoading());
    final result = await authRepo.createUserWithEmailAndPassword(
        email, password, fullName);
    result.fold(
        (Failures) => emit(SignupFailure(message: Failures.message)), 
        
        (UserEntity) => emit(SignupSuccess(userEntity: UserEntity)),
        
        );
  }
}
