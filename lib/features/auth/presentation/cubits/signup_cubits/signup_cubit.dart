import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/app_flushbar.dart';
import 'package:pickpay/features/auth/domain/entities/user_entity.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitial());

  final AuthRepo authRepo;

  Future<void> createUserWithEmailAndPassword(
      String email, String password, String name, BuildContext context) async {
    emit(SignupLoading());

    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      // Handle case: user is signed in but not verified
      if (currentUser != null && currentUser.email == email) {
        await currentUser.reload(); // Reload user data
        if (!currentUser.emailVerified) {
          AppFlushbar.showError(
              context, 'يرجى تأكيد بريدك الإلكتروني قبل تسجيل الدخول');
          emit(SignupFailure(
              message: 'يرجى تأكيد بريدك الإلكتروني قبل تسجيل الدخول'));
          return;
        } else {
          AppFlushbar.showSuccess(context, 'تم تسجيل الدخول بنجاح');
          emit(SignupSuccess(
              userEntity: UserEntity.fromFirebaseUser(currentUser)));
          return;
        }
      }

      // Check if user already exists in backend
      final existsResult = await authRepo.checkUserExists(email);
      if (existsResult.isLeft()) {
        final message = existsResult.fold(
            (f) => f.message, (_) => 'حدث خطأ أثناء التحقق من المستخدم');
        AppFlushbar.showError(context, message);
        emit(SignupFailure(message: message));
        return;
      }

      final userExists = existsResult.getOrElse(() => false);
      if (userExists) {
        AppFlushbar.showError(context, 'هذا البريد الإلكتروني مستخدم بالفعل');
        emit(SignupFailure(message: 'هذا البريد الإلكتروني مستخدم بالفعل'));
        return;
      }

      // Proceed with sign-up
      final result =
          await authRepo.createUserWithEmailAndPassword(email, password, name);
      result.fold(
        (failure) {
          AppFlushbar.showError(context, failure.message);
          emit(SignupFailure(message: failure.message));
        },
        (userEntity) {
          AppFlushbar.showSuccess(context, 'تم تسجيل حسابك بنجاح');
          emit(SignupSuccess(userEntity: userEntity));
        },
      );
    } catch (e) {
      AppFlushbar.showError(context, 'فشل غير متوقع: ${e.toString()}');
      emit(SignupFailure(message: 'فشل غير متوقع: ${e.toString()}'));
    }
  }

  Future<bool> checkIfUserExists(String email) async {
    final result = await authRepo.checkUserExists(email);
    return result.fold((_) => false, (exists) => exists);
  }

  void resetState() => emit(SignupInitial());
}
