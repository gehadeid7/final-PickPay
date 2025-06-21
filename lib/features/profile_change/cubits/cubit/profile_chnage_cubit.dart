// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/core/services/firebase_auth_service.dart';
import 'package:pickpay/core/services/shared_preferences_singletone.dart';
import 'package:pickpay/features/auth/data/models/user_model.dart';
import 'package:pickpay/features/auth/domain/entities/user_entity.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';
import 'package:pickpay/features/profile_change/cubits/cubit/profile_chnage_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthRepo _authRepo;
  final FirebaseAuthService _firebaseAuthService;

  UserEntity? _loadedUser;
  bool _isBusy = false;

  ProfileCubit({
    required AuthRepo authRepo,
    required FirebaseAuthService firebaseAuthService,
  })  : _authRepo = authRepo,
        _firebaseAuthService = firebaseAuthService,
        super(const ProfileState()) {
    // Load cached data immediately
    loadCachedUserProfile();
  }

  void resetStatus() => emit(state.copyWith(
    status: ProfileStatus.initial,
    errorMessage: '',
    fieldBeingEdited: null,
  ));

  bool _hasChanges(UserEntity updated, UserEntity original) {
    return updated.fullName != original.fullName ||
        updated.email != original.email ||
        updated.phone != original.phone ||
        updated.gender != original.gender ||
        updated.dob != original.dob ||
        updated.age != original.age ||
        updated.address != original.address ||
        updated.photoUrl != original.photoUrl;
  }

  Future<void> loadCachedUserProfile() async {
    try {
      final cachedUser = Prefs.getUser();
      if (cachedUser != null) {
        _loadedUser = cachedUser;
        // Verify the cached user has valid data
        if (cachedUser.uId.isEmpty || cachedUser.email.isEmpty) {
          return;
        }
        emit(state.copyWith(
          status: ProfileStatus.loadSuccess,
          name: cachedUser.fullName,
          email: cachedUser.email,
          phone: cachedUser.phone ?? '',
          gender: cachedUser.gender ?? '',
          dob: cachedUser.dob ?? '',
          age: cachedUser.age ?? '',
          address: cachedUser.address ?? '',
          profileImageUrl: cachedUser.photoUrl ?? '',
          errorMessage: '',
        ));
      }
    } catch (e, st) {
      // No logging
    }
  }

  Future<void> loadUserProfile() async {
    if (_isBusy) return;
    _isBusy = true;

    try {
      // First try to load from cache if not already loaded
      if (_loadedUser == null) {
        await loadCachedUserProfile();
      }

      emit(state.copyWith(
        status: ProfileStatus.loading,
        errorMessage: '',
        fieldBeingEdited: null,
      ));

      final fbUser = _firebaseAuthService.getCurrentUser();
      if (fbUser == null) {
        emit(state.copyWith(
          status: ProfileStatus.error,
          errorMessage: 'لم يتم تسجيل الدخول',
        ));
        return;
      }

      // Load fresh data from backend with timeout
      final result = await _authRepo.getUserData(userId: fbUser.uid).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Backend request timed out');
        },
      );
      
      result.fold(
        (failure) {
          // Keep using cached data if available
          if (_loadedUser != null) {
            emit(state.copyWith(
              status: ProfileStatus.loadSuccess,
              errorMessage: 'تعذر تحميل بعض المعلومات. عرض البيانات المخزنة مؤقتاً.',
            ));
          } else {
            emit(state.copyWith(
              status: ProfileStatus.error,
              errorMessage: 'فشل تحميل البيانات',
            ));
          }
        },
        (user) async {
          _loadedUser = user;
          // Cache the updated user data
          await Prefs.saveUser(UserModel.fromEntity(user));
          // Update state with fresh data
          emit(state.copyWith(
            status: ProfileStatus.loadSuccess,
            name: user.fullName,
            email: user.email,
            phone: user.phone ?? '',
            gender: user.gender ?? '',
            dob: user.dob ?? '',
            age: user.age ?? '',
            address: user.address ?? '',
            profileImageUrl: user.photoUrl ?? '',
            errorMessage: '',
          ));
        },
      );
    } catch (e, st) {
      // Keep using cached data if available
      if (_loadedUser != null) {
        emit(state.copyWith(
          status: ProfileStatus.loadSuccess,
          errorMessage: 'تعذر تحميل بعض المعلومات. عرض البيانات المخزنة مؤقتاً.',
        ));
      } else {
        emit(state.copyWith(
          status: ProfileStatus.error,
          errorMessage: 'حدث خطأ أثناء تحميل الملف الشخصي.',
        ));
      }
    } finally {
      _isBusy = false;
    }
  }

  void _emitFieldUpdate({
    String? name,
    String? email,
    String? phone,
    String? gender,
    String? dob,
    String? age,
    String? address,
    required String editedField,
  }) {
    final newState = state.copyWith(
      name: name ?? state.name,
      email: email ?? state.email,
      phone: phone ?? state.phone,
      gender: gender ?? state.gender,
      dob: dob ?? state.dob,
      age: age ?? state.age,
      address: address ?? state.address,
      fieldBeingEdited: editedField,
      errorMessage: '',
    );
    emit(newState);
  }

  // Field update helpers with validation
  void updateName(String v) {
    if (v.trim().isEmpty) {
      emit(state.copyWith(
        errorMessage: 'الاسم لا يمكن أن يكون فارغاً',
        fieldBeingEdited: 'name',
      ));
      return;
    }
    _emitFieldUpdate(name: v.trim(), editedField: 'name');
  }

  void updatePhone(String v) {
    final normalizedPhone = _normalizeAndValidatePhone(v.trim());
    if (v.trim().isNotEmpty && normalizedPhone == null) {
      emit(state.copyWith(
        errorMessage: 'رقم الهاتف غير صالح',
        fieldBeingEdited: 'phone',
      ));
      return;
    }
    _emitFieldUpdate(phone: v.trim(), editedField: 'phone');
  }

  void updateGender(String v) {
    if (v.isEmpty) {
      emit(state.copyWith(
        errorMessage: 'الرجاء اختيار النوع',
        fieldBeingEdited: 'gender',
      ));
      return;
    }
    _emitFieldUpdate(gender: v, editedField: 'gender');
  }

  void updateAddress(String v) {
    if (v.trim().isEmpty) {
      emit(state.copyWith(
        errorMessage: 'العنوان لا يمكن أن يكون فارغاً',
        fieldBeingEdited: 'address',
      ));
      return;
    }
    _emitFieldUpdate(address: v.trim(), editedField: 'address');
  }

  void updateDob(String d, String a) {
    if (d.isEmpty) {
      emit(state.copyWith(
        errorMessage: 'تاريخ الميلاد مطلوب',
        fieldBeingEdited: 'dob',
      ));
      return;
    }
    _emitFieldUpdate(dob: d, age: a, editedField: 'dob');
  }

  void updateProfileImage(File? img) {
    if (img != null) {
      emit(state.copyWith(
        profileImage: img,
        fieldBeingEdited: 'photoUrl',
        status: ProfileStatus.loading,
      ));
    } else {
      emit(state.copyWith(
        profileImage: null,
        fieldBeingEdited: 'photoUrl',
        status: ProfileStatus.loading,
      ));
    }
  }

  Future<void> saveProfile() async {
    if (_isBusy) return;
    _isBusy = true;

    String? photoUrl = _loadedUser?.photoUrl;
    final previousState = state;

    emit(state.copyWith(
      status: ProfileStatus.loading,
      fieldBeingEdited: 'save',
    ));

    try {
      final fbUser = _firebaseAuthService.getCurrentUser();
      if (fbUser == null) {
        emit(state.copyWith(
          status: ProfileStatus.error,
          errorMessage: 'لم يتم تسجيل الدخول.',
        ));
        return;
      }

      // Handle image upload if new image selected
      if (state.profileImage != null) {
        try {
          final uploadRes = await _authRepo.uploadProfileImageAndUpdate(state.profileImage!).timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw TimeoutException('Image upload timed out');
            },
          );
          
          uploadRes.fold(
            (failure) {
              emit(state.copyWith(
                status: ProfileStatus.error,
                errorMessage: 'فشل تحميل الصورة: ${failure.message}',
                profileImageUrl: previousState.profileImageUrl,
              ));
              _isBusy = false;
              return;
            },
            (userWithPhoto) {
              photoUrl = userWithPhoto.photoUrl;
              // Cache the updated user with new photo URL
              if (_loadedUser != null) {
                final updatedUser = _loadedUser!.copyWith(photoUrl: photoUrl);
                Prefs.saveUser(UserModel.fromEntity(updatedUser));
              }
            },
          );
        } catch (e, st) {
          emit(state.copyWith(
            status: ProfileStatus.error,
            errorMessage: 'حدث خطأ أثناء تحميل الصورة. يرجى المحاولة مرة أخرى.',
            profileImageUrl: previousState.profileImageUrl,
          ));
          _isBusy = false;
          return;
        }
      }

      // Create updated user entity
      final updatedUser = UserEntity(
        uId: fbUser.uid,
        email: state.email,
        fullName: state.name,
        emailVerified: fbUser.emailVerified,
        photoUrl: photoUrl,
        phone: state.phone,
        gender: state.gender,
        dob: state.dob,
        age: state.age,
        address: state.address,
      );

      // Create the request body with all user data
      final requestBody = {
        'name': updatedUser.fullName,
        'email': updatedUser.email,
        'phone': updatedUser.phone,
        'gender': updatedUser.gender,
        'dob': updatedUser.dob,
        'age': updatedUser.age,
        'address': updatedUser.address,
        if (photoUrl != null) 'profileImg': photoUrl!.split('/').last,
      };
      
      final updateRes = await _authRepo.updateUserData(updatedUser, requestBody: requestBody);
      
      updateRes.fold(
        (f) {
          emit(state.copyWith(
            status: ProfileStatus.error,
            errorMessage: 'فشل تحديث الملف الشخصي: ${f.message}',
            profileImageUrl: previousState.profileImageUrl,
          ));
        },
        (_) async {
          // Update local user immediately
          _loadedUser = updatedUser;
          // Cache the updated user data
          await Prefs.saveUser(UserModel.fromEntity(updatedUser));
          // Update state with the new data
          emit(state.copyWith(
            status: ProfileStatus.saveSuccess,
            name: updatedUser.fullName,
            email: updatedUser.email,
            phone: updatedUser.phone ?? '',
            gender: updatedUser.gender ?? '',
            dob: updatedUser.dob ?? '',
            age: updatedUser.age ?? '',
            address: updatedUser.address ?? '',
            profileImageUrl: updatedUser.photoUrl ?? '',
            profileImage: null,
            errorMessage: '',
            fieldBeingEdited: null,
          ));
        },
      );
    } catch (e, st) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        errorMessage: 'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.',
        profileImageUrl: previousState.profileImageUrl,
      ));
    } finally {
      _isBusy = false;
    }
  }

  // Add new method for saving only the profile image
  Future<void> saveProfileImage() async {
    if (_isBusy) return;
    _isBusy = true;
    
    try {
      emit(state.copyWith(
        status: ProfileStatus.loading,
        fieldBeingEdited: 'photoUrl',
      ));

      final fbUser = _firebaseAuthService.getCurrentUser();
      if (fbUser == null) {
        throw StateError('No authenticated user found');
      }

      if (state.profileImage == null) {
        throw StateError('No image selected');
      }

      // Upload and update profile image with timeout
      final result = await _authRepo.uploadProfileImageAndUpdate(state.profileImage!).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Image upload timed out');
        },
      );
      
      result.fold(
        (failure) {
          emit(state.copyWith(
            status: ProfileStatus.error,
            errorMessage: failure.message,
            profileImage: null, // Clear the image on failure
          ));
        },
        (updatedUser) {
          emit(state.copyWith(
            status: ProfileStatus.saveSuccess,
            profileImageUrl: updatedUser.photoUrl ?? '',
            profileImage: null,
            errorMessage: '',
            fieldBeingEdited: null,
          ));
        },
      );
    } catch (e, st) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        errorMessage: e.toString(),
        profileImage: null, // Clear the image on error
      ));
    } finally {
      _isBusy = false;
    }
  }

  // Add new method for saving profile without image
  Future<void> saveProfileWithoutImage() async {
    if (_isBusy) return;
    _isBusy = true;
    
    try {
      emit(state.copyWith(
        status: ProfileStatus.loading,
        fieldBeingEdited: 'save',
      ));

      final fbUser = _firebaseAuthService.getCurrentUser();
      if (fbUser == null) {
        throw StateError('No authenticated user found');
      }

      // Create updated user entity without changing the image
      final updatedUser = UserEntity(
        uId: fbUser.uid,
        email: state.email,
        fullName: state.name,
        emailVerified: fbUser.emailVerified,
        photoUrl: state.profileImageUrl, // Keep existing image URL
        phone: state.phone,
        gender: state.gender,
        dob: state.dob,
        age: state.age,
        address: state.address,
      );

      // Create the request body with all user data except image
      final requestBody = {
        'name': updatedUser.fullName,
        'email': updatedUser.email,
        'phone': updatedUser.phone,
        'gender': updatedUser.gender,
        'dob': updatedUser.dob,
        'age': updatedUser.age,
        'address': updatedUser.address,
      };
      
      final updateRes = await _authRepo.updateUserData(updatedUser, requestBody: requestBody);
      
      updateRes.fold(
        (f) {
          emit(state.copyWith(
            status: ProfileStatus.error,
            errorMessage: 'فشل تحديث الملف الشخصي: ${f.message}',
          ));
        },
        (_) async {
          // Update local user immediately
          _loadedUser = updatedUser;
          // Cache the updated user data
          await Prefs.saveUser(UserModel.fromEntity(updatedUser));
          // Update state with the new data
          emit(state.copyWith(
            status: ProfileStatus.saveSuccess,
            name: updatedUser.fullName,
            email: updatedUser.email,
            phone: updatedUser.phone ?? '',
            gender: updatedUser.gender ?? '',
            dob: updatedUser.dob ?? '',
            age: updatedUser.age ?? '',
            address: updatedUser.address ?? '',
            errorMessage: '',
            fieldBeingEdited: null,
          ));
        },
      );
    } catch (e, st) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        errorMessage: 'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.',
      ));
    } finally {
      _isBusy = false;
    }
  }

  String? _normalizeAndValidatePhone(String phone) {
    final digits = phone.replaceAll(RegExp(r'\D'), '');

    // رقم بصيغة +20 أو 0020 (12 رقماً بعد 20)
    if (digits.startsWith('20')) {
      final national = digits.substring(2);
      if (national.length == 10 && national.startsWith('1')) {
        return '+20$national';
      }
    }

    // رقم محلي 01XXXXXXXXX (11 رقماً)
    if (digits.length == 11 && digits.startsWith('01')) {
      return '+20${digits.substring(1)}';
    }

    return null;
  }
}

extension on UserEntity {
  UserEntity copyWith({
    String? fullName,
    String? email,
    String? phone,
    String? gender,
    String? dob,
    String? age,
    String? address,
    String? photoUrl,
    bool? emailVerified,
  }) {
    return UserEntity(
      uId: uId,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      age: age ?? this.age,
      address: address ?? this.address,
      photoUrl: photoUrl ?? this.photoUrl,
      emailVerified: emailVerified ?? this.emailVerified,
    );
  }
}
