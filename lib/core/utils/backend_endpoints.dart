class BackendEndpoints {
  // 👤 User endpoints
  static const String createUser = 'users';
  static String getUserData(String userId) => 'users/$userId';
  static const String checkUserExists = 'users/exist';
  static String updateUserProfile(String userId) => 'users/$userId/updateProfile';

  // 🛒 Product endpoints
  static const String getProducts = 'products';

  // 🔒 Password Reset
  static const String resetPassword = 'auth/resetPassword';
  static const String forgotPassword = 'auth/forgotPassword';

  // 👩‍💻 Third-party authentication
  static const String googleSignIn = 'auth/googleSignIn';
  static const String facebookSignIn = 'auth/facebookSignIn';
  static const String appleSignIn = 'auth/appleSignIn';

  // 🔄 Sync Firebase user with backend
  static const String syncFirebaseUser = 'auth/syncFirebaseUser';
}
