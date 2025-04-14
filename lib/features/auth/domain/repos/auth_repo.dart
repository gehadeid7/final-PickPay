import 'package:dartz/dartz.dart';
import 'package:pickpay/core/errors/failures.dart';
import 'package:pickpay/features/auth/domain/entities/user_entity.dart';


abstract class AuthRepo {
  Future<Either<Failure, UserEntity>>createUserWithEmailAndPassword(
    String email,
    String password,
    String fullName,
   
  );



   Future<Either<Failure, UserEntity>>signInWithEmailAndPassword(
    String email,
    String password,
   
  );

   Future<Either<Failure, UserEntity>>signInWithGoogle(
   
  );
}
