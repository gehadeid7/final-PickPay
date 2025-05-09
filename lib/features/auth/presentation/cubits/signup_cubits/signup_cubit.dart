import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pickpay/features/auth/domain/entities/user_entity.dart';

import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';



part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitial());

  final AuthRepo authRepo;

  Future<void> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    emit(SignupLoading());

  final existsResult = await authRepo.checkUserExists(email);
    if (existsResult.isLeft()) {
      emit(SignupFailure(message: existsResult.fold((f) => f.message, (_) => 'حدث خطأ')));
      return;
    }

    final userExists = existsResult.getOrElse(() => false);
    if (userExists) {
      emit(SignupFailure(message: 'هذا البريد الإلكتروني مستخدم بالفعل'));
      return;
    }

    final result =
        await authRepo.createUserWithEmailAndPassword(email, password, name);
    result.fold(
      (failure) => emit(
        SignupFailure(message: failure.message),
      ),
      (userEntity) => emit(
        SignupSuccess(userEntity: userEntity),
      ),
    );
  }
}
