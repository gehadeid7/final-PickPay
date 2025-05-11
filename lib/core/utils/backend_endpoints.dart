class BackendEndpoints {
  // 👤 User endpoints
  static const String createUser = 'users'; // لإنشاء أو إضافة بيانات المستخدم
  static const String getUserData = 'users'; // لجلب بيانات المستخدم
  static const String checkUserExists = 'users/exist'; // تحقق من وجود المستخدم

  // 🛒 Product endpoints
  static const String getProducts = 'products'; // جلب المنتجات

  // 🔒 Password Reset
  static const String resetPassword = 'auth/resetPassword'; // لإعادة تعيين كلمة المرور
}
