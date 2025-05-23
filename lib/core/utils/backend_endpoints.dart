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


  // For individual product CRUD
  static String getProductById(String id) => 'products/$id';
  static String updateProductById(String id) => 'products/$id';
  static String deleteProductById(String id) => 'products/$id';

  // Product images upload and resizing (usually part of create/update but you can add if you call separately)
  static String uploadProductImages(String id) => 'products/$id/uploadImages';
  static String resizeProductImages(String id) => 'products/$id/resizeImages';

  // AI Search for products
  static const String searchProductsAI = 'products/search';

  // Reviews sub-route under a product
  static String getReviewsForProduct(String productId) => 'products/$productId/reviews';

  // 🔒 Password Reset
  static const String resetPassword = 'auth/resetPassword';
  static const String forgotPassword = 'auth/forgotPassword';

  // 👩‍💻 Third-party authentication
  static const String googleSignIn = 'auth/googleSignIn';
  static const String facebookSignIn = 'auth/facebookSignIn';
  static const String appleSignIn = 'auth/appleSignIn';

  // 🔄 Sync Firebase user with backend
  static const String syncFirebaseUser = 'auth/syncFirebaseUser';

   // ❤️ Wishlist endpoints
  static const String wishlist = 'wishlist';
  static String removeFromWishlist(String productId) => 'wishlist/$productId';
}
