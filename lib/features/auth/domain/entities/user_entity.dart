class UserEntity {
  final String fullName;
  final String email;
  final String uId;
  final bool emailVerified; // Add emailVerified field

  UserEntity({
    required this.fullName,
    required this.email,
    required this.uId,
    required this.emailVerified, // Pass emailVerified as a required parameter
  });
}
