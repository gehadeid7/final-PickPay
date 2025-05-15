import 'package:equatable/equatable.dart';
import 'dart:io';

enum ProfileStatus { initial, loading, success, failure }

class ProfileState extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String gender;
  final String dob;
  final String age;
  final String address;
  final File? profileImage;
  final ProfileStatus status;

  const ProfileState({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.gender = '',
    this.dob = '',
    this.age = '',
    this.address = '',
    this.profileImage,
    this.status = ProfileStatus.initial,
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
    ProfileStatus? status,
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
      status: status ?? this.status,
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
        status,
      ];
}
