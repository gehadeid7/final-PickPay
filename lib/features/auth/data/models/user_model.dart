import 'package:firebase_auth/firebase_auth.dart';
import 'package:pickpay/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity 
{
  UserModel({required super.fullName,required super.email, required super.uId});



// الهدف منه انه بياخد يوزر وبياخد منه البيانات اللي هو محتاجها عشان يعمل اوبجيكت من اليوزر مودل
  factory UserModel.fromFirebaseUser( User user )
  {
    return UserModel
    (
      
      fullName: user.displayName ?? '',
      email: user.email ?? '',
      uId: user.uid,
    
    
     );
  }

}


