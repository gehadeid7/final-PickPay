import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/features/profile_change/cubits/cubit/profile_chnage_state.dart';
import 'package:pickpay/features/auth/domain/entities/user_entity.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';
import 'package:pickpay/core/services/firebase_auth_service.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthRepo authRepo;
  final FirebaseAuthService firebaseAuthService;

  UserEntity? loadedUser;

  ProfileCubit({
    required this.authRepo,
    required this.firebaseAuthService,
  }) : super(const ProfileState());

  Future<void> loadUserProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    print('loadUserProfile: Started loading profile');

    try {
      final firebaseUser = firebaseAuthService.getCurrentUser();
      if (firebaseUser == null) {
        print('loadUserProfile: No logged in user found');
        emit(state.copyWith(
          status: ProfileStatus.error,
          errorMessage: "User not logged in",
        ));
        return;
      }
      print('loadUserProfile: Firebase user found with uid: ${firebaseUser.uid}');

      final result = await authRepo.getUserData(userId: firebaseUser.uid);
      result.fold(
        (failure) {
          print('loadUserProfile: Failed to get user data from repo - ${failure.message}');
          // Fallback to firebase user info, with informative error message
          loadedUser = UserEntity.fromFirebaseUser(firebaseUser);
          emit(state.copyWith(
            status: ProfileStatus.loadSuccess,
            errorMessage: 'Failed to load full profile info: ${failure.message}. Showing basic info.',
            name: firebaseUser.displayName ?? '',
            email: firebaseUser.email ?? '',
            profileImageUrl: firebaseUser.photoURL ?? '',
            phone: '',
            gender: '',
            dob: '',
            age: '',
            address: '',
          ));
        },
        (user) {
          print('loadUserProfile: User data loaded successfully from repo: $user');
          loadedUser = user;
          emit(state.copyWith(
            name: user.fullName,
            email: user.email,
            phone: user.phone ?? '',
            gender: user.gender ?? '',
            dob: user.dob ?? '',
            age: user.age ?? '',
            address: user.address ?? '',
            profileImageUrl: user.photoUrl ?? '',
            status: ProfileStatus.loadSuccess,
            errorMessage: '',
          ));
        },
      );
    } catch (e, stacktrace) {
      print('loadUserProfile: Exception caught - $e');
      print(stacktrace);
      emit(state.copyWith(
        status: ProfileStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void updateName(String name) {
    print('updateName: name changed to $name');
    emit(state.copyWith(name: name));
  }

  void updateEmail(String email) {
    print('updateEmail: email changed to $email');
    emit(state.copyWith(email: email));
  }

  void updatePhone(String phone) {
    print('updatePhone: phone changed to $phone');
    emit(state.copyWith(phone: phone));
  }

  void updateGender(String gender) {
    print('updateGender: gender changed to $gender');
    emit(state.copyWith(gender: gender));
  }

  void updateDob(String dob, String age) {
    print('updateDob: dob changed to $dob, age changed to $age');
    emit(state.copyWith(dob: dob, age: age));
  }

  void updateAddress(String address) {
    print('updateAddress: address changed to $address');
    emit(state.copyWith(address: address));
  }

  void updateProfileImage(File? image) {
    print('updateProfileImage: profile image updated');
    emit(state.copyWith(profileImage: image, profileImageUrl: ''));
  }

  Future<void> saveProfile() async {
    print('saveProfile: Starting profile save');
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      final firebaseUser = firebaseAuthService.getCurrentUser();
      if (firebaseUser == null) {
        print('saveProfile: No user logged in');
        emit(state.copyWith(
            status: ProfileStatus.error, errorMessage: 'No user logged in'));
        return;
      }

      // Prepare photoUrl, upload if needed
      String? photoUrl = state.profileImageUrl;

      if (state.profileImage != null) {
        print('saveProfile: Checking if profile image file exists');
        final file = state.profileImage!;

        if (!file.existsSync()) {
          print('saveProfile: ERROR - Profile image file does not exist at path: ${file.path}');
          emit(state.copyWith(
            status: ProfileStatus.error,
            errorMessage: 'Profile image file not found at ${file.path}',
          ));
          return;
        }

        print('saveProfile: Uploading new profile image');
        final uploadResult =
            await authRepo.uploadProfileImage(firebaseUser.uid, file);

        uploadResult.fold(
          (failure) {
            print('saveProfile: Upload failed - ${failure.message}');
            emit(state.copyWith(status: ProfileStatus.error, errorMessage: failure.message));
            return;
          },
          (uploadedUrl) {
            print('saveProfile: Upload successful, new photoUrl: $uploadedUrl');
            photoUrl = uploadedUrl;
          },
        );
      }

      // Define which fields were changed by comparing state with loadedUser
      final changedFields = <String>{};

      if (state.name != (loadedUser?.fullName ?? '')) changedFields.add('name');
      if (state.email != (loadedUser?.email ?? '')) changedFields.add('email');
      if (state.phone != (loadedUser?.phone ?? '')) changedFields.add('phone');
      if (state.gender != (loadedUser?.gender ?? '')) changedFields.add('gender');
      if (state.dob != (loadedUser?.dob ?? '')) changedFields.add('dob');
      if (state.age != (loadedUser?.age ?? '')) changedFields.add('age');
      if (state.address != (loadedUser?.address ?? '')) changedFields.add('address');
      if (photoUrl != (loadedUser?.photoUrl ?? '')) changedFields.add('photoUrl');

      final existing = loadedUser ??
          UserEntity(
            uId: firebaseUser.uid,
            email: firebaseUser.email ?? '',
            fullName: firebaseUser.displayName ?? '',
            emailVerified: firebaseUser.emailVerified,
            photoUrl: firebaseUser.photoURL,
          );

      final updatedUser = UserEntity(
        uId: firebaseUser.uid,
        email: changedFields.contains('email') ? state.email : existing.email,
        fullName: changedFields.contains('name') ? state.name : existing.fullName,
        phone: changedFields.contains('phone') ? state.phone : existing.phone,
        gender: changedFields.contains('gender') ? state.gender : existing.gender,
        dob: changedFields.contains('dob') ? state.dob : existing.dob,
        age: changedFields.contains('age') ? state.age : existing.age,
        address: changedFields.contains('address') ? state.address : existing.address,
        photoUrl: photoUrl,
        emailVerified: firebaseUser.emailVerified,
      );

      final updateResult = await authRepo.updateUserData(updatedUser);

      updateResult.fold(
        (failure) {
          print('saveProfile: Update failed - ${failure.message}');
          emit(state.copyWith(status: ProfileStatus.error, errorMessage: failure.message));
        },
        (_) {
          print('saveProfile: Profile update successful');
          loadedUser = updatedUser; // Update loaded user cache
          emit(state.copyWith(status: ProfileStatus.saveSuccess, profileImageUrl: photoUrl));
        },
      );
    } catch (e, stacktrace) {
      print('saveProfile: Exception caught - $e');
      print(stacktrace);
      emit(state.copyWith(status: ProfileStatus.error, errorMessage: e.toString()));
    }
  }

  void resetStatus() {
    print('resetStatus: Resetting profile state');
    emit(state.copyWith(status: ProfileStatus.initial, errorMessage: ''));
  }
}
