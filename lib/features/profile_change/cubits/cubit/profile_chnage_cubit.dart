// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:pickpay/core/services/firebase_auth_service.dart';
import 'package:pickpay/core/services/shared_preferences_singletone.dart';
import 'package:pickpay/features/auth/data/models/user_model.dart';
import 'package:pickpay/features/auth/domain/entities/user_entity.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';
import 'package:pickpay/features/profile_change/cubits/cubit/profile_chnage_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthRepo _authRepo;
  final FirebaseAuthService _firebaseAuthService;

  UserEntity? _loadedUser;
  bool _isBusy = false;
  static final Logger _logger = Logger(printer: PrettyPrinter(methodCount: 0));

  ProfileCubit({
    required AuthRepo authRepo,
    required FirebaseAuthService firebaseAuthService,
  })  : _authRepo = authRepo,
        _firebaseAuthService = firebaseAuthService,
        super(const ProfileState());

  void _logError(String message, [Object? error, StackTrace? st]) =>
      _logger.e(message, error: error, stackTrace: st);

  void _logInfo(String message) => _logger.i(message);

  UserEntity _getCurrentUserOrThrow() {
    final fbUser = _firebaseAuthService.getCurrentUser();
    if (fbUser == null) throw StateError('لم يتم تسجيل الدخول');
    return UserEntity.fromFirebaseUser(fbUser);
  }

  void resetStatus() => emit(state.copyWith(status: ProfileStatus.initial));


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

  /// Load cached user from local storage if any
  Future<void> loadCachedUserProfile() async {
    final cachedUser = Prefs.getUser();
    if (cachedUser != null) {
      _loadedUser = cachedUser;
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
      ));
    }
  }

  /// Load user profile from backend via AuthRepo
  Future<void> loadUserProfile() async {
    await loadCachedUserProfile();

    emit(state.copyWith(status: ProfileStatus.loading));
    _logInfo('Loading user profile…');

    try {
      final fbUser = _firebaseAuthService.getCurrentUser();
      if (fbUser == null) {
        emit(state.copyWith(
          status: ProfileStatus.error,
          errorMessage: 'لم يتم تسجيل الدخول',
        ));
        return;
      }

      final result = await _authRepo.getUserData(userId: fbUser.uid);
      result.fold(
        (failure) {
          _logError('Failed to get user data', failure.message);
          // Fallback: basic info from Firebase user only
          _loadedUser = UserEntity.fromFirebaseUser(fbUser);
          emit(state.copyWith(
            status: ProfileStatus.loadSuccess,
            errorMessage: 'تعذر تحميل بعض المعلومات. عرض المعلومات الأساسية فقط.',
            name: fbUser.displayName ?? '',
            email: fbUser.email ?? '',
            profileImageUrl: fbUser.photoURL ?? '',
          ));
        },
        (user) async {
          _loadedUser = user;
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
          ));
          // Cache user locally
          await Prefs.saveUser(UserModel.fromEntity(user));
        },
      );
    } catch (e, st) {
      _logError('Exception in loadUserProfile', e, st);
      emit(state.copyWith(
        status: ProfileStatus.error,
        errorMessage: 'حدث خطأ أثناء تحميل الملف الشخصي.',
      ));
    }
  }

  // Update UI fields on editing
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
    emit(state.copyWith(
      name: name,
      email: email,
      phone: phone,
      gender: gender,
      dob: dob,
      age: age,
      address: address,
      fieldBeingEdited: editedField,
    ));
  }

  // Field update helpers
  void updateName(String v) => _emitFieldUpdate(name: v, editedField: 'name');
  void updateEmail(String v) => _emitFieldUpdate(email: v, editedField: 'email');
  void updatePhone(String v) => _emitFieldUpdate(phone: v, editedField: 'phone');
  void updateGender(String v) => _emitFieldUpdate(gender: v, editedField: 'gender');
  void updateDob(String d, String a) => _emitFieldUpdate(dob: d, age: a, editedField: 'dob');
  void updateAddress(String v) => _emitFieldUpdate(address: v, editedField: 'address');

  void updateProfileImage(File? img) => emit(state.copyWith(
        profileImage: img,
        profileImageUrl: '',
        fieldBeingEdited: 'photoUrl',
      ));

  /// Normalize Egyptian phone number for backend
  /// Returns normalized phone or null if invalid
  String? _normalizeAndValidatePhone(String phone) {
    final digitsOnly = phone.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length == 11 && digitsOnly.startsWith('01')) {
      return '+20${digitsOnly.substring(1)}';
    }
    return null;
  }

  /// Save entire profile including optional photo upload
  Future<void> saveProfile() async {
    if (_isBusy) return;
    _isBusy = true;

    emit(state.copyWith(status: ProfileStatus.loading));
    _logInfo('Saving profile…');

    try {
      final fbUser = _firebaseAuthService.getCurrentUser();
      if (fbUser == null) {
        emit(state.copyWith(
          status: ProfileStatus.error,
          errorMessage: 'لم يتم تسجيل الدخول.',
        ));
        _isBusy = false;
        return;
      }

      // Handle image upload if new image selected
      String? photoUrl = state.profileImageUrl.isNotEmpty
          ? state.profileImageUrl
          : _loadedUser?.photoUrl;

      if (state.profileImage != null) {
        final uploadRes = await _authRepo.uploadProfileImageAndUpdate(state.profileImage!);
        UserEntity? userWithPhoto;
        bool uploadFailed = false;
        uploadRes.fold(
          (failure) {
            uploadFailed = true;
            _logError('Image upload failed', failure.message);
            emit(state.copyWith(
              status: ProfileStatus.error,
              errorMessage: 'فشل تحميل الصورة: ${failure.message}',
            ));
          },
          (u) => userWithPhoto = u,
        );
        if (uploadFailed || userWithPhoto == null) {
          _isBusy = false;
          return;
        }
        photoUrl = userWithPhoto!.photoUrl;
      }
       print('Before normalization - state.phone: "${state.phone}"');

      // Validate and normalize phone
      final normalizedPhone = _normalizeAndValidatePhone(state.phone.trim());
      print('After normalization - normalizedPhone: $normalizedPhone');

      if (state.phone.trim().isNotEmpty && normalizedPhone == null) {
        emit(state.copyWith(
          status: ProfileStatus.error,
          errorMessage: 'رقم الهاتف غير صالح. يجب أن يكون مصريًا بصيغة 01XXXXXXXXX',
        ));
        _isBusy = false;
        return;
      }

      final existing = _loadedUser ?? _getCurrentUserOrThrow();
print('Existing user phone: ${existing.phone}');

      final updatedUser = UserEntity(
        uId: existing.uId,
        fullName: state.name.isNotEmpty ? state.name : existing.fullName,
        email: state.email.isNotEmpty ? state.email : existing.email,
        phone: normalizedPhone ?? existing.phone,
        gender: state.gender.isNotEmpty ? state.gender : existing.gender,
        dob: state.dob.isNotEmpty ? state.dob : existing.dob,
        age: state.age.isNotEmpty ? state.age : existing.age,
        address: state.address.isNotEmpty ? state.address : existing.address,
        photoUrl: photoUrl,
        emailVerified: existing.emailVerified,
      );
if (!_hasChanges(updatedUser, existing)) {
  emit(state.copyWith(
    status: ProfileStatus.saveSuccess,
    errorMessage: '',
  ));
  _isBusy = false;
  return; // No changes to save
}
      final updateRes = await _authRepo.updateUserData(updatedUser);
      bool failed = false;
      updateRes.fold(
        (f) {
          failed = true;
          _logError('Failed to update user data', f.message);
          emit(state.copyWith(
            status: ProfileStatus.error,
            errorMessage: 'فشل تحديث الملف الشخصي: ${f.message}',
          ));
        },
        (_) async {
          _loadedUser = updatedUser;
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
          ));
          await Prefs.saveUser(UserModel.fromEntity(updatedUser));
        },
      );

      // Send verification email if email changed
      if (!failed && state.email.isNotEmpty && state.email != existing.email) {
        final sendRes = await _authRepo.sendEmailVerification();
        sendRes.fold(
          (f) => _logError('Failed to send email verification', f.message),
          (_) => _logInfo('Email verification sent'),
        );
      }
    } catch (e, st) {
      _logError('Exception in saveProfile', e, st);
      emit(state.copyWith(
        status: ProfileStatus.error,
        errorMessage: 'حدث خطأ أثناء حفظ الملف الشخصي.',
      ));
    } finally {
      _isBusy = false;
    }
  }

  /// Save and update a single field with validation and caching
  Future<void> saveField(String key) async {
    if (_isBusy) return;
    _isBusy = true;

    emit(state.copyWith(status: ProfileStatus.loading));
    _logInfo('Saving field: $key');

    try {
      final existing = _loadedUser ?? _getCurrentUserOrThrow();
      late UserEntity updated;

      switch (key) {
        case 'name':
          if (state.name.isEmpty) {
            emit(state.copyWith(status: ProfileStatus.error, errorMessage: 'الاسم لا يمكن أن يكون فارغًا.'));
            _isBusy = false;
            return;
          }
          updated = existing.copyWith(fullName: state.name);
          break;
        case 'email':
          if (state.email.isEmpty) {
            emit(state.copyWith(status: ProfileStatus.error, errorMessage: 'البريد الإلكتروني لا يمكن أن يكون فارغًا.'));
            _isBusy = false;
            return;
          }
          updated = existing.copyWith(email: state.email);
          break;
        case 'phone':
          final normalizedPhone = _normalizeAndValidatePhone(state.phone.trim());
          if (state.phone.trim().isNotEmpty && normalizedPhone == null) {
            emit(state.copyWith(status: ProfileStatus.error, errorMessage: 'رقم الهاتف غير صالح'));
            _isBusy = false;
            return;
          }
          updated = existing.copyWith(phone: normalizedPhone ?? existing.phone);
          break;
        case 'gender':
          updated = existing.copyWith(gender: state.gender);
          break;
        case 'dob':
          updated = existing.copyWith(
            dob: state.dob.isNotEmpty ? state.dob : null,
            age: state.age.isNotEmpty ? state.age : null,
          );
          break;
        case 'address':
          updated = existing.copyWith(address: state.address);
          break;
        default:
          emit(state.copyWith(status: ProfileStatus.error, errorMessage: 'حقل غير معروف: $key'));
          _isBusy = false;
          return;
      }

      final res = await _authRepo.updateUserData(updated);
      bool failed = false;
      res.fold(
        (f) {
          failed = true;
          _logError('Failed to update user data', f.message);
          emit(state.copyWith(status: ProfileStatus.error, errorMessage: 'فشل تحديث الملف الشخصي: ${f.message}'));
        },
        (_) async {
          _loadedUser = updated;
          emit(state.copyWith(
            status: ProfileStatus.saveSuccess,
            name: updated.fullName,
            email: updated.email,
            phone: updated.phone ?? '',
            gender: updated.gender ?? '',
            dob: updated.dob ?? '',
            age: updated.age ?? '',
            address: updated.address ?? '',
            profileImageUrl: updated.photoUrl ?? '',
            profileImage: null,
            errorMessage: '',
          ));
          await Prefs.saveUser(UserModel.fromEntity(updated));
        },
      );
    } catch (e, st) {
      _logError('Exception in saveField', e, st);
      emit(state.copyWith(
        status: ProfileStatus.error,
        errorMessage: 'حدث خطأ أثناء تحديث الملف الشخصي.',
      ));
    } finally {
      _isBusy = false;
    }
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
