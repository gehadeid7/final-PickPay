import 'package:dartz/dartz.dart';
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
  Future<Either<Failures, UserEntity>> createUserWithEmailAndPassword(
      String email, 
      String password, 
      String fullName ) async {
    try {
      var user = await firebaseAuthService.createUserWithEmailAndPassword(
          email: email, password: password);
      return right(
        UserModel.fromFirebaseUser(user),
      );
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(
        ServerFailure(
          message: e.toString(),
        ),
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
