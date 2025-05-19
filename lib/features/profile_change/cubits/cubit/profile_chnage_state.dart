import 'package:equatable/equatable.dart';
import 'dart:io';

enum ProfileStatus { initial, loading, loadSuccess, saveSuccess, error ,saving  }

class ProfileState extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String gender;
  final String dob;
  final String age;
  final String address;
  final File? profileImage;      // Local image file (picked by user)
  final String profileImageUrl;  // Remote image URL (from Firebase)
  final ProfileStatus status;
  final String errorMessage;

  /// اسم الحقل الجاري تعديله حالياً، أو null إذا لا يوجد تعديل جاري
  final String? fieldBeingEdited;

  const ProfileState({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.gender = '',
    this.dob = '',
    this.age = '',
    this.address = '',
    this.profileImage,
    this.profileImageUrl = '',
    this.status = ProfileStatus.initial,
    this.errorMessage = '',
    this.fieldBeingEdited,
  });

  ProfileState copyWith({
    String? name,
    String? email,
    String? phone,
    String? gender,
    String? dob,
    String? age,
    String? address,
    File? profileImage,
    String? profileImageUrl,
    ProfileStatus? status,
    String? errorMessage,
    String? fieldBeingEdited,
  }) {
    return ProfileState(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      age: age ?? this.age,
      address: address ?? this.address,
      profileImage: profileImage ?? this.profileImage,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      fieldBeingEdited: fieldBeingEdited ?? this.fieldBeingEdited,
    );
  }

  @override
  List<Object?> get props => [
        name,
        email,
        phone,
        gender,
        dob,
        age,
        address,
        profileImage,
        profileImageUrl,
        status,
        errorMessage,
        fieldBeingEdited,
      ];
}
