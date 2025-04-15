import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pickpay/core/errors/exceptions.dart';
import 'package:pickpay/core/errors/failures.dart';
import 'package:pickpay/core/services/database_services.dart';
import 'package:pickpay/core/services/firebase_auth_service.dart';
import 'package:pickpay/core/utils/backend_endpoints.dart';
import 'package:pickpay/features/auth/data/models/user_model.dart';
import 'package:pickpay/features/auth/domain/entities/user_entity.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImplementation extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;

  AuthRepoImplementation(
      {required this.databaseService, required this.firebaseAuthService});
  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      String email, String password, String fullName) async {
    User? user;
    try {
      user = await firebaseAuthService.createUserWithEmailAndPassword(
          email: email, password: password);

      var userEntity =
          UserEntity(fullName: fullName, email: email, uId: user.uid);

      await addUserData(user: userEntity);

      return right(userEntity);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      await deleteUser(user);
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

  Future<void> deleteUser(User? user) async {
    if (user != null) {
      await firebaseAuthService.deleteUser();
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      var user = await firebaseAuthService.signInWithEmailAndPassword(
          email: email, password: password);

      var userEntity = await getUserData(userId: user.uid);

      return right(userEntity);
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
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithGoogle();

      var userEntity = UserModel.fromFirebaseUser(user);

      var isUserExist = await databaseService.ckeckIfDataExists(
          path: BackendEndpoints.isUserExists, documentId: user.uid);

      if (isUserExist) {
        await getUserData(userId: user.uid);
      } else {
        await addUserData(user: userEntity);
      }

      return right(userEntity);
    } catch (e) {
      await deleteUser(user);
      log(
        'Exception in AuthRepoImplementaion.signinWithGoogle : ${e.toString()}',
      );
      return left(ServerFailure('try again'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithFacebook() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithFacebook();

      var userEntity = UserModel.fromFirebaseUser(user);

      var isUserExist = await databaseService.ckeckIfDataExists(
          path: BackendEndpoints.isUserExists, documentId: user.uid);

      if (isUserExist) {
        await getUserData(userId: user.uid);
      } else {
        await addUserData(user: userEntity);
      }

      return right(userEntity);
    } catch (e) {
      await deleteUser(user);
      log(
        'Exception in AuthRepoImplementaion.signinWithGoogle : ${e.toString()}',
      );
      return left(ServerFailure('try again'));
    }
  }

  @override
  Future addUserData({required UserEntity user}) async {
    try {
      await databaseService.addData(
        path: BackendEndpoints.addUserData,
        data: user.toMap(),
        documentId: user.uId,
      );
    } catch (e) {
      throw CustomException(message: 'something wrong happened');
    }
  }

  @override
  Future<UserEntity> getUserData({required String userId}) async {
    var userData = await databaseService.getData(
        path: BackendEndpoints.getUserData, documentId: userId);
    return UserModel.fromJson(userData);
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
