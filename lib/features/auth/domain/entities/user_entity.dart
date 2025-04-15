//  entity used to represent user data regardless of the service used.

class UserEntity {
  final String fullName;
  final String email;
  final String uId;

  UserEntity({required this.fullName, required this.email, required this.uId});



  toMap() {
    return {
      'fullName': fullName, 
      'email': email, 
      'uId': uId
      };
  }
}
