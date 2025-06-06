import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pickpay/features/auth/domain/entities/user_entity.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitial());

  final AuthRepo authRepo;

  Future<void> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    emit(SignupLoading());

    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null && currentUser.email == email) {
        await currentUser.reload();
        if (!currentUser.emailVerified) {
          emit(SignupFailure(
              message: 'يرجى تأكيد بريدك الإلكتروني قبل تسجيل الدخول'));
          return;
        } else {
          emit(SignupSuccess(
              userEntity: UserEntity.fromFirebaseUser(currentUser),
              successMessage: 'تم تسجيل الدخول بنجاح'));
          return;
        }
      }

      final existsResult = await authRepo.checkUserExists(email);
      if (existsResult.isLeft()) {
        final message = existsResult.fold(
            (f) => f.message, (_) => 'حدث خطأ أثناء التحقق من المستخدم');
        emit(SignupFailure(message: message));
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
        (failure) => emit(SignupFailure(message: failure.message)),
        (userEntity) => emit(SignupSuccess(
          userEntity: userEntity,
          successMessage: 'تم تسجيل حسابك بنجاح',
        )),
      );
    } catch (e) {
      emit(SignupFailure(message: 'فشل غير متوقع: ${e.toString()}'));
    }
  }

  Future<bool> checkIfUserExists(String email) async {
    final result = await authRepo.checkUserExists(email);
    return result.fold((_) => false, (exists) => exists);
  }

  void resetState() => emit(SignupInitial());
}
