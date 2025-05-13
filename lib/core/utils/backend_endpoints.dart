class BackendEndpoints {
  // 👤 User endpoints
  static const String createUser = 'users'; // لإنشاء أو إضافة بيانات المستخدم
  static const String getUserData = 'users'; // لجلب بيانات المستخدم
  static const String checkUserExists = 'users/exist'; // تحقق من وجود المستخدم
  static const String updateUserProfile = 'users/updateProfile'; // تحديث بيانات المستخدم (اضافة)

  // 🛒 Product endpoints
  static const String getProducts = 'products'; // جلب المنتجات

  // 🔒 Password Reset
  static const String resetPassword = 'auth/resetPassword'; // لإعادة تعيين كلمة المرور

  // 👩‍💻 Third-party authentication (for Google, Facebook, Apple)
  static const String googleSignIn = 'auth/googleSignIn'; // تسجيل الدخول عبر Google
  static const String facebookSignIn = 'auth/facebookSignIn'; // تسجيل الدخول عبر Facebook
  static const String appleSignIn = 'auth/appleSignIn'; // تسجيل الدخول عبر Apple

  // 🔄 Sync Firebase user with backend
  static const String syncFirebaseUser = 'auth/syncFirebaseUser'; // مزامنة بيانات المستخدم من Firebase إلى backend
}
