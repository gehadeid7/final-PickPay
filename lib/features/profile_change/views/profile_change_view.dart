import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pickpay/core/services/firebase_auth_service.dart';
import 'package:pickpay/core/services/get_it_service.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';
import 'package:pickpay/features/profile_change/cubits/cubit/profile_chnage_cubit.dart';
import 'package:pickpay/features/profile_change/cubits/cubit/profile_chnage_state.dart';

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
      )..loadUserProfile(),
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
  late final FocusNode _nameFocus;

  late final TextEditingController _emailController;

  late final TextEditingController _phoneController;
  late final FocusNode _phoneFocus;

  late final TextEditingController _dobController;
  late final FocusNode _dobFocus;

  late final TextEditingController _ageController;

  late final TextEditingController _addressController;
  late final FocusNode _addressFocus;

  String? _selectedGender;
  String? _phoneError;
  bool _hasLoadedInitialData = false;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _nameFocus = FocusNode();
    _nameFocus.addListener(() {
      if (!_nameFocus.hasFocus) {
        context.read<ProfileCubit>().updateName(_nameController.text.trim());
      }
    });

    _emailController = TextEditingController();

    _phoneController = TextEditingController();
    _phoneFocus = FocusNode();
    _phoneFocus.addListener(() {
      if (!_phoneFocus.hasFocus) {
        context.read<ProfileCubit>().updatePhone(_phoneController.text.trim());
      }
    });

    _dobController = TextEditingController();
    _dobFocus = FocusNode();

    _ageController = TextEditingController();

    _addressController = TextEditingController();
    _addressFocus = FocusNode();
    _addressFocus.addListener(() {
      if (!_addressFocus.hasFocus) {
        context
            .read<ProfileCubit>()
            .updateAddress(_addressController.text.trim());
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocus.dispose();

    _emailController.dispose();

    _phoneController.dispose();
    _phoneFocus.dispose();

    _dobController.dispose();
    _dobFocus.dispose();

    _ageController.dispose();

    _addressController.dispose();
    _addressFocus.dispose();

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
        if (!file.existsSync()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Selected image file does not exist.')),
          );
          return;
        }
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
      helpText: 'Select your date of birth',
    );
    if (picked != null) {
      final dob = DateFormat('yyyy-MM-dd').format(picked);
      final age = (DateTime.now().year - picked.year).toString();

      setState(() {
        _dobController.text = dob;
        _ageController.text = age;
      });

      context.read<ProfileCubit>().updateDob(dob, age);
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    await context.read<ProfileCubit>().saveProfile();
  }

  void _loadInitialData(ProfileState state) {
    if (_hasLoadedInitialData) return;

    _nameController.text = state.name;
    _emailController.text = state.email;
    _phoneController.text = state.phone;
    _dobController.text = state.dob;
    _ageController.text = state.age;
    _addressController.text = state.address;
    _selectedGender = state.gender.isNotEmpty ? state.gender : null;

    _hasLoadedInitialData = true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final fieldColor = isDarkMode
        ? (Colors.grey[850] ?? Colors.grey)
        : Colors.white.withOpacity(0.9);
    final borderColor =
        isDarkMode ? (Colors.grey[700] ?? Colors.grey) : (Colors.grey[300] ?? Colors.grey);

    const Color gradientStart = Color(0xFF2193b0);
    const Color gradientEnd = Color(0xFF6dd5ed);

    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.loadSuccess) {
          _loadInitialData(state);
        }

        if (state.status == ProfileStatus.saveSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully')),
          );
          context.read<ProfileCubit>().resetStatus();
          Navigator.pop(context);
        }

        if (state.status == ProfileStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
          context.read<ProfileCubit>().resetStatus();
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Edit Profile', style: TextStyles.bold19),
          centerTitle: true,
          actions: [
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                return IconButton(
                  icon: const Icon(Icons.save),
                  tooltip: 'Save Profile',
                  onPressed:
                      state.status == ProfileStatus.loading ? null : _saveProfile,
                );
              },
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [gradientStart, gradientEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.white.withOpacity(0.3),
                                  backgroundImage: state.profileImage != null
                                      ? FileImage(state.profileImage!)
                                      : (state.profileImageUrl.isNotEmpty
                                          ? NetworkImage(state.profileImageUrl)
                                          : null) as ImageProvider<Object>?,
                                  child: state.profileImage == null &&
                                          state.profileImageUrl.isEmpty
                                      ? const Icon(Icons.person,
                                          size: 60, color: Colors.white)
                                      : null,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: theme.primaryColor,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(Icons.edit,
                                      size: 20, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        Text(
                          'Personal Information',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),

                        _NameField(
                          controller: _nameController,
                          focusNode: _nameFocus,
                          fieldColor: fieldColor,
                          borderColor: borderColor,
                        ),

                        const SizedBox(height: 16),

                        _EmailField(
                          controller: _emailController,
                          fieldColor: fieldColor,
                          borderColor: borderColor,
                        ),

                        const SizedBox(height: 16),

                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _PhoneField(
                              controller: _phoneController,
                              focusNode: _phoneFocus,
                              fieldColor: fieldColor,
                              borderColor: borderColor,
                            ),
                             if (_phoneError != null)
      Padding(
        padding: const EdgeInsets.only(top: 4.0, left: 12),
        child: Text(
          _phoneError!,
          style: TextStyle(color: Colors.red, fontSize: 12),
                              ),
      ),
  ],
),
                        const SizedBox(height: 16),

                        _DobField(
                          controller: _dobController,
                          ageController: _ageController,
                          focusNode: _dobFocus,
                          fieldColor: fieldColor,
                          borderColor: borderColor,
                          onTap: () => _selectDate(context),
                        ),

                        const SizedBox(height: 16),

                        _AgeField(
                          controller: _ageController,
                          fieldColor: fieldColor,
                          borderColor: borderColor,
                        ),

                        const SizedBox(height: 16),

                        _AddressField(
                          controller: _addressController,
                          focusNode: _addressFocus,
                          fieldColor: fieldColor,
                          borderColor: borderColor,
                        ),

                        const SizedBox(height: 16),

                        _GenderField(
                          selectedGender: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                            if (value != null) {
                              context.read<ProfileCubit>().updateGender(value);
                            }
                          },
                        ),

                        const SizedBox(height: 32),

                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24)),
                              elevation: 5,
                              backgroundColor: Colors.white.withOpacity(0.9),
                            ),
                            onPressed:
                                state.status == ProfileStatus.loading ? null : _saveProfile,
                            child: state.status == ProfileStatus.loading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.blue,
                                    ),
                                  )
                                : Text(
                                    'Save Changes',
                                    style: theme.textTheme.labelLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade700,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// Widgets for form fields to keep build clean

class _NameField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Color fieldColor;
  final Color borderColor;

  const _NameField({
    required this.controller,
    required this.focusNode,
    required this.fieldColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'Name',
        filled: true,
        fillColor: fieldColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Name is required';
        }
        if (value.trim().length < 3) {
          return 'Name must be at least 3 characters';
        }
        return null;
      },
    );
  }
}

class _EmailField extends StatelessWidget {
  final TextEditingController controller;
  final Color fieldColor;
  final Color borderColor;

  const _EmailField({
    required this.controller,
    required this.fieldColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Email (read-only)',
        filled: true,
        fillColor: fieldColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
      ),
    );
  }
}

class _PhoneField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Color fieldColor;
  final Color borderColor;

  const _PhoneField({
    required this.controller,
    required this.focusNode,
    required this.fieldColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        filled: true,
        fillColor: fieldColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(11),
      ],
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Phone number is required';
        }
        if (value.trim().length != 11) {
          return 'رقم الهاتف يجب أن يحتوي على 11 أرقام فقط';
        }
        return null;
      },
    );
  }
}


class _DobField extends StatelessWidget {
  final TextEditingController controller;
  final TextEditingController ageController;
  final FocusNode focusNode;
  final Color fieldColor;
  final Color borderColor;
  final VoidCallback onTap;

  const _DobField({
    required this.controller,
    required this.ageController,
    required this.focusNode,
    required this.fieldColor,
    required this.borderColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      readOnly: true,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: 'Date of Birth',
        filled: true,
        fillColor: fieldColor,
        suffixIcon: const Icon(Icons.calendar_today),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Date of birth is required';
        }
        return null;
      },
    );
  }
}

class _AgeField extends StatelessWidget {
  final TextEditingController controller;
  final Color fieldColor;
  final Color borderColor;

  const _AgeField({
    required this.controller,
    required this.fieldColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Age',
        filled: true,
        fillColor: fieldColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
      ),
    );
  }
}

class _AddressField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Color fieldColor;
  final Color borderColor;

  const _AddressField({
    required this.controller,
    required this.focusNode,
    required this.fieldColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      maxLines: 3,
      keyboardType: TextInputType.streetAddress,
      textInputAction: TextInputAction.newline,
      decoration: InputDecoration(
        labelText: 'Address',
        filled: true,
        fillColor: fieldColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Address is required';
        }
        return null;
      },
    );
  }
}

class _GenderField extends StatelessWidget {
  final String? selectedGender;
  final void Function(String?) onChanged;

  const _GenderField({
    required this.selectedGender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: 'Gender',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedGender,
          hint: const Text('Select gender'),
          isExpanded: true,
          items: genders
              .map((gender) =>
                  DropdownMenuItem(value: gender, child: Text(gender)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

