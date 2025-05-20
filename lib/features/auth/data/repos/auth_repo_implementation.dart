import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/errors/failures.dart';
import 'package:pickpay/core/services/database_services.dart';
import 'package:pickpay/core/services/firebase_auth_service.dart';
import 'package:pickpay/core/services/shared_preferences_singletone.dart' show Prefs;
import 'package:pickpay/core/utils/backend_endpoints.dart';
import 'package:pickpay/features/auth/data/models/user_model.dart';
import 'package:pickpay/features/auth/domain/entities/user_entity.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';
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
      print('🔄 Saving user data to local storage:');
      print('📋 User data: ${user.toMap()}');
      await Prefs.saveUser(UserModel.fromEntity(user));
      print('✅ User data saved successfully');
      return right(null);
    } catch (e) {
      print('❌ Failed to save user data: $e');
      return left(ServerFailure('Failed to save user data: ${e.toString()}'));
    }
  }

  // ───────────────────────────────────────────────
  // 👤 GET USER DATA FROM BACKEND
  // ───────────────────────────────────────────────
  @override
  Future<Either<Failure, UserEntity>> getUserData({required String userId}) async {
    try {
      print('🔄 Getting user data for userId: $userId');
      final response = await apiService.get(
        endpoint: BackendEndpoints.getMe,
        authorized: true,
      );

      print('📥 User data response status: ${response.statusCode}');
      print('📥 User data response body: ${response.body}');

      if (response.statusCode != 200) {
        print('❌ Failed to get user data:');
        print('❌ Status: ${response.statusCode}');
        print('❌ Response: ${response.body}');
        return left(ServerFailure(
            'Backend error ${response.statusCode}: ${response.body}'));
      }

      final responseData = jsonDecode(response.body);
      print('✅ Got response data: $responseData');
      
      if (!responseData.containsKey('data')) {
        print('❌ No data field in response');
        return left(ServerFailure('Invalid response format: missing data field'));
      }

      final userData = responseData['data'];
      print('✅ Got user data: $userData');
      
      final userModel = UserModel.fromJson(userData);
      print('✅ Created user model: ${userModel.toMap()}');
      
      // Always update cache with fresh data
      print('🔄 Updating local cache with fresh data');
      await Prefs.saveUser(userModel);
      print('✅ Cache updated successfully');
      
      return right(userModel);
    } catch (e, stack) {
      print('❌ Exception in getUserData:');
      print('❌ Error: ${e.toString()}');
      print('❌ Stack trace: $stack');
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
      print('🔄 updateUserData started for userId: ${user.uId}');

      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print('❌ No logged-in user found in updateUserData');
        return left(ServerFailure('No logged-in user'));
      }
      print('✅ Current Firebase user found: ${currentUser.uid}');

      String? photoUrl = user.photoUrl;
      print('📋 Incoming user data: fullName="${user.fullName}", email="${user.email}", photoUrl="$photoUrl"');

      // Upload profile image if local path (not URL)
      if (photoUrl != null && photoUrl.isNotEmpty && !photoUrl.startsWith('http')) {
        print('🖼️ Detected local image path: "$photoUrl" (length: ${photoUrl.length})');

        final file = File(photoUrl);
        final exists = await file.exists();
        print('📂 Checking if file exists at path: $photoUrl -> $exists');
        if (!exists) {
          print('❌ File does NOT exist at path: $photoUrl');
          return left(ServerFailure('صورة الملف غير موجودة في المسار المحدد: $photoUrl'));
        }
        
        print('⬆️ Uploading profile image...');
        final uploadResult = await uploadProfileImage(currentUser.uid, file);
        
        final updatedPhotoUrlOrFailure = uploadResult.fold<Either<Failure, String>>(
          (failure) {
            print('❌ Image upload failed in updateUserData: ${failure.message}');
            return left(failure);
          },
          (url) {
            print('✅ Profile image uploaded successfully. New URL: $url');
            photoUrl = url;
            return right(url);
          },
        );
        
        if (updatedPhotoUrlOrFailure.isLeft()) {
          print('❌ Returning failure from image upload');
          return left(updatedPhotoUrlOrFailure.swap().getOrElse(() => ServerFailure('فشل رفع الصورة')));
        }
      } else {
        print('ℹ️ No need to upload profile image. Using existing URL or empty path.');
      }

      print('🔄 Updating FirebaseAuth profile with displayName: "${user.fullName}", photoUrl: $photoUrl');
      await currentUser.updateDisplayName(user.fullName);
      if (photoUrl != null) {
        await currentUser.updatePhotoURL(photoUrl);
      }
      await currentUser.reload();
      print('✅ FirebaseAuth profile updated and reloaded.');

      print('🌐 Preparing to update backend profile for userId: ${user.uId}');
      final idToken = await currentUser.getIdToken();
      print('🔐 Retrieved Firebase ID token for authorization.');

      // Create the request body with all user data
      final Map<String, dynamic> finalRequestBody = {
        'fullName': user.fullName,
        'email': user.email,
        'phone': user.phone,
        'gender': user.gender,
        'dob': user.dob,
        'age': user.age,
        'address': user.address,
        if (photoUrl != null) 'profileImg': photoUrl!.contains('/') ? photoUrl!.split('/').last : photoUrl,
      };

      // Merge with any additional request body data
      if (requestBody != null) {
        finalRequestBody.addAll(requestBody);
      }

      print('📤 PUT Request to backend at endpoint: ${BackendEndpoints.updateMe}');
      print('📤 Request body: $finalRequestBody');

      final response = await apiService.put(
        endpoint: BackendEndpoints.updateMe,
        body: finalRequestBody,
        headers: {
          'Authorization': 'Bearer $idToken',
          'Content-Type': 'application/json',
        },
      );

      print('📥 Received response with status code: ${response.statusCode}');
      print('📥 Response body: ${response.body}');
      if (response.statusCode == 200) {
        print('✅ Backend profile updated successfully.');
        
        // Parse the response to see what we got back
        try {
          final responseData = jsonDecode(response.body);
          print('📥 Parsed response data: $responseData');
          if (responseData.containsKey('data')) {
            final userData = responseData['data'];
            print('📥 User data from response: $userData');
            // Update cache with the response data instead of what we sent
            final updatedUser = UserModel.fromJson(userData);
            print('📥 Created user model from response: ${updatedUser.toMap()}');
            await Prefs.saveUser(updatedUser);
            print('✅ Local cache updated with response data');
          } else {
            print('⚠️ No data field in response, using sent data as fallback');
            await Prefs.saveUser(UserModel.fromEntity(user));
          }
        } catch (e) {
          print('⚠️ Error parsing response, using sent data as fallback: $e');
          await Prefs.saveUser(UserModel.fromEntity(user));
        }
        
        return right(null);
      } else {
        print('❌ Backend profile update failed with status ${response.statusCode}: ${response.body}');
        return left(ServerFailure('فشل تحديث البيانات: ${response.body}'));
      }
    } catch (e, stack) {
      print('⛔ Exception in updateUserData: ${e.toString()}');
      print('📄 Stacktrace:\n$stack');
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
      final methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
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
      print('\n=== 📤 UPLOAD IMAGE REQUEST START ===');
      print('⬆️ uploadImage: Starting upload to ${BackendEndpoints.uploadUserPhoto}');
      print('⬆️ uploadImage: File path: ${image.path}');
      print('⬆️ uploadImage: File exists: ${image.existsSync()}');
      print('⬆️ uploadImage: File size: ${await image.length()} bytes');

      if (!image.existsSync()) {
        print('❌ File does not exist at path: ${image.path}');
        return left(ServerFailure('File does not exist at path: ${image.path}'));
      }

      final streamedResponse = await apiService.uploadImage(
        endpoint: BackendEndpoints.uploadUserPhoto,
        imageFile: image,
        fields: {'userId': userId},
        authorized: true,
      );

      print('📦 Read file bytes: ${await image.length()} bytes');
      print('📎 Added multipart file with field name "profileImg"');

      final response = await http.Response.fromStream(streamedResponse);
      print('\n=== 📥 RESPONSE DETAILS ===');
      print('📥 Upload response status: ${response.statusCode}');
      print('📥 Raw response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('\n=== 🔍 BACKEND RESPONSE ANALYSIS ===');
        print('📥 Full response data: $responseData');
        
        // Get the filename from the response
        final profileImg = responseData['profileImg'];
        if (profileImg == null || profileImg.isEmpty) {
          print('❌ Error: Backend did not return profileImg');
          print('❌ Full response data: $responseData');
          return left(ServerFailure('Backend did not return profileImg'));
        }

        // Use the profileImgUrl from the response if available, otherwise construct it
        String fullImageUrl = responseData['profileImgUrl'];
        if (fullImageUrl == null || fullImageUrl.isEmpty) {
          // Construct the full URL using the base URL from the API service
          final baseUrl = ApiService.baseUrl.replaceAll('/api/v1/', '').replaceAll(RegExp(r'/$'), '');
          fullImageUrl = '$baseUrl/uploads/users/$profileImg';
        }
        
        print('✅ Upload successful!');
        print('✅ Filename: $profileImg');
        print('✅ Full URL: $fullImageUrl');
        return right(fullImageUrl);
      } else {
        print('❌ Upload failed with status ${response.statusCode}');
        print('❌ Error response: ${response.body}');
        return left(ServerFailure('Upload failed with status ${response.statusCode}: ${response.body}'));
      }
    } catch (e, stack) {
      print('❌ Exception during image upload:');
      print('❌ Error: ${e.toString()}');
      print('❌ Stack trace: $stack');
      return left(ServerFailure('Failed to upload profile image: ${e.toString()}'));
    }
  }

  Future<Either<Failure, UserEntity>> uploadProfileImageAndUpdate(File image) async {
    try {
      print('\n=== 🔄 UPLOAD AND UPDATE PROFILE START ===');
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('❌ No authenticated user found');
        return left(ServerFailure('No authenticated user found'));
      }

      print('👤 Authenticated user ID: ${user.uid}');
      print('📤 Starting image upload...');

      // Ensure image has correct extension
      final ext = image.path.split('.').last.toLowerCase();
      if (!['jpg', 'jpeg', 'png'].contains(ext)) {
        print('❌ Invalid image format: $ext');
        return left(ServerFailure('Invalid image format. Please use JPG or PNG.'));
      }

      // Upload the image
      final uploadResult = await uploadProfileImage(user.uid, image);
      
      return await uploadResult.fold(
        (failure) {
          print('❌ Image upload failed: ${failure.message}');
          return left(failure);
        },
        (imageUrl) async {
          print('✅ Image uploaded successfully. URL: $imageUrl');

          // Get current user data
          print('🔄 Fetching current user data...');
          final currentUserResponse = await apiService.get(
            endpoint: BackendEndpoints.getMe,
            authorized: true,
          );

          if (currentUserResponse.statusCode != 200) {
            print('❌ Failed to get current user data:');
            print('❌ Status: ${currentUserResponse.statusCode}');
            print('❌ Response: ${currentUserResponse.body}');
            return left(ServerFailure('Failed to get current user data'));
          }

          final currentUserData = jsonDecode(currentUserResponse.body);
          print('✅ Got current user data: $currentUserData');
          final currentUser = UserModel.fromJson(currentUserData['data']);

          // Extract filename from the upload response URL
          String profileImg = imageUrl;
          if (imageUrl.contains('/')) {
            profileImg = imageUrl.split('/').last;
          }
          print('📸 Using filename from upload response: $profileImg');

          // Update backend with just the filename
          print('🔄 Updating backend profile...');
          final updateResponse = await apiService.put(
            endpoint: BackendEndpoints.updateMe,
            body: {
              'profileImg': profileImg, // Send only the filename
            },
            authorized: true,
          );

          print('📥 Profile update response status: ${updateResponse.statusCode}');
          print('📥 Profile update response body: ${updateResponse.body}');

          if (updateResponse.statusCode == 200) {
            print('✅ Backend profile updated successfully');
            
            // Get the full URL from the update response
            final updateData = jsonDecode(updateResponse.body);
            final fullImageUrl = updateData['data']['profileImg'];
            print('🖼️ Full image URL from backend: $fullImageUrl');
            
            // Update Firebase Auth profile with the full URL
            print('🔄 Updating Firebase Auth profile...');
            await user.updatePhotoURL(fullImageUrl);
            await user.reload();
            print('✅ Firebase Auth profile updated');

            // Create updated user with the full URL
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

            // Save to local storage
            print('💾 Saving to local storage...');
            await saveUserData(user: updatedUser);
            print('✅ Local storage updated');
            
            print('✅ Profile update completed successfully');
            return right(updatedUser);
          } else {
            print('❌ Profile update failed:');
            print('❌ Status: ${updateResponse.statusCode}');
            print('❌ Response: ${updateResponse.body}');
            return left(ServerFailure('Profile update failed: ${updateResponse.body}'));
          }
        },
      );
    } catch (e, stack) {
      print('❌ Unexpected error during profile update:');
      print('❌ Error: ${e.toString()}');
      print('❌ Stack trace: $stack');
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