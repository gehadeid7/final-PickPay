import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pickpay/features/auth/domain/entities/user_entity.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final AuthRepo authRepo;

  // لمنع عمليات تسجيل دخول متزامنة
  bool _isProcessing = false;

  SigninCubit(this.authRepo) : super(const SigninInitial());

  // تسجيل دخول بالبريد وكلمة المرور
  Future<void> signin(String email, String password) async {
    if (_isProcessing) return; // إذا هناك طلب جاري، لا ننفذ آخر
    _isProcessing = true;
    emit(const SigninLoading());

    final result = await authRepo.signInWithEmailAndPassword(email, password);
    result.fold(
      (failure) => emit(SigninFailure(message: failure.message)),
      (userEntity) => emit(SigninSuccess(userEntity: userEntity)),
    );

    _isProcessing = false;
  }

  // تسجيل دخول عبر Google
  Future<void> signInWithGoogle() async {
    if (_isProcessing) return;
    _isProcessing = true;
    emit(const SigninLoading());

    final result = await authRepo.signInWithGoogle();
    result.fold(
      (failure) => emit(SigninFailure(message: failure.message)),
      (userEntity) => emit(SigninSuccess(userEntity: userEntity)),
    );

    _isProcessing = false;
  }

  // تسجيل دخول عبر Facebook
  Future<void> signInWithFacebook() async {
    if (_isProcessing) return;
    _isProcessing = true;
    emit(const SigninLoading());

    final result = await authRepo.signInWithFacebook();
    result.fold(
      (failure) => emit(SigninFailure(message: failure.message)),
      (userEntity) => emit(SigninSuccess(userEntity: userEntity)),
    );

    _isProcessing = false;
  }

  // إعادة الحالة الأولية (يمكن استخدامها لإعادة تعيين الحالة)
  void reset() {
    emit(const SigninInitial());
  }
}
