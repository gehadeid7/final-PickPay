//  entity used to represent user data regardless of the service used.

class UserEntity {
  final String firstName;
  final String lastName;
  final String email;
  final String uId;

  UserEntity({required this.firstName, required this.lastName, required this.email, required this.uId});
}
