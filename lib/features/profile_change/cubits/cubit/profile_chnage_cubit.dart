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

  void resetStatus() {
    emit(state.copyWith(status: ProfileStatus.initial));
  }

  void logError(String message, [Object? error]) {
    print('❌ ERROR: $message');
    if (error != null) print('DETAILS: $error');
  }

  void logInfo(String message) {
    print('ℹ️ INFO: $message');
  }

  Future<void> loadUserProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    logInfo('Loading user profile...');

    try {
      final firebaseUser = firebaseAuthService.getCurrentUser();
      if (firebaseUser == null) {
        emit(state.copyWith(
          status: ProfileStatus.error,
          errorMessage: "User not logged in",
        ));
        return;
      }

      final result = await authRepo.getUserData(userId: firebaseUser.uid);
      result.fold(
        (failure) {
          logError('Failed to get user data', failure.message);
          loadedUser = UserEntity.fromFirebaseUser(firebaseUser);
          emit(state.copyWith(
            status: ProfileStatus.loadSuccess,
            errorMessage: 'تعذر تحميل بعض المعلومات. عرض المعلومات الأساسية فقط.',
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
    } catch (e, st) {
      logError('Exception in loadUserProfile', e);
      print(st);
      emit(state.copyWith(
        status: ProfileStatus.error,
        errorMessage: 'حدث خطأ أثناء تحميل الملف الشخصي.',
      ));
    }
  }

  void updateName(String name) => emit(state.copyWith(name: name, fieldBeingEdited: 'name'));
  void updateEmail(String email) => emit(state.copyWith(email: email, fieldBeingEdited: 'email'));
  void updatePhone(String phone) => emit(state.copyWith(phone: phone, fieldBeingEdited: 'phone'));
  void updateGender(String gender) => emit(state.copyWith(gender: gender, fieldBeingEdited: 'gender'));
  void updateDob(String dob, String age) => emit(state.copyWith(dob: dob, age: age, fieldBeingEdited: 'dob'));
  void updateAddress(String address) => emit(state.copyWith(address: address, fieldBeingEdited: 'address'));

  void updateProfileImage(File? image) {
    emit(state.copyWith(
      profileImage: image,
      profileImageUrl: '',
      fieldBeingEdited: 'photoUrl',
    ));
  }

  bool _isValidEgyptianPhone(String phone) {
    final pattern = RegExp(r'^01[0-2,5]{1}[0-9]{8}$');
    return pattern.hasMatch(phone);
  }

  String _formatEgyptianPhone(String phone) {
    final digitsOnly = phone.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.startsWith('01') && digitsOnly.length == 11) {
      return '+20${digitsOnly.substring(1)}';
    }
    return phone;
  }

  Future<void> saveProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    logInfo('Saving profile...');

    try {
      final firebaseUser = firebaseAuthService.getCurrentUser();
      if (firebaseUser == null) {
        emit(state.copyWith(
          status: ProfileStatus.error,
          errorMessage: 'لم يتم تسجيل الدخول.',
        ));
        return;
      }

      String? photoUrl = state.profileImageUrl.isNotEmpty
          ? state.profileImageUrl
          : loadedUser?.photoUrl;

      // رفع الصورة إن وجدت صورة جديدة
      if (state.profileImage != null) {
        final uploadResult = await authRepo.uploadProfileImageAndUpdate(state.profileImage!);

        bool uploadFailed = false;
        UserEntity? updatedUserEntity;

        uploadResult.fold(
          (failure) {
            logError('Image upload failed', failure.message);
            emit(state.copyWith(
              status: ProfileStatus.error,
              errorMessage: 'فشل تحميل الصورة: ${failure.message}',
            ));
            uploadFailed = true;
          },
          (user) {
            updatedUserEntity = user;
            logInfo('Image uploaded successfully');
          },
        );

        if (uploadFailed || updatedUserEntity == null) return;

        // التحقق من وجود الصورة مسبقًا في قاعدة البيانات
        // final imageExistsResult = await authRepo.checkIfImageExists(updatedUserEntity!.photoUrl ?? '');
        // bool imageExists = false;

        // bool imageCheckFailed = false;

        // imageExistsResult.fold(
        //   (failure) {
        //     logError('Error checking image existence', failure.message);
        //     emit(state.copyWith(
        //       status: ProfileStatus.error,
        //       errorMessage: 'حدث خطأ أثناء التحقق من الصورة.',
        //     ));
        //     imageCheckFailed = true;
        //   },
        //   (exists) {
        //     imageExists = exists;
        //   },
        // );

        // if (imageCheckFailed || imageExists) {
        //   if (imageExists) {
        //     emit(state.copyWith(
        //       status: ProfileStatus.error,
        //       errorMessage: 'هذه الصورة مستخدمة مسبقًا.',
        //     ));
        //   }
        //   return;
        // }

        photoUrl = updatedUserEntity!.photoUrl;
      }

      // التحقق من رقم الهاتف
      String? formattedPhone;
      if (state.phone.isNotEmpty) {
        if (_isValidEgyptianPhone(state.phone)) {
          formattedPhone = _formatEgyptianPhone(state.phone);
        } else {
          emit(state.copyWith(
            status: ProfileStatus.error,
            errorMessage: 'رقم الهاتف غير صالح. يجب أن يكون مصريًا بصيغة 01XXXXXXXXX',
          ));
          return;
        }
      }

      final existingUser = loadedUser ??
          UserEntity(
            uId: firebaseUser.uid,
            email: firebaseUser.email ?? '',
            fullName: firebaseUser.displayName ?? '',
            emailVerified: firebaseUser.emailVerified,
            photoUrl: firebaseUser.photoURL,
          );

      // بناء كيان المستخدم المحدث بناء على التعديلات
      final updatedUser = UserEntity(
        uId: firebaseUser.uid,
        email: state.email.isNotEmpty ? state.email : existingUser.email,
        fullName: state.name.isNotEmpty ? state.name : existingUser.fullName,
        phone: formattedPhone ?? existingUser.phone,
        gender: state.gender.isNotEmpty ? state.gender : existingUser.gender,
        dob: state.dob.isNotEmpty ? state.dob : existingUser.dob,
        age: state.age.isNotEmpty ? state.age : existingUser.age,
        address: state.address.isNotEmpty ? state.address : existingUser.address,
        photoUrl: photoUrl,
        emailVerified: existingUser.emailVerified,
      );

      // تحديث بيانات المستخدم عبر الريبو
      final updateResult = await authRepo.updateUserData(updatedUser);

      bool updateFailed = false;

      updateResult.fold(
        (failure) {
          logError('Failed to update user data', failure.message);
          emit(state.copyWith(
            status: ProfileStatus.error,
            errorMessage: 'فشل تحديث الملف الشخصي: ${failure.message}',
          ));
          updateFailed = true;
        },
        (_) {
          loadedUser = updatedUser;
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
        },
      );

      if (updateFailed) return;

      // إرسال رابط التحقق إذا تم تعديل البريد الإلكتروني
      if (state.email.isNotEmpty && state.email != existingUser.email) {
        final sendEmailResult = await authRepo.sendEmailVerification();
        sendEmailResult.fold(
          (failure) {
            logError('Failed to send email verification', failure.message);
            emit(state.copyWith(
              status: ProfileStatus.error,
              errorMessage: 'تعذر إرسال رابط التحقق إلى البريد الإلكتروني.',
            ));
          },
          (_) {
            logInfo('Email verification sent');
          },
        );
      }
    } catch (e, st) {
      logError('Exception in saveProfile', e);
      print(st);
      emit(state.copyWith(
        status: ProfileStatus.error,
        errorMessage: 'حدث خطأ أثناء حفظ الملف الشخصي.',
      ));
    }
  }
void cancelEditing() {
  emit(state.copyWith(fieldBeingEdited: null));
}

void updateField(String fieldKey, String value) {
  switch (fieldKey) {
    case 'name':
      updateName(value);
      break;
    case 'email':
      updateEmail(value);
      break;
    case 'phone':
      updatePhone(value);
      break;
    case 'gender':
      updateGender(value);
      break;
    case 'dob':
      // نفترض أن الحساب الخاص بالعمر خارج الدالة، أو أضيف حساب العمر هنا قبل النداء
      final age = calculateAge(value);
      updateDob(value, age);
      break;
    case 'address':
      updateAddress(value);
      break;
    default:
      print('غير معروف الحقل: $fieldKey');
  }
}

// دالة مساعدة لحساب العمر من تاريخ الميلاد (صيغة التاريخ متوقعة yyyy-MM-dd)
String calculateAge(String dob) {
  try {
    final birthDate = DateTime.parse(dob);
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age.toString();
  } catch (e) {
    print('خطأ في حساب العمر: $e');
    return '';
  }
}
Future<void> saveField(String fieldKey) async {
  emit(state.copyWith(status: ProfileStatus.loading));
  logInfo('Saving field: $fieldKey');

  try {
    final firebaseUser = firebaseAuthService.getCurrentUser();
    if (firebaseUser == null) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        errorMessage: 'لم يتم تسجيل الدخول.',
      ));
      return;
    }

    // استخرج المستخدم الحالي أو قيم افتراضية
    final existingUser = loadedUser ??
        UserEntity(
          uId: firebaseUser.uid,
          email: firebaseUser.email ?? '',
          fullName: firebaseUser.displayName ?? '',
          emailVerified: firebaseUser.emailVerified,
          photoUrl: firebaseUser.photoURL,
        );

    // نسخة من الحقول الحالية مع تعديل الحقل الذي تريد حفظه فقط
    String updatedName = existingUser.fullName;
    String updatedEmail = existingUser.email;
    String? updatedPhone = existingUser.phone;
    String? updatedGender = existingUser.gender;
    String? updatedDob = existingUser.dob;
    String? updatedAge = existingUser.age;
    String? updatedAddress = existingUser.address;
    String? updatedPhotoUrl = existingUser.photoUrl;

    // حقل الصورة: لو تم تعديل الصورة، سيتم التعامل معها في saveProfile (تحديث الصورة هناك)

    switch (fieldKey) {
      case 'name':
        if (state.name.isEmpty) {
          emit(state.copyWith(
            status: ProfileStatus.error,
            errorMessage: 'الاسم لا يمكن أن يكون فارغًا.',
          ));
          return;
        }
        updatedName = state.name;
        break;

      case 'email':
        if (state.email.isEmpty) {
          emit(state.copyWith(
            status: ProfileStatus.error,
            errorMessage: 'البريد الإلكتروني لا يمكن أن يكون فارغًا.',
          ));
          return;
        }
        updatedEmail = state.email;
        break;

      case 'phone':
        if (state.phone.isNotEmpty) {
          if (!_isValidEgyptianPhone(state.phone)) {
            emit(state.copyWith(
              status: ProfileStatus.error,
              errorMessage: 'رقم الهاتف غير صالح. يجب أن يكون مصريًا بصيغة 01XXXXXXXXX',
            ));
            return;
          } else {
            updatedPhone = _formatEgyptianPhone(state.phone);
          }
        } else {
          updatedPhone = null;
        }
        break;

      case 'gender':
        updatedGender = state.gender.isNotEmpty ? state.gender : null;
        break;

      case 'dob':
        if (state.dob.isNotEmpty) {
          updatedDob = state.dob;
          updatedAge = state.age; // العمر يتم حسابه مسبقًا عند التحديث
        } else {
          updatedDob = null;
          updatedAge = null;
        }
        break;

      case 'address':
        updatedAddress = state.address.isNotEmpty ? state.address : null;
        break;

      default:
        emit(state.copyWith(
          status: ProfileStatus.error,
          errorMessage: 'حقل غير معروف: $fieldKey',
        ));
        return;
    }

    // بناء كيان المستخدم المحدث بالحقل الواحد
    final updatedUser = UserEntity(
      uId: firebaseUser.uid,
      email: updatedEmail,
      fullName: updatedName,
      phone: updatedPhone,
      gender: updatedGender,
      dob: updatedDob,
      age: updatedAge,
      address: updatedAddress,
      photoUrl: updatedPhotoUrl,
      emailVerified: existingUser.emailVerified,
    );

    // استدعاء تحديث بيانات المستخدم من الريبو
    final updateResult = await authRepo.updateUserData(updatedUser);

    bool updateFailed = false;

    updateResult.fold(
      (failure) {
        logError('Failed to update user data', failure.message);
        emit(state.copyWith(
          status: ProfileStatus.error,
          errorMessage: 'فشل تحديث الملف الشخصي: ${failure.message}',
        ));
        updateFailed = true;
      },
      (_) {
        loadedUser = updatedUser;
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

    if (updateFailed) return;

    // إذا كان الحقل المحفوظ هو البريد الإلكتروني، أرسل رابط التحقق
    if (fieldKey == 'email' && state.email != existingUser.email) {
      final sendEmailResult = await authRepo.sendEmailVerification();
      sendEmailResult.fold(
        (failure) {
          logError('Failed to send email verification', failure.message);
          emit(state.copyWith(
            status: ProfileStatus.error,
            errorMessage: 'تعذر إرسال رابط التحقق إلى البريد الإلكتروني.',
          ));
        },
        (_) {
          logInfo('Email verification sent');
        },
      );
    }
  } catch (e, st) {
    logError('Exception in saveField', e);
    print(st);
    emit(state.copyWith(
      status: ProfileStatus.error,
      errorMessage: 'حدث خطأ أثناء حفظ البيانات.',
    ));
  }
}
}
