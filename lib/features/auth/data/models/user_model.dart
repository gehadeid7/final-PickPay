import 'package:firebase_auth/firebase_auth.dart';
import 'package:pickpay/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity 
{
  UserModel({required super.firstName, required super.lastName, required super.email, required super.uId});



// الهدف منه انه بياخد يوزر وبياخد منه البيانات اللي هو محتاجها عشان يعمل اوبجيكت من اليوزر مودل
  factory UserModel.fromFirebaseUser( User user )
  {
    return UserModel
    (
      firstName: user.displayName ?? '',
      lastName: user.displayName ?? '',
      email: user.email ?? '',
      uId: user.uid,
    
    
     );
  }

}


