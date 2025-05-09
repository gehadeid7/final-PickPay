import 'package:dartz/dartz.dart';
import 'package:pickpay/core/errors/failures.dart';
import 'package:pickpay/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, bool>> checkUserExists(String email);
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
    String email,
    String password,
    String fullName,
  );

  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  );

  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future<Either<Failure, UserEntity>> signInWithFacebook();


  Future addUserData({required UserEntity user});
  Future saveUserData({required UserEntity user});

  Future<UserEntity> getUserData({required String userId});
 Future<Either<Failure, void>> sendPasswordResetEmail(String email); 
  Future<Either<Failure, void>> sendEmailVerification();


 
}
