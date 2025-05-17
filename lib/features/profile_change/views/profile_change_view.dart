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
  State<_ProfileChangeViewContent> createState() => _ProfileChangeViewContentState();
}

class _ProfileChangeViewContentState extends State<_ProfileChangeViewContent> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _ageController;
  late final TextEditingController _dobController;
  late final TextEditingController _addressController;

  String? _selectedGender;

  bool _hasLoadedInitialData = false;

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
        _hasLoadedInitialData = true;
      });

      context.read<ProfileCubit>().updateDob(dob, age);
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    await context.read<ProfileCubit>().saveProfile();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final fieldColor = isDarkMode ? (Colors.grey[850] ?? Colors.grey) : Colors.white.withOpacity(0.9);
    final borderColor = isDarkMode ? (Colors.grey[700] ?? Colors.grey) : (Colors.grey[300] ?? Colors.grey);

    const Color gradientStart = Color(0xFF2193b0);
    const Color gradientEnd = Color(0xFF6dd5ed);

    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.loadSuccess && !_hasLoadedInitialData) {
          _nameController.text = state.name;
          _emailController.text = state.email;
          _phoneController.text = state.phone;
          _dobController.text = state.dob;
          _ageController.text = state.age;
          _addressController.text = state.address;
          _selectedGender = state.gender.isNotEmpty ? state.gender : null;
          _hasLoadedInitialData = true;
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
                  onPressed: state.status == ProfileStatus.loading ? null : _saveProfile,
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
                                  child: state.profileImage == null && state.profileImageUrl.isEmpty
                                      ? const Icon(Icons.person, size: 60, color: Colors.white)
                                      : null,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: theme.primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.edit, size: 20, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        Text('Personal Information',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _nameController,
                          onChanged: (val) => context.read<ProfileCubit>().updateName(val.trim()),
                          decoration: _inputDecoration(
                            context,
                            label: 'Full Name',
                            icon: Icons.person_outline,
                            fieldColor: fieldColor,
                            borderColor: borderColor,
                          ),
                          validator: (value) => value == null || value.isEmpty ? 'Name cannot be empty' : null,
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _emailController,
                          decoration: _inputDecoration(
                            context,
                            label: 'Email',
                            icon: Icons.email_outlined,
                            fieldColor: fieldColor,
                            borderColor: borderColor,
                          ),
                          enabled: false,
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(11),
                          ],
                          decoration: _inputDecoration(
                            context,
                            label: 'رقم الهاتف',
                            icon: Icons.phone_outlined,
                            fieldColor: fieldColor,
                            borderColor: borderColor,
                          ).copyWith(prefixText: '+20 '),
                          validator: (value) {
                            if (value == null || value.length != 11) return 'أدخل 11 رقمًا صحيحًا';
                            return null;
                          },
                          onChanged: (val) => context.read<ProfileCubit>().updatePhone(val.trim()),
                        ),
                        const SizedBox(height: 16),

                        DropdownButtonFormField<String>(
                          value: _selectedGender,
                          items: genders.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                          onChanged: (value) {
                            setState(() => _selectedGender = value);
                            if (value != null) context.read<ProfileCubit>().updateGender(value);
                          },
                          decoration: _inputDecoration(
                            context,
                            label: 'Gender',
                            icon: Icons.transgender_outlined,
                            fieldColor: fieldColor,
                            borderColor: borderColor,
                          ),
                          validator: (value) => value == null ? 'Select gender' : null,
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _dobController,
                          readOnly: true,
                          decoration: _inputDecoration(
                            context,
                            label: 'Date of Birth',
                            icon: Icons.calendar_today_outlined,
                            fieldColor: fieldColor,
                            borderColor: borderColor,
                          ),
                          onTap: () => _selectDate(context),
                          validator: (value) => value == null || value.isEmpty ? 'Select date' : null,
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _ageController,
                          readOnly: true,
                          decoration: _inputDecoration(
                            context,
                            label: 'Age',
                            icon: Icons.cake_outlined,
                            fieldColor: fieldColor,
                            borderColor: borderColor,
                          ),
                          validator: (value) => value == null || value.isEmpty ? 'Age not calculated' : null,
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _addressController,
                          minLines: 2,
                          maxLines: 5,
                          onChanged: (val) => context.read<ProfileCubit>().updateAddress(val.trim()),
                          decoration: _inputDecoration(
                            context,
                            label: 'Address',
                            icon: Icons.home_outlined,
                            fieldColor: fieldColor,
                            borderColor: borderColor,
                          ),
                          validator: (value) => value == null || value.isEmpty ? 'Enter address' : null,
                        ),
                        const SizedBox(height: 32),

                        BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (context, state) {
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: state.status == ProfileStatus.loading ? null : _saveProfile,
                                child: state.status == ProfileStatus.loading
                                    ? const SizedBox(
                                        height: 22,
                                        width: 22,
                                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                      )
                                    : const Text('Save Changes'),
                              ),
                            );
                          },
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

  InputDecoration _inputDecoration(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Color fieldColor,
    required Color borderColor,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
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
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
      ),
    );
  }
}
