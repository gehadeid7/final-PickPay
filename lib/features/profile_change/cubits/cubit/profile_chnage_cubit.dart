import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

import 'package:pickpay/features/profile_change/cubits/cubit/profile_chnage_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  void updateName(String name) {
    emit(state.copyWith(name: name));
  }

  void updateEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void updatePhone(String phone) {
    emit(state.copyWith(phone: phone));
  }

  void updateGender(String gender) {
    emit(state.copyWith(gender: gender));
  }

  void updateDob(String dob, String age) {
    emit(state.copyWith(dob: dob, age: age));
  }

  void updateAddress(String address) {
    emit(state.copyWith(address: address));
  }

  void updateProfileImage(File? image) {
    emit(state.copyWith(profileImage: image));
  }

  Future<void> saveProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    emit(state.copyWith(status: ProfileStatus.success));
  }

  void resetStatus() {
    emit(state.copyWith(status: ProfileStatus.initial));
  }
}
