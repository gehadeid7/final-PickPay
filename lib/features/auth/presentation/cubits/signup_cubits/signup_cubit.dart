import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pickpay/features/auth/domain/entities/user_entity.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart'; // To check current user

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitial());

  final AuthRepo authRepo;

  // Create User
  Future<void> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    emit(SignupLoading());

    // Check if a user is already signed in and if their email is verified
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      if (currentUser.emailVerified) {
        // If the user is already signed in and email is verified, emit success with the current user
        emit(SignupSuccess(userEntity: UserEntity.fromFirebaseUser(currentUser)));
        return;
      } else {
        // If email is not verified, ask user to verify
        emit(SignupFailure(message: 'يرجى تأكيد بريدك الإلكتروني قبل تسجيل الدخول'));
        return;
      }
    }

    // Check if user already exists
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

    // Proceed with user creation if not existing
    final result =
        await authRepo.createUserWithEmailAndPassword(email, password, name);
    result.fold(
      (failure) => emit(SignupFailure(message: failure.message)),
      (userEntity) => emit(SignupSuccess(userEntity: userEntity)),
    );
  }

  // Check if User Exists
  Future<bool> checkIfUserExists(String email) async {
    try {
      final result = await authRepo.checkUserExists(email);
      return result.fold(
        (failure) {
          // Handle failure, user doesn't exist
          return false;
        },
        (exists) {
          // Return whether the user exists
          return exists;
        },
      );
    } catch (e) {
      // Handle any exception and return false (user does not exist)
      return false;
    }
  }
}
