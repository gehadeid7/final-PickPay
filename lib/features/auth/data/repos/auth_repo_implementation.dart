import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pickpay/core/errors/exceptions.dart';
import 'package:pickpay/core/errors/failures.dart';
import 'package:pickpay/core/services/firebase_auth_service.dart';
import 'package:pickpay/features/auth/data/models/user_model.dart';
import 'package:pickpay/features/auth/domain/entities/user_entity.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImplementation extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;

  AuthRepoImplementation({required this.firebaseAuthService});
  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      String email, String password, String fullName) async {
    User? user;
    try {
      user = await firebaseAuthService.createUserWithEmailAndPassword(
          email: email, password: password);

      return right(
        UserModel.fromFirebaseUser(user),
      );
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log(
        'Exception in AuthRepoImpl.createUserWithEmailAndPassword: ${e.toString()}',
      );
      return left(
        ServerFailure(
          'Unexpected error occurred: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      var user = await firebaseAuthService.signInWithEmailAndPassword(
          email: email, password: password);
      return right(
        UserModel.fromFirebaseUser(user),
      );
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log(
        'Exception in AuthRepoImpl.createUserWithEmailAndPassword: ${e.toString()}',
      );
      return left(
        ServerFailure(
          'try again',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>>signInWithGoogle() async {
    try {
      var user = await firebaseAuthService.signInWithGoogle();
      return right(
        UserModel.fromFirebaseUser(user),
      );
    }  catch (e) {
      log(
        'Exception in AuthRepoImplementaion.signinWithGoogle : ${e.toString()}',
      );
      return left(
        ServerFailure('try again')
      );
    }
  }


   @override
  Future<Either<Failure, UserEntity>>signInWithFacebook() async {
    try {
      var user = await firebaseAuthService.signInWithFacebook();
      return right(
        UserModel.fromFirebaseUser(user),
      );
    }  catch (e) {
      log(
        'Exception in AuthRepoImplementaion.signinWithGoogle : ${e.toString()}',
      );
      return left(
        ServerFailure('try again')
      );
    }
  }
}














// class BackendAuthRepoImplement extends AuthRepo {
//   @override
//   Future<Either<Failures, UserEntity>> createUserWithEmailAndPassword(
//       String email, String password, String name) {
// // TODO: implement createUserWithEmailAndPassword
//     throw UnimplementedError();
//   }
// }
