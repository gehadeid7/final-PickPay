class BackendEndpoints {
  // 👤 User endpoints
  static const String createUser = 'users';
  static String getUserData(String userId) => 'users/$userId';
  static const String checkUserExists = 'users/exist';
  static const String updateMe = 'users/updateMe';
  static const String uploadUserPhoto = 'users/uploadPhoto';
  static const String checkImageExists = 'users/check-image-exists';
  static const String getMe = 'users/getMe';

  // 🛒 Product endpoints
  static const String getProducts = 'products';
  static const String aiProductSearch = 'products/search';


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
