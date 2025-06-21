import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/errors/failures.dart';
import 'package:pickpay/core/services/database_services.dart';
import 'package:pickpay/core/services/firebase_auth_service.dart';
import 'package:pickpay/core/services/shared_preferences_singletone.dart'
    show Prefs;
import 'package:pickpay/core/utils/backend_endpoints.dart';
import 'package:pickpay/features/auth/data/models/user_model.dart';
import 'package:pickpay/features/auth/domain/entities/user_entity.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/services/api_service.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthRepoImplementation extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;
  final ApiService apiService;

  AuthRepoImplementation({
    required this.databaseService,
    required this.firebaseAuthService,
    required this.apiService,
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
          photoUrl: user.photoURL);

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
        return right(null);
      } else {
        return left(ServerFailure(
            'فشل في إرسال رابط إعادة تعيين كلمة المرور: ${e.message}'));
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
      await Prefs.saveUser(UserModel.fromEntity(user));
      return right(null);
    } catch (e) {
      return left(ServerFailure('Failed to save user data: ${e.toString()}'));
    }
  }

  // ───────────────────────────────────────────────
  // 👤 GET USER DATA FROM BACKEND
  // ───────────────────────────────────────────────
  @override
  Future<Either<Failure, UserEntity>> getUserData(
      {required String userId}) async {
    try {
      final response = await apiService.get(
        endpoint: BackendEndpoints.getMe,
        authorized: true,
      );

      if (response.statusCode != 200) {
        return left(ServerFailure(
            'Backend error ${response.statusCode}: ${response.body}'));
      }

      final responseData = jsonDecode(response.body);

      if (!responseData.containsKey('data')) {
        return left(
            ServerFailure('Invalid response format: missing data field'));
      }

      final userData = responseData['data'];

      final userModel = UserModel.fromJson(userData);

      await Prefs.saveUser(userModel);

      return right(userModel);
    } catch (e, stack) {
      return left(ServerFailure('Failed to get user data: ${e.toString()}'));
    }
  }

  // ───────────────────────────────────────────────
  // 👤 UPDATE USER DATA (Including profile image upload)
  // ───────────────────────────────────────────────
  @override
  Future<Either<Failure, void>> updateUserData(
    UserEntity user, {
    Map<String, dynamic>? requestBody,
  }) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        return left(ServerFailure('No logged-in user'));
      }

      String? photoUrl = user.photoUrl;

      if (photoUrl != null &&
          photoUrl.isNotEmpty &&
          !photoUrl.startsWith('http')) {
        final file = File(photoUrl);
        final exists = await file.exists();
        if (!exists) {
          return left(ServerFailure(
              'صورة الملف غير موجودة في المسار المحدد: $photoUrl'));
        }

        final uploadResult = await uploadProfileImage(currentUser.uid, file);

        final updatedPhotoUrlOrFailure =
            uploadResult.fold<Either<Failure, String>>(
          (failure) {
            return left(failure);
          },
          (url) {
            photoUrl = url;
            return right(url);
          },
        );

        if (updatedPhotoUrlOrFailure.isLeft()) {
          return left(updatedPhotoUrlOrFailure
              .swap()
              .getOrElse(() => ServerFailure('فشل رفع الصورة')));
        }
      }

      await currentUser.updateDisplayName(user.fullName);
      if (photoUrl != null) {
        await currentUser.updatePhotoURL(photoUrl);
      }
      await currentUser.reload();

      final idToken = await currentUser.getIdToken();

      final Map<String, dynamic> finalRequestBody = {
        'fullName': user.fullName,
        'email': user.email,
        'phone': user.phone,
        'gender': user.gender,
        'dob': user.dob,
        'age': user.age,
        'address': user.address,
        if (photoUrl != null)
          'profileImg':
              photoUrl!.contains('/') ? photoUrl!.split('/').last : photoUrl,
      };

      if (requestBody != null) {
        finalRequestBody.addAll(requestBody);
      }

      final response = await apiService.put(
        endpoint: BackendEndpoints.updateMe,
        body: finalRequestBody,
        headers: {
          'Authorization': 'Bearer $idToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        try {
          final responseData = jsonDecode(response.body);
          if (responseData.containsKey('data')) {
            final userData = responseData['data'];
            final updatedUser = UserModel.fromJson(userData);
            await Prefs.saveUser(updatedUser);
          } else {
            await Prefs.saveUser(UserModel.fromEntity(user));
          }
        } catch (e) {
          await Prefs.saveUser(UserModel.fromEntity(user));
        }

        return right(null);
      } else {
        return left(ServerFailure('فشل تحديث البيانات: ${response.body}'));
      }
    } catch (e, stack) {
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
      await Prefs.remove(kCartData);
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
      final methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

      if (methods.isNotEmpty) return right(true);

      final response = await apiService.post(
        endpoint: BackendEndpoints.checkUserExists,
        body: {'email': email},
      );

      final data = jsonDecode(response.body);
      return right(data['exists'] == true);
    } catch (e) {
      return left(
          ServerFailure('فشل التحقق من وجود المستخدم: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfileImage(
      String userId, File image) async {
    try {
      if (!image.existsSync()) {
        return left(
            ServerFailure('File does not exist at path: ${image.path}'));
      }

      final streamedResponse = await apiService.uploadImage(
        endpoint: BackendEndpoints.uploadUserPhoto,
        imageFile: image,
        fields: {'userId': userId},
        authorized: true,
      );

      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        final profileImg = responseData['profileImg'];
        if (profileImg == null || profileImg.isEmpty) {
          return left(ServerFailure('Backend did not return profileImg'));
        }

        String fullImageUrl = responseData['profileImgUrl'];
        if (fullImageUrl == null || fullImageUrl.isEmpty) {
          final baseUrl = ApiService.baseUrl
              .replaceAll('/api/v1/', '')
              .replaceAll(RegExp(r'/$'), '');
          fullImageUrl = '$baseUrl/uploads/users/$profileImg';
        }

        return right(fullImageUrl);
      } else {
        return left(ServerFailure(
            'Upload failed with status ${response.statusCode}: ${response.body}'));
      }
    } catch (e, stack) {
      return left(
          ServerFailure('Failed to upload profile image: ${e.toString()}'));
    }
  }

  Future<Either<Failure, UserEntity>> uploadProfileImageAndUpdate(
      File image) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return left(ServerFailure('No authenticated user found'));
      }

      final ext = image.path.split('.').last.toLowerCase();
      if (!['jpg', 'jpeg', 'png'].contains(ext)) {
        return left(
            ServerFailure('Invalid image format. Please use JPG or PNG.'));
      }

      final uploadResult = await uploadProfileImage(user.uid, image);

      return await uploadResult.fold(
        (failure) {
          return left(failure);
        },
        (imageUrl) async {
          final currentUserResponse = await apiService.get(
            endpoint: BackendEndpoints.getMe,
            authorized: true,
          );

          if (currentUserResponse.statusCode != 200) {
            return left(ServerFailure('Failed to get current user data'));
          }

          final currentUserData = jsonDecode(currentUserResponse.body);
          final currentUser = UserModel.fromJson(currentUserData['data']);

          String profileImg = imageUrl;
          if (imageUrl.contains('/')) {
            profileImg = imageUrl.split('/').last;
          }

          final updateResponse = await apiService.put(
            endpoint: BackendEndpoints.updateMe,
            body: {
              'profileImg': profileImg, // Send only the filename
            },
            authorized: true,
          );

          if (updateResponse.statusCode == 200) {
            final updateData = jsonDecode(updateResponse.body);
            final fullImageUrl = updateData['data']['profileImg'];

            await user.updatePhotoURL(fullImageUrl);
            await user.reload();

            final updatedUser = UserEntity(
              uId: currentUser.uId,
              email: currentUser.email,
              fullName: currentUser.fullName,
              emailVerified: currentUser.emailVerified,
              photoUrl: fullImageUrl,
              phone: currentUser.phone,
              gender: currentUser.gender,
              dob: currentUser.dob,
              age: currentUser.age,
              address: currentUser.address,
            );

            await saveUserData(user: updatedUser);
            return right(updatedUser);
          } else {
            return left(
                ServerFailure('Profile update failed: ${updateResponse.body}'));
          }
        },
      );
    } catch (e, stack) {
      return left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> checkIfImageExists(String imageUrl) async {
    try {
      final fileName = Uri.parse(imageUrl).pathSegments.last;

      final response = await apiService.post(
        endpoint: BackendEndpoints.checkImageExists,
        body: {'fileName': fileName},
        authorized: true,
      );

      if (response.statusCode != 200) {
        return left(ServerFailure(
            'فشل التحقق من وجود الصورة: ${response.statusCode} – ${response.body}'));
      }

      final data = jsonDecode(response.body);
      final exists = data['exists'] == true;
      return right(exists);
    } catch (e) {
      return left(ServerFailure('فشل التحقق من وجود الصورة: ${e.toString()}'));
    }
  }

  Future<Either<Failure, ProductsViewsModel>> getProductById(
      String productId) async {
    try {
      final response = await apiService.get(
        endpoint: "${BackendEndpoints.getProductById}/$productId",
        authorized: true,
      );

      if (response.statusCode != 200) {
        return left(ServerFailure(
          'فشل في جلب تفاصيل المنتج: ${response.body}',
        ));
      }

      final data = jsonDecode(response.body);
      if (!data.containsKey('data')) {
        return left(ServerFailure('استجابة غير صالحة من الخادم'));
      }

      final productData = data['data'];
      final product = ProductsViewsModel.fromJson(productData);

      return right(product);
    } catch (e) {
      return left(
          ServerFailure('خطأ أثناء جلب تفاصيل المنتج: ${e.toString()}'));
    }
  }
}
