import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/errors/failures.dart';
import 'package:pickpay/core/services/database_services.dart';
import 'package:pickpay/core/services/firebase_auth_service.dart';
import 'package:pickpay/core/services/shared_preferences_singletone.dart';
import 'package:pickpay/core/utils/backend_endpoints.dart';
import 'package:pickpay/features/auth/data/models/user_model.dart';
import 'package:pickpay/features/auth/domain/entities/user_entity.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';
import 'package:pickpay/services/api_service.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadProfileImage(String userId, File imageFile) async {
    if (!imageFile.existsSync()) {
      throw Exception('File does not exist at path: ${imageFile.path}');
    }

    final ref = _storage.ref().child('profile_images/$userId.jpg');
    final uploadTask = await ref.putFile(imageFile);
    final downloadUrl = await uploadTask.ref.getDownloadURL();
    return downloadUrl;
  }
}


class AuthRepoImplementation extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;
  final ApiService apiService;
  final FirebaseStorageService firebaseStorageService;

  AuthRepoImplementation({
    required this.databaseService,
    required this.firebaseAuthService,
    required this.apiService,
    required this.firebaseStorageService,
  });

  // ───────────────────────────────────────────────
  // 🔐 EMAIL/PASSWORD SIGNUP
  // ───────────────────────────────────────────────
  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
    String email,
    String password,
    String fullName,
  ) async {
    User? user;
    try {
      user = await firebaseAuthService.createUserWithEmailAndPassword(
        email: email,
        password: password,
        displayName: fullName,
      );
      await user.sendEmailVerification();

      final syncedUser = await apiService.syncFirebaseUserToBackend(
        name: fullName,
        email: email,
        firebaseUid: user.uid,
        photoUrl: user.photoURL
        );

      await saveUserData(user: syncedUser);

      return right(syncedUser);
    } catch (e) {
      await deleteUser(user);
      return left(ServerFailure('Signup failed: ${e.toString()}'));
    }
  }

  // ───────────────────────────────────────────────
  // 🔐 EMAIL/PASSWORD SIGNIN
  // ───────────────────────────────────────────────
  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final user = await firebaseAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!user.emailVerified) {
        await FirebaseAuth.instance.signOut();
        return left(
            ServerFailure('يرجى تأكيد بريدك الإلكتروني قبل تسجيل الدخول'));
      }

      final syncedUser = await apiService.syncFirebaseUserToBackend(
        name: user.displayName ?? '',
        email: user.email ?? '',
        firebaseUid: user.uid,
      );

      await saveUserData(user: syncedUser);
      return right(syncedUser);
    } catch (e) {
      return left(ServerFailure('Login failed: ${e.toString()}'));
    }
  }

  // ───────────────────────────────────────────────
  // 🔐 PASSWORD RESET EMAIL
  // ───────────────────────────────────────────────
  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuthService.sendPasswordResetEmail(email: email);
      return right(null);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for email: $email, but sent reset if exists.');
        return right(null);
      } else {
        return left(ServerFailure('فشل في إرسال رابط إعادة تعيين كلمة المرور: ${e.message}'));
      }
    } catch (e) {
      return left(ServerFailure('حدث خطأ غير متوقع: ${e.toString()}'));
    }
  }

  // ───────────────────────────────────────────────
  // 🔐 RESET PASSWORD (Backend)
  // ───────────────────────────────────────────────
  @override
  Future<Either<Failure, void>> resetPassword({
    required String token,
    required String password,
    required String passwordConfirm,
  }) async {
    try {
      final response = await apiService.post(
        endpoint: BackendEndpoints.resetPassword,
        body: {
          'token': token,
          'password': password,
          'passwordConfirm': passwordConfirm,
        },
      );

      if (response.statusCode == 200) return right(null);
      return left(ServerFailure('Reset password failed: ${response.body}'));
    } catch (e) {
      return left(ServerFailure('Reset password failed: ${e.toString()}'));
    }
  }

  // ───────────────────────────────────────────────
  // 🌐 GOOGLE SIGN-IN
  // ───────────────────────────────────────────────
  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithGoogle();

      final syncedUser = await apiService.syncFirebaseUserToBackend(
        name: user.displayName ?? '',
        email: user.email ?? '',
        firebaseUid: user.uid,
      );

      await saveUserData(user: syncedUser);
      return right(syncedUser);
    } catch (e) {
      await deleteUser(user);
      return left(ServerFailure('Google sign-in failed: ${e.toString()}'));
    }
  }

  // ───────────────────────────────────────────────
  // 🌐 FACEBOOK SIGN-IN
  // ───────────────────────────────────────────────
  @override
  Future<Either<Failure, UserEntity>> signInWithFacebook() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithFacebook();

      final syncedUser = await apiService.syncFirebaseUserToBackend(
        name: user.displayName ?? '',
        email: user.email ?? '',
        firebaseUid: user.uid,
      );

      await saveUserData(user: syncedUser);
      return right(syncedUser);
    } catch (e) {
      await deleteUser(user);
      return left(ServerFailure('Facebook sign-in failed: ${e.toString()}'));
    }
  }

  // ───────────────────────────────────────────────
  // 🌐 APPLE SIGN-IN
  // ───────────────────────────────────────────────
  @override
  Future<Either<Failure, UserEntity>> signInWithApple() async {
    try {
      final appleIDCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final credential = OAuthProvider('apple.com').credential(
        idToken: appleIDCredential.identityToken,
        accessToken: appleIDCredential.authorizationCode,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final syncedUser = await apiService.syncFirebaseUserToBackend(
        name: userCredential.user?.displayName ?? '',
        email: userCredential.user?.email ?? '',
        firebaseUid: userCredential.user?.uid ?? '',
      );

      await saveUserData(user: syncedUser);
      return right(syncedUser);
    } catch (e) {
      return left(ServerFailure('Apple sign-in failed: ${e.toString()}'));
    }
  }

  // ───────────────────────────────────────────────
  // 📩 SEND EMAIL VERIFICATION
  // ───────────────────────────────────────────────
  @override
  Future<Either<Failure, void>> sendEmailVerification() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        return right(null);
      } else if (user == null) {
        return left(ServerFailure('لم يتم العثور على مستخدم مسجل حاليًا'));
      } else {
        return left(ServerFailure('البريد الإلكتروني تم التحقق منه بالفعل'));
      }
    } catch (e) {
      return left(ServerFailure('فشل إرسال رابط التحقق: ${e.toString()}'));
    }
  }

  // ───────────────────────────────────────────────
  // ✔️ CHECK EMAIL VERIFIED
  // ───────────────────────────────────────────────
  @override
  Future<Either<Failure, bool>> isEmailVerified() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return right(false);
      await user.reload();
      return right(user.emailVerified);
    } catch (e) {
      return left(
          ServerFailure('فشل التحقق من البريد الإلكتروني: ${e.toString()}'));
    }
  }

  // ───────────────────────────────────────────────
  // 👤 SAVE USER DATA LOCALLY
  // ───────────────────────────────────────────────
  @override
  Future<Either<Failure, void>> saveUserData({required UserEntity user}) async {
    try {
      final jsonData = jsonEncode(UserModel.fromEntity(user).toMap());
      await Prefs.setString(kUserData, jsonData);
      return right(null);
    } catch (e) {
      return left(ServerFailure('Failed to save user data: ${e.toString()}'));
    }
  }

  // ───────────────────────────────────────────────
  // 👤 GET USER DATA FROM BACKEND
  // ───────────────────────────────────────────────
  @override
Future<Either<Failure, UserEntity>> getUserData({required String userId}) async {
  try {
    final response = await apiService.get(
      endpoint: BackendEndpoints.getUserData(userId),
    );

    if (response.statusCode != 200) {
      return left(ServerFailure(
          'Backend error ${response.statusCode}: ${response.body}'));
    }

    final data = jsonDecode(response.body);
    final userModel = UserModel.fromMap(data);
    return right(userModel);
  } catch (e) {
    return left(ServerFailure('Failed to get user data: ${e.toString()}'));
  }
}


  // ───────────────────────────────────────────────
  // 👤 UPDATE USER DATA (Including profile image upload)
  // ───────────────────────────────────────────────
@override
Future<Either<Failure, void>> updateUserData(UserEntity user) async {
  try {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      print('No logged-in user found in updateUserData');
      return left(ServerFailure('No logged-in user'));
    }

    String? photoUrl = user.photoUrl;
    print('updateUserData called for userId: ${user.uId}, photoUrl: $photoUrl');

    // Upload profile image if local path (not URL)
    if (photoUrl != null && photoUrl.isNotEmpty && !photoUrl.startsWith('http')) {
      print('Detected local image path: "$photoUrl" (length: ${photoUrl.length})');
      final file = File(photoUrl);
      final exists = await file.exists();
      print('File exists: $exists');
      if (!exists) {
        print('Error: File does NOT exist at path: $photoUrl');
        return left(ServerFailure('صورة الملف غير موجودة في المسار المحدد: $photoUrl'));
      }
      
      final uploadResult = await uploadProfileImage(currentUser.uid, file);
      
      final updatedPhotoUrlOrFailure = uploadResult.fold<Either<Failure, String>>(
        (failure) {
          print('Image upload failed in updateUserData: ${failure.message}');
          return left(failure); // إرجاع الخطأ بدون رمي استثناء
        },
        (url) {
          print('Profile image uploaded. New URL: $url');
          photoUrl = url;
          return right(url);
        },
      );
      
      if (updatedPhotoUrlOrFailure.isLeft()) {
        return left(updatedPhotoUrlOrFailure.swap().getOrElse(() => ServerFailure('فشل رفع الصورة')));
      }
    } else {
      print('No need to upload profile image. Using existing URL or empty path.');
    }

    print('Updating FirebaseAuth profile with displayName: ${user.fullName}, photoUrl: $photoUrl');
    await currentUser.updateDisplayName(user.fullName);
    if (photoUrl != null) {
      await currentUser.updatePhotoURL(photoUrl);
    }
    await currentUser.reload();

    print('Updating backend profile for userId: ${user.uId}');
    final updatedUser = UserEntity(
      uId: user.uId,
      email: user.email,
      fullName: user.fullName,
      emailVerified: user.emailVerified,
      photoUrl: photoUrl,
    );
    final idToken = await currentUser.getIdToken();
    final response = await apiService.put(
      endpoint: BackendEndpoints.updateMe,
      body: UserModel.fromEntity(updatedUser).toMap(),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print('Backend profile updated successfully.');
      await saveUserData(user: updatedUser);
      return right(null);
    } else {
      print('Backend profile update failed with status ${response.statusCode}: ${response.body}');
      return left(ServerFailure('فشل تحديث البيانات: ${response.body}'));
    }
  } catch (e, stacktrace) {
    print('Exception in updateUserData: ${e.toString()}');
    print(stacktrace);
    return left(ServerFailure('فشل تحديث البيانات: ${e.toString()}'));
  }
}


  @override
  Future<Either<Failure, void>> addUserData({required UserEntity user}) async {
    return right(null);
  }

  // ───────────────────────────────────────────────
  // 🚪 SIGN OUT
  // ───────────────────────────────────────────────
  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await firebaseAuthService.signOut();
      await Prefs.remove(kUserData);
      return right(null);
    } catch (e) {
      return left(ServerFailure('Sign out failed: ${e.toString()}'));
    }
  }

  // ───────────────────────────────────────────────
  // ✅ CHECK IF USER LOGGED IN
  // ───────────────────────────────────────────────
  @override
  Future<Either<Failure, bool>> isUserLoggedIn() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      return right(user != null);
    } catch (e) {
      return left(ServerFailure('فشل التحقق من تسجيل الدخول: ${e.toString()}'));
    }
  }

  // ───────────────────────────────────────────────
  // 👤 GET CURRENT USER
  // ───────────────────────────────────────────────
  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
    final user = firebaseAuthService.getCurrentUser();
      if (user == null) return left(ServerFailure('No user logged in'));
      final syncedUser = await apiService.syncFirebaseUserToBackend(
        name: user.displayName ?? '',
        email: user.email ?? '',
        firebaseUid: user.uid,
      );
      return right(syncedUser);
    } catch (e) {
      return left(ServerFailure('Failed to get current user: ${e.toString()}'));
    }
  }

  // ───────────────────────────────────────────────
  // 🗑️ DELETE USER ACCOUNT
  // ───────────────────────────────────────────────
  @override
  Future<Either<Failure, void>> deleteUser(User? user) async {
    if (user == null) return right(null);
    try {
      await user.delete();
      await Prefs.remove(kUserData);
      return right(null);
    } catch (e) {
      return left(ServerFailure('Failed to delete user: ${e.toString()}'));
    }
  }
  
@override
Future<Either<Failure, bool>> checkUserExists(String email) async {
  try {
    // Check sign-in methods from Firebase Auth
    final methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
    print('Firebase methods: $methods'); // Debug print

    if (methods.isNotEmpty) return right(true);

    // Check if user exists in backend
    final response = await apiService.post(
      endpoint: BackendEndpoints.checkUserExists,
      body: {'email': email},
    );

    print('Backend response: ${response.body}'); // Debug print

    final data = jsonDecode(response.body);
    return right(data['exists'] == true);
  } catch (e) {
    print('Error in checkUserExists: ${e.toString()}');
    return left(ServerFailure('فشل التحقق من وجود المستخدم: ${e.toString()}'));
  }
}
@override
Future<Either<Failure, String>> uploadProfileImage(String userId, File image) async {
  try {
    if (!image.existsSync()) {
      print('❌ File does not exist at path: ${image.path}');
      return left(ServerFailure('File does not exist at path: ${image.path}'));
    }

    print('📤 Uploading image from path: ${image.path}');

    final streamedResponse = await apiService.uploadImage(
      endpoint: BackendEndpoints.uploadUserPhoto,
      imageFile: image,
      fields: {'userId': userId},
      authorized: true,
    );

    final response = await http.Response.fromStream(streamedResponse);

    print('✅ Upload response status: ${response.statusCode}');
    print('✅ Upload response body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final imageUrl = responseData['profileImgUrl'];
      print('🌐 Received imageUrl: $imageUrl');

      if (imageUrl == null) {
        print('❌ Error: Backend did not return image URL');
        return left(ServerFailure('Backend did not return image URL'));
      }

      return right(imageUrl);
    } else {
      print('❌ Upload failed with status ${response.statusCode}: ${response.body}');
      return left(ServerFailure('Upload failed with status ${response.statusCode}: ${response.body}'));
    }
  } catch (e) {
    print('❌ Exception during image upload: ${e.toString()}');
    return left(ServerFailure('Failed to upload profile image: ${e.toString()}'));
  }
}

Future<Either<Failure, UserModel>> uploadProfileImageAndUpdate(File image) async {
  try {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print('❌ No authenticated user found');
      return left(ServerFailure('No authenticated user found'));
    }

    print('👤 Authenticated user ID: ${user.uid}');
    print('📤 Starting image upload...');

    final uploadResult = await uploadProfileImage(user.uid, image);

    return await uploadResult.fold(
      (failure) {
        print('❌ Image upload failed: ${failure.message}');
        return left(failure);
      },
      (imageUrlOrFilename) async {
        print('✅ Image uploaded successfully. URL: $imageUrlOrFilename');

        final Map<String, dynamic> body = {
          'profileImg': imageUrlOrFilename,
          // 'email': user.email ?? '',
          'displayName': user.displayName ?? '',
        };

        final updateResponse = await apiService.put(
          endpoint: BackendEndpoints.updateMe,
          body: body,
          authorized: true,
        );

        print('🔄 Profile update response status: ${updateResponse.statusCode}');
        print('🔄 Profile update response body: ${updateResponse.body}');

        if (updateResponse.statusCode == 200) {
          final data = jsonDecode(updateResponse.body)['data'];
          final updatedUser = UserModel.fromJson(data);
          print('✅ Profile updated successfully');
          return right(updatedUser);
        } else {
          print('❌ Profile update failed: ${updateResponse.body}');
          return left(ServerFailure('Profile update failed: ${updateResponse.body}'));
        }
      },
    );
  } catch (e) {
    print('❌ Unexpected error during profile update: ${e.toString()}');
    return left(ServerFailure('Unexpected error: ${e.toString()}'));
  }
}
@override
Future<Either<Failure, bool>> checkIfImageExists(String imageUrl) async {
  try {
    final fileName = Uri.parse(imageUrl).pathSegments.last;
    print('🔍 checkIfImageExists ➜ fileName: $fileName');

    final response = await apiService.post(
      endpoint: BackendEndpoints.checkImageExists,
      body: {'fileName': fileName},
      authorized: true,                 // أضف التوكن إذا كان المسار محميًّا
    );

    print('🔍 Response ${response.statusCode}: ${response.body}');

    if (response.statusCode != 200) {
      return left(ServerFailure(
          'فشل التحقق من وجود الصورة: ${response.statusCode} – ${response.body}'));
    }

    final data = jsonDecode(response.body);
    final exists = data['exists'] == true;
    return right(exists);
  } catch (e) {
    print('❌ Exception in checkIfImageExists: $e');
    return left(ServerFailure('فشل التحقق من وجود الصورة: ${e.toString()}'));
  }
}

}