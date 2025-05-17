import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pickpay/core/services/firebase_auth_service.dart';
import 'package:pickpay/core/services/get_it_service.dart';

import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/core/widgets/custom_button.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';
import 'package:pickpay/features/profile_change/cubits/cubit/profile_chnage_cubit.dart';
import 'package:pickpay/features/profile_change/cubits/cubit/profile_chnage_state.dart';

// Move genders list outside the widget class to a global constant
const List<String> genders = ['Male', 'Female'];

class ProfileChangeView extends StatelessWidget {
  const ProfileChangeView({super.key});

  static const routeName = 'profile_change';

  @override
  Widget build(BuildContext context) {
    final authRepo = getIt<AuthRepo>();
    final firebaseAuthService = getIt<FirebaseAuthService>();

    return BlocProvider(
      create: (context) => ProfileCubit(
        authRepo: authRepo,
        firebaseAuthService: firebaseAuthService,
      )..loadUserProfile(), // Load user data at start
      child: const _ProfileChangeViewContent(),
    );
  }
}

class _ProfileChangeViewContent extends StatefulWidget {
  const _ProfileChangeViewContent();

  @override
  State<_ProfileChangeViewContent> createState() =>
      _ProfileChangeViewContentState();
}

class _ProfileChangeViewContentState extends State<_ProfileChangeViewContent> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _ageController;
  late final TextEditingController _dobController;
  late final TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _ageController = TextEditingController();
    _dobController = TextEditingController();
    _addressController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 800,
      );

      if (pickedFile != null) {
        final file = File(pickedFile.path);
        context.read<ProfileCubit>().updateProfileImage(file);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: ${e.toString()}')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dobController.text.isNotEmpty
          ? DateTime.tryParse(_dobController.text) ?? DateTime.now()
          : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      final dob = DateFormat('yyyy-MM-dd').format(picked);
      final age = (DateTime.now().year - picked.year).toString();

      _dobController.text = dob;
      _ageController.text = age;

      context.read<ProfileCubit>().updateDob(dob, age);
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      await context.read<ProfileCubit>().saveProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    final fieldColor = isDarkMode ? Colors.grey[800] : Colors.grey[100];
    final borderColor = isDarkMode ? Colors.grey[700] : Colors.grey[200];

    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.loadSuccess) {
          // Populate text controllers only once when data is loaded
          if (_nameController.text.isEmpty && state.name.isNotEmpty) {
            _nameController.text = state.name;
          }
          if (_emailController.text.isEmpty && state.email.isNotEmpty) {
            _emailController.text = state.email;
          }
          if (_phoneController.text.isEmpty && state.phone.isNotEmpty) {
            _phoneController.text = state.phone;
          }
          if (_dobController.text.isEmpty && state.dob.isNotEmpty) {
            _dobController.text = state.dob;
          }
          if (_ageController.text.isEmpty && state.age.isNotEmpty) {
            _ageController.text = state.age;
          }
          if (_addressController.text.isEmpty && state.address.isNotEmpty) {
            _addressController.text = state.address;
          }
        } else if (state.status == ProfileStatus.saveSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully')),
          );
          context.read<ProfileCubit>().resetStatus();
          Navigator.pop(context);
        } else if (state.status == ProfileStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
          context.read<ProfileCubit>().resetStatus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Edit Profile',
            style: TextStyles.bold19,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          actions: [
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                return IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: state.status == ProfileStatus.loading
                      ? null
                      : _saveProfile,
                  tooltip: 'Save Profile',
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Image Section
                    Center(
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: isDarkMode
                                  ? Colors.grey[700]
                                  : Colors.grey[200],
                              backgroundImage: state.profileImage != null
                                  ? FileImage(state.profileImage!)
                                  : (state.profileImageUrl.isNotEmpty
                                      ? NetworkImage(state.profileImageUrl)
                                      : null) as ImageProvider<Object>?,
                              child: state.profileImage == null &&
                                      state.profileImageUrl.isEmpty
                                  ? const Icon(Icons.person, size: 60)
                                  : null,
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: theme.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.edit,
                                  size: 20, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Personal Information Section
                    Text('Personal Information',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        )),
                    const SizedBox(height: 16),

                    // Name Field
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        prefixIcon: const Icon(Icons.person_outline),
                        filled: true,
                        fillColor: fieldColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: borderColor!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: theme.primaryColor),
                        ),
                      ),
                      style: TextStyle(color: textColor),
                      onChanged: (value) =>
                          context.read<ProfileCubit>().updateName(value),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Email Field (read-only)
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email_outlined),
                        filled: true,
                        fillColor: fieldColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: theme.primaryColor),
                        ),
                      ),
                      style: TextStyle(color: textColor),
                      enabled: false,
                    ),
                    const SizedBox(height: 16),

                    // Phone Field
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        prefixIcon: const Icon(Icons.phone_outlined),
                        filled: true,
                        fillColor: fieldColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: theme.primaryColor),
                        ),
                      ),
                      style: TextStyle(color: textColor),
                      keyboardType: TextInputType.phone,
                      onChanged: (value) =>
                          context.read<ProfileCubit>().updatePhone(value),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Gender Radio Buttons
                    Row(
                      children: [
                        Text(
                          'Gender:',
                          style: TextStyles.medium15.copyWith(color: textColor),
                        ),
                        const SizedBox(width: 16),
                        ...genders.map(
                          (gender) => Expanded(
                            child: RadioListTile<String>(
                              contentPadding: EdgeInsets.zero,
                              title: Text(gender,
                                  style: TextStyle(color: textColor)),
                              value: gender,
                              groupValue: state.gender,
                              onChanged: (value) {
                                if (value != null) {
                                  context
                                      .read<ProfileCubit>()
                                      .updateGender(value);
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Date of Birth Field with Date Picker
                    TextFormField(
                      controller: _dobController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        prefixIcon: const Icon(Icons.calendar_today_outlined),
                        filled: true,
                        fillColor: fieldColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: theme.primaryColor),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.date_range),
                          onPressed: () => _selectDate(context),
                        ),
                      ),
                      style: TextStyle(color: textColor),
                      onTap: () => _selectDate(context),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your date of birth';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Age Field (read-only)
                    TextFormField(
                      controller: _ageController,
                      decoration: InputDecoration(
                        labelText: 'Age',
                        prefixIcon: const Icon(Icons.cake_outlined),
                        filled: true,
                        fillColor: fieldColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: theme.primaryColor),
                        ),
                      ),
                      style: TextStyle(color: textColor),
                      enabled: false,
                    ),
                    const SizedBox(height: 16),

                    // Address Field
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        labelText: 'Address',
                        prefixIcon: const Icon(Icons.location_on_outlined),
                        filled: true,
                        fillColor: fieldColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: theme.primaryColor),
                        ),
                      ),
                      style: TextStyle(color: textColor),
                      maxLines: 3,
                      onChanged: (value) =>
                          context.read<ProfileCubit>().updateAddress(value),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        buttonText: 'Save Profile',
                        onPressed: state.status == ProfileStatus.loading
                            ? null
                            : _saveProfile,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
