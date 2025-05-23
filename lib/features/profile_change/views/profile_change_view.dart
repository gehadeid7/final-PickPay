// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:async';
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
import 'dart:developer' as developer;
import 'package:another_flushbar/flushbar.dart';

const Map<String, String> genderMap = {
  'Male': 'Male',
  'Female': 'Female',
  'ذكر': 'Male', // Map Arabic values to English
  'انثي': 'Female', // Map Arabic values to English
};

const List<String> genders = ['Male', 'Female'];

class ProfileValidationConstants {
  static const int maxNameLength = 50;
  static const int maxAddressLength = 200;
  static const int maxFileSizeInMB = 5;
}

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

class _ProfileChangeViewContentState extends State<_ProfileChangeViewContent>
    with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  StreamSubscription<ProfileState>? _stateSubscription;

  // Controllers
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _genderController;
  late TextEditingController _dobController;
  late TextEditingController _ageController;
  late TextEditingController _addressController;

  // Focus nodes
  late FocusNode _nameFocus;
  late FocusNode _emailFocus;
  late FocusNode _phoneFocus;
  late FocusNode _genderFocus;
  late FocusNode _dobFocus;
  late FocusNode _ageFocus;
  late FocusNode _addressFocus;

  // State variables
  bool _isLoading = false;
  bool _isImageLoading = false;
  String _profileImageUrl = '';
  final _scrollController = ScrollController();

  // Field change tracking
  String _selectedGender = '';
  final Map<String, String> _fieldChanges = {};
  bool _isInitialized = false;
  bool _isSaving = false;

  // Formatters
  final _phoneFormatter = FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));

  // Add a flag to track image saving
  bool _isSavingImage = false;

  // Logging methods
  void _logInfo(String message) {
    developer.log('ProfileChangeView: $message');
  }

  void _logError(String message, [dynamic error, StackTrace? stackTrace]) {
    developer.log(
      'ProfileChangeView: $message',
      error: error,
      stackTrace: stackTrace,
    );
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _initializeState() {
    _logInfo('🔄 Initializing state variables');

    // Initialize controllers
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _genderController = TextEditingController();
    _dobController = TextEditingController();
    _ageController = TextEditingController();
    _addressController = TextEditingController();

    // Initialize focus nodes
    _nameFocus = FocusNode();
    _emailFocus = FocusNode();
    _phoneFocus = FocusNode();
    _genderFocus = FocusNode();
    _dobFocus = FocusNode();
    _ageFocus = FocusNode();
    _addressFocus = FocusNode();
  }

  void _handleFieldChange(String value, String fieldName) {
    _logInfo('📝 Field changed: $fieldName = $value');
    _logInfo('Current state value: ${getCurrentValue(fieldName)}');
    _logInfo('Current field changes before update: $_fieldChanges');

    // Only track changes if the value is different from current state
    if (value != getCurrentValue(fieldName)) {
      setState(() {
        _fieldChanges[fieldName] = value;
        _logInfo('Updated field changes: $_fieldChanges');
      });

      // Update the cubit state immediately
      final cubit = context.read<ProfileCubit>();
      _logInfo('Current cubit state before update: ${cubit.state.toMap()}');

      switch (fieldName) {
        case 'name':
          cubit.updateName(value);
          break;
        case 'phone':
          cubit.updatePhone(value);
          break;
        case 'address':
          _logInfo('Updating address to: $value');
          cubit.updateAddress(value);
          break;
        case 'gender':
          _logInfo('Updating gender to: $value');
          // Map the gender value if needed
          final mappedGender = genderMap[value] ?? value;
          _logInfo('Mapped gender value: $mappedGender');
          cubit.updateGender(mappedGender);
          break;
        case 'dob':
          _logInfo('Updating DOB to: $value with age: ${_ageController.text}');
          cubit.updateDob(value, _ageController.text);
          break;
      }

      _logInfo('Cubit state after update: ${cubit.state.toMap()}');
    } else {
      setState(() {
        _fieldChanges.remove(fieldName);
        _logInfo('Removed field from changes: $fieldName');
      });
    }
  }

  FocusNode? _getFocusNode(String fieldName) {
    switch (fieldName) {
      case 'name':
        return _nameFocus;
      case 'email':
        return _emailFocus;
      case 'phone':
        return _phoneFocus;
      case 'gender':
        return _genderFocus;
      case 'dob':
        return _dobFocus;
      case 'age':
        return _ageFocus;
      case 'address':
        return _addressFocus;
      default:
        return null;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime initialDate = _dobController.text.isNotEmpty
        ? DateTime.tryParse(_dobController.text) ??
            DateTime(now.year - 18, now.month, now.day)
        : DateTime(now.year - 18, now.month, now.day);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
              surface: Theme.of(context).cardColor,
              onSurface:
                  Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
            ),
            dialogBackgroundColor: Theme.of(context).cardColor,
          ),
          child: child!,
        );
      },
    );

    if (picked != null && mounted) {
      final dob = DateFormat('yyyy-MM-dd').format(picked);
      final age = (DateTime.now().year - picked.year).toString();

      setState(() {
        _dobController.text = dob;
        _ageController.text = age;
        _fieldChanges['dob'] = dob;
        _fieldChanges['age'] = age;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _logInfo('🔄 Initializing ProfileChangeView');
    WidgetsBinding.instance.addObserver(this);
    _initializeState();
    _setupStateListener();
    // Load fresh data when view is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }

  @override
  void dispose() {
    _logInfo('🧹 Disposing ProfileChangeView');
    WidgetsBinding.instance.removeObserver(this);
    _stateSubscription?.cancel();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _genderController.dispose();
    _dobController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _genderFocus.dispose();
    _dobFocus.dispose();
    _ageFocus.dispose();
    _addressFocus.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _logInfo('🔄 App resumed, reloading profile data');
      _loadInitialData();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reload data when dependencies change (e.g., when returning to this screen)
    _logInfo('🔄 Dependencies changed, reloading profile data');
    _loadInitialData();
  }

  void _setupStateListener() {
    _logInfo('🔄 Setting up state listener');
    _stateSubscription = context.read<ProfileCubit>().stream.listen((state) {
      _logInfo('📱 Received state update: ${state.status}');

      if (!mounted) return;

      if (state.status == ProfileStatus.loadSuccess ||
          state.status == ProfileStatus.saveSuccess) {
        _logInfo('✅ Updating UI with new data');

        // Always update with the latest data from state
        setState(() {
          // Update controllers with fresh data
          _nameController.text = state.name;
          _emailController.text = state.email;

          // Handle phone number format
          String phoneNumber = state.phone;
          if (phoneNumber.startsWith('+20')) {
            phoneNumber = '0${phoneNumber.substring(3)}';
          }
          _phoneController.text = phoneNumber;

          // Update other fields
          _genderController.text = state.gender;
          _dobController.text = state.dob;
          _ageController.text = state.age;
          _addressController.text = state.address;
          _profileImageUrl = state.profileImageUrl;

          // Handle gender mapping
          String gender = state.gender;
          if (genderMap.containsKey(gender)) {
            gender = genderMap[gender]!;
          }
          _selectedGender = gender;

          // Clear any pending changes after successful save
          if (state.status == ProfileStatus.saveSuccess) {
            _fieldChanges.clear();
            _isSaving = false;
            _isImageLoading = false;

            // Show success message
            _showMessage('Profile updated successfully', isSaveMessage: true);
          }

          _isLoading = false;
          _isInitialized = true;
        });

        // Log the current state for debugging
        _logInfo('Current state after update:');
        _logInfo('Name: ${state.name}');
        _logInfo('Email: ${state.email}');
        _logInfo('Phone: ${state.phone}');
        _logInfo('Gender: ${state.gender}');
        _logInfo('DOB: ${state.dob}');
        _logInfo('Age: ${state.age}');
        _logInfo('Address: ${state.address}');
      } else if (state.status == ProfileStatus.loading) {
        _logInfo('⏳ Loading state detected');
        setState(() => _isLoading = true);
      } else if (state.status == ProfileStatus.error) {
        _logInfo('❌ Error state detected: ${state.errorMessage}');
        setState(() {
          _isLoading = false;
          _isSaving = false;
          _isImageLoading = false;
        });
        if (state.errorMessage.isNotEmpty) {
          _showErrorSnackBar(state.errorMessage);
        }
      }
    });
  }

  Future<void> _loadInitialData() async {
    _logInfo('🔄 Loading initial data (hybrid strategy)');
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _isInitialized = false; // Reset initialization state
      _fieldChanges.clear(); // Clear any pending changes
    });

    try {
      final cubit = context.read<ProfileCubit>();

      // First, try to load from cache immediately
      _logInfo('📱 Attempting to load from cache first');
      await cubit.loadCachedUserProfile();

      // Then, in parallel, try to load from backend
      _logInfo('🌐 Loading from backend in parallel');
      final backendFuture = cubit.loadUserProfile();

      // Wait for backend load to complete
      await backendFuture;

      // Log the current state after loading
      final currentState = cubit.state;
      _logInfo('Current state after hybrid loading:');
      _logInfo('Status: ${currentState.status}');
      _logInfo('Name: ${currentState.name}');
      _logInfo('Email: ${currentState.email}');
      _logInfo('Phone: ${currentState.phone}');
      _logInfo('Gender: ${currentState.gender}');
      _logInfo('DOB: ${currentState.dob}');
      _logInfo('Age: ${currentState.age}');
      _logInfo('Address: ${currentState.address}');

      // Update UI with the latest data
      if (mounted) {
        setState(() {
          _nameController.text = currentState.name;
          _emailController.text = currentState.email;

          // Handle phone number format
          String phoneNumber = currentState.phone;
          if (phoneNumber.startsWith('+20')) {
            phoneNumber = '0${phoneNumber.substring(3)}';
          }
          _phoneController.text = phoneNumber;

          // Update other fields
          _genderController.text = currentState.gender;
          _dobController.text = currentState.dob;
          _ageController.text = currentState.age;
          _addressController.text = currentState.address;
          _profileImageUrl = currentState.profileImageUrl;

          // Handle gender mapping
          String gender = currentState.gender;
          if (genderMap.containsKey(gender)) {
            gender = genderMap[gender]!;
          }
          _selectedGender = gender;

          _isInitialized = true;
        });
      }
    } catch (e) {
      _logError('Failed to load initial data', e);
      if (mounted) {
        _showErrorSnackBar('فشل تحميل البيانات');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  // Update the handle save method to prevent duplicate image saves
  void _handleSave() async {
    _logInfo('🔄 Handling save action');
    _logInfo('Current field changes: $_fieldChanges');
    if (!mounted || _isSaving) return;

    setState(() => _isSaving = true);

    try {
      // Validate form before saving
      if (!_formKey.currentState!.validate()) {
        _logInfo('❌ Form validation failed');
        setState(() => _isSaving = false);
        return;
      }

      // Update all changed fields in the cubit
      final cubit = context.read<ProfileCubit>();
      _logInfo('Current cubit state before save: ${cubit.state.toMap()}');

      // Sync all field changes with cubit state before saving
      for (final entry in _fieldChanges.entries) {
        _logInfo('Processing field change: ${entry.key} = ${entry.value}');
        switch (entry.key) {
          case 'name':
            cubit.updateName(entry.value);
            break;
          case 'phone':
            cubit.updatePhone(entry.value);
            break;
          case 'gender':
            // Map the gender value if needed
            final mappedGender = genderMap[entry.value] ?? entry.value;
            _logInfo('Saving mapped gender value: $mappedGender');
            cubit.updateGender(mappedGender);
            break;
          case 'dob':
            _logInfo(
                'Saving DOB: ${entry.value} with age: ${_ageController.text}');
            cubit.updateDob(entry.value, _ageController.text);
            break;
          case 'address':
            _logInfo('Saving address: ${entry.value}');
            cubit.updateAddress(entry.value);
            break;
        }
        _logInfo(
            'Cubit state after updating ${entry.key}: ${cubit.state.toMap()}');
      }

      // Save all changes except image
      _logInfo('Final cubit state before save: ${cubit.state.toMap()}');
      await cubit.saveProfileWithoutImage();

      // Log the current state after save
      final currentState = cubit.state;
      _logInfo('Current state after save:');
      _logInfo('Status: ${currentState.status}');
      _logInfo('Name: ${currentState.name}');
      _logInfo('Email: ${currentState.email}');
      _logInfo('Phone: ${currentState.phone}');
      _logInfo('Gender: ${currentState.gender}');
      _logInfo('DOB: ${currentState.dob}');
      _logInfo('Age: ${currentState.age}');
      _logInfo('Address: ${currentState.address}');

      // Clear field changes after successful save
      setState(() {
        _fieldChanges.clear();
        _isSaving = false;
      });
    } catch (e) {
      _logError('Failed to save profile', e);
      if (mounted) {
        _showMessage('Failed to save profile', isError: true);
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Future<void> _pickImage() async {
    try {
      setState(() => _isImageLoading = true);

      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (pickedFile != null) {
        final file = File(pickedFile.path);
        if (!file.existsSync()) {
          if (!mounted) return;
          _showMessage('Selected image file does not exist.', isError: true);
          return;
        }

        // Get file size
        final fileSize = await file.length();
        developer
            .log('ProfileChangeView: Selected image size: ${fileSize} bytes');

        // If file is too large, show warning
        if (fileSize > 5 * 1024 * 1024) {
          // 5MB
          if (!mounted) return;
          _showMessage('Image is too large. Please select a smaller image.',
              isError: true);
          return;
        }

        // Update the UI immediately with the local image
        setState(() {
          _isImageLoading = true;
        });

        // Update the cubit with the new image
        final cubit = context.read<ProfileCubit>();
        cubit.updateProfileImage(file);

        // Don't save immediately, wait for user to click save button
        setState(() {
          _isImageLoading = false;
        });
      }
    } catch (e) {
      developer.log('ProfileChangeView: Error picking image', error: e);
      if (!mounted) return;
      _showMessage('Failed to pick image: ${e.toString()}', isError: true);
    } finally {
      if (mounted) {
        setState(() => _isImageLoading = false);
      }
    }
  }

  // Update the save image method to prevent multiple calls
  Future<void> _saveImage() async {
    if (!mounted || _isSavingImage) return;

    setState(() {
      _isSavingImage = true;
      _isImageLoading = true;
    });

    try {
      final cubit = context.read<ProfileCubit>();
      if (cubit.state.profileImage != null) {
        // Only save the image, not the entire profile
        await cubit.saveProfileImage();
        _showMessage('Profile image updated successfully', isSaveMessage: true);
      }
    } catch (e) {
      _logError('Failed to save profile image', e);
      if (mounted) {
        _showMessage('Failed to save profile image', isError: true);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isImageLoading = false;
          _isSavingImage = false;
        });
      }
    }
  }

  Widget _buildProfileImage(ProfileState state) {
    developer.log('ProfileChangeView: Building profile image widget');
    developer.log('ProfileChangeView: Current state status: ${state.status}');
    developer
        .log('ProfileChangeView: Current image URL: ${state.profileImageUrl}');
    developer.log(
        'ProfileChangeView: Has local image: ${state.profileImage != null}');

    return _ProfileImageWidget(
      imageUrl: state.profileImageUrl,
      localImage: state.profileImage,
      isLoading: _isImageLoading || state.status == ProfileStatus.loading,
      onTap: () {
        if (!_isImageLoading) {
          developer
              .log('ProfileChangeView: Image tapped, starting pick process');
          _pickImage();
        }
      },
      onSave: state.profileImage != null
          ? () {
              if (!_isImageLoading) {
                developer.log('ProfileChangeView: Save button tapped');
                _saveImage(); // Use the dedicated save method
              }
            }
          : null,
    );
  }

  void _showMessage(String message,
      {bool isError = false, bool isSaveMessage = false}) {
    if (!mounted) return;

    // Use Flushbar instead of SnackBar for better visibility
    Flushbar(
      message: message,
      messageColor: Colors.white,
      backgroundColor: isError ? Colors.red.shade700 : Colors.green.shade700,
      duration: const Duration(seconds: 2),
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      icon: Icon(
        isError ? Icons.error_outline : Icons.check_circle_outline,
        color: Colors.white,
      ),
    ).show(context);
  }

  Future<void> _onRefresh() async {
    _logInfo('🔄 Manual refresh triggered');
    try {
      await _loadInitialData();
    } catch (e) {
      if (mounted) {
        _showMessage('Failed to update data',
            isError: true, isSaveMessage: true);
      }
    }
  }

  Future<bool> _onWillPop() async {
    if (_fieldChanges.isEmpty) return true;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Do you want to exit?'),
        content: const Text(
            'You have unsaved changes. Do you want to exit without saving?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Exit'),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white.withOpacity(0.9)),
          const SizedBox(width: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingSkeleton() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Update getCurrentValue to handle null states
  String getCurrentValue(String fieldName) {
    try {
      final state = context.read<ProfileCubit>().state;
      if (state.status == ProfileStatus.initial) return '';

      switch (fieldName) {
        case 'name':
          return state.name;
        case 'phone':
          String phone = state.phone;
          if (phone.startsWith('+20')) {
            phone = '0${phone.substring(3)}';
          }
          return phone;
        case 'address':
          return state.address;
        case 'gender':
          String gender = state.gender;
          return genderMap[gender] ?? gender;
        case 'dob':
          return state.dob;
        case 'age':
          return state.age;
        default:
          return '';
      }
    } catch (e) {
      developer.log('Error in getCurrentValue: $e');
      return '';
    }
  }

  // Update _buildFieldWithSaveCancel to handle auto-save
  Widget _buildFieldWithSaveCancel({
    required String fieldName,
    required String label,
    required dynamic controller,
    required Function(String) onSave,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int? maxLines,
    IconData? prefixIcon,
    String? hintText,
    List<TextInputFormatter>? inputFormatters,
  }) {
    // Special handling for DOB field
    if (fieldName == 'dob') {
      return TextFormField(
        controller: controller as TextEditingController,
        focusNode: _getFocusNode(fieldName),
        readOnly: true,
        onTap: () => _selectDate(context),
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText ?? 'Select date of birth',
          prefixIcon: Icon(prefixIcon ?? Icons.calendar_today_outlined),
          filled: true,
          fillColor: Theme.of(context).cardColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Theme.of(context).dividerColor),
          ),
        ),
        validator: validator,
      );
    }

    // Special handling for different field types
    if (fieldName == 'phone') {
      return _buildPhoneField();
    }
    if (fieldName == 'address') {
      return _buildAddressField();
    }
    if (fieldName == 'gender') {
      return _GenderField(
        selectedGender: _selectedGender,
        onChanged: (value) {
          if (value != null && mounted) {
            setState(() {
              _selectedGender = value;
              _fieldChanges['gender'] = value;
            });
          }
        },
        onSave: (_) {}, // Empty callback since we're not auto-saving
        fieldColor: Theme.of(context).cardColor,
        borderColor: Theme.of(context).dividerColor,
        focusNode: _genderFocus,
      );
    }

    // For read-only fields
    if (fieldName == 'email' || fieldName == 'age') {
      return TextFormField(
        controller: controller as TextEditingController,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Theme.of(context).cardColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Theme.of(context).dividerColor),
          ),
        ),
      );
    }

    // For editable text fields
    if (controller is TextEditingController) {
      return TextFormField(
        controller: controller,
        focusNode: _getFocusNode(fieldName),
        onChanged: (value) => _handleFieldChange(value, fieldName),
        textInputAction: TextInputAction.next,
        style: const TextStyle(fontSize: 16),
        keyboardType: keyboardType,
        maxLines: maxLines,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText ?? 'Enter $label',
          prefixIcon: Icon(prefixIcon ?? Icons.person_outline),
          filled: true,
          fillColor: Theme.of(context).cardColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Theme.of(context).dividerColor),
          ),
        ),
        validator: validator,
      );
    }

    return const SizedBox.shrink();
  }

  // Update _buildPhoneField to remove auto-save
  Widget _buildPhoneField() {
    return TextFormField(
      controller: _phoneController,
      focusNode: _getFocusNode('phone'),
      onChanged: (value) {
        if (!mounted) return;
        if (value.trim().isNotEmpty && value != getCurrentValue('phone')) {
          setState(() {
            _fieldChanges['phone'] = value; // Store the actual value
          });
        }
      },
      textInputAction: TextInputAction.next,
      style: const TextStyle(fontSize: 16),
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(11),
      ],
      decoration: InputDecoration(
        labelText: 'Phone Number',
        hintText: 'Enter your phone number',
        prefixIcon: Icon(Icons.phone_outlined),
        prefixText: '+',
        prefixStyle: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge?.color,
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        fillColor: Theme.of(context).cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Phone number is required';
        }
        if (value.trim().length != 11) {
          return 'Phone number must be 11 digits';
        }
        if (!value.startsWith('01')) {
          // Updated to be consistent with _saveAllChanges
          return 'Phone number must start with 01';
        }
        return null;
      },
    );
  }

  // Update _buildAddressField to remove auto-save
  Widget _buildAddressField() {
    return TextFormField(
      controller: _addressController,
      focusNode: _getFocusNode('address'),
      onChanged: (value) {
        if (!mounted) return;
        if (value.trim().isNotEmpty && value != getCurrentValue('address')) {
          setState(() {
            _fieldChanges['address'] = value; // Store the actual value
          });
        }
      },
      textInputAction: TextInputAction.done,
      style: const TextStyle(fontSize: 16),
      keyboardType: TextInputType.streetAddress,
      maxLines: 2,
      decoration: InputDecoration(
        labelText: 'Address',
        hintText: 'Enter your address',
        prefixIcon: Icon(Icons.location_on_outlined),
        filled: true,
        fillColor: Theme.of(context).cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Address is required';
        }
        if (value.trim().length > ProfileValidationConstants.maxAddressLength) {
          return 'Address must not exceed ${ProfileValidationConstants.maxAddressLength} characters';
        }
        return null;
      },
    );
  }

  // Update _GenderField to remove auto-save
  Widget _GenderField({
    required String selectedGender,
    required void Function(String?) onChanged,
    required void Function(String) onSave,
    required Color fieldColor,
    required Color borderColor,
    required FocusNode focusNode,
  }) {
    return DropdownButtonFormField<String>(
      value: selectedGender.isEmpty ? null : selectedGender,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: 'Gender',
        prefixIcon: const Icon(Icons.person_outline),
        filled: true,
        fillColor: fieldColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
      ),
      items: genders.map((gender) {
        return DropdownMenuItem<String>(
          value: gender,
          child: Text(gender),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
          onSave(value);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a gender';
        }
        return null;
      },
    );
  }

  // Update the save button UI to be more compact and fixed
  Widget _buildSaveButton(bool isSaving) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (_fieldChanges.isNotEmpty)
              Expanded(
                child: Text(
                  '${_fieldChanges.length} field${_fieldChanges.length > 1 ? 's' : ''} changed',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    fontSize: 12,
                  ),
                ),
              ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: isSaving ? null : _handleSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: isSaving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Modern gradient colors
    const Color gradientStart = Color(0xFF1A237E); // Deep Indigo
    const Color gradientEnd = Color(0xFF0D47A1); // Darker Blue

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [gradientStart, gradientEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if (!mounted) return;

                if (state.status == ProfileStatus.loadSuccess) {
                  // Update UI with new state data
                  setState(() {
                    _nameController.text = state.name;
                    _emailController.text = state.email;

                    // Handle phone number format
                    String phoneNumber = state.phone;
                    if (phoneNumber.startsWith('+20')) {
                      phoneNumber = '0${phoneNumber.substring(3)}';
                    }
                    _phoneController.text = phoneNumber;

                    // Update other fields
                    _genderController.text = state.gender;
                    _dobController.text = state.dob;
                    _ageController.text = state.age;
                    _addressController.text = state.address;
                    _profileImageUrl = state.profileImageUrl;

                    // Handle gender mapping
                    String gender = state.gender;
                    if (genderMap.containsKey(gender)) {
                      gender = genderMap[gender]!;
                    }
                    _selectedGender = gender;

                    if (!_isInitialized) {
                      _isInitialized = true;
                    }
                  });
                }

                if (state.status == ProfileStatus.error) {
                  setState(() {
                    _isSaving = false;
                    _isImageLoading = false;
                  });
                  if (state.errorMessage.isNotEmpty) {
                    _showMessage(state.errorMessage, isError: true);
                  }
                  context.read<ProfileCubit>().resetStatus();
                }

                if (state.status == ProfileStatus.saveSuccess) {
                  setState(() {
                    _fieldChanges.clear();
                    _isSaving = false;
                    _isImageLoading = false;
                  });
                  _showMessage('Profile updated successfully',
                      isSaveMessage: true);
                  // Force reload after successful save
                  _loadInitialData();
                }
              },
              builder: (context, state) {
                // Show loading skeleton while initializing
                if (!_isInitialized && state.status == ProfileStatus.initial) {
                  return _buildLoadingSkeleton();
                }

                final isImageLoading = state.status == ProfileStatus.loading &&
                    state.fieldBeingEdited == 'photoUrl';
                final isSaving = state.status == ProfileStatus.loading &&
                    state.fieldBeingEdited == 'save';
                final isLoading = state.status == ProfileStatus.loading;

                print('Name controller: ${_nameController.text}');
                print('Phone controller: ${_phoneController.text}');
                print('Address controller: ${_addressController.text}');

                return Scaffold(
                  extendBody: true,
                  extendBodyBehindAppBar: true,
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child:
                            const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      onPressed:
                          isLoading ? null : () => Navigator.pop(context),
                    ),
                    title: Text(
                      'Edit Profile',
                      style: TextStyles.bold19.copyWith(
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(0, 1),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
                    centerTitle: true,
                  ),
                  bottomNavigationBar: _fieldChanges.isNotEmpty
                      ? _buildSaveButton(isSaving)
                      : null,
                  body: Stack(
                    children: [
                      RefreshIndicator(
                        key: _refreshKey,
                        onRefresh: _onRefresh,
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.only(
                            bottom: _fieldChanges.isNotEmpty
                                ? 80
                                : 16, // Add padding when save button is visible
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildProfileImage(state),
                                _buildSectionHeader('Personal Information',
                                    Icons.person_outline),
                                Card(
                                  elevation: 4,
                                  shadowColor: Colors.black.withOpacity(0.2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                        _buildFieldWithSaveCancel(
                                          fieldName: 'name',
                                          label: 'Full Name',
                                          controller: _nameController,
                                          onSave: (_) => _handleSave(),
                                          prefixIcon: Icons.person_outline,
                                          hintText: 'Enter your full name',
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return 'Name is required';
                                            }
                                            if (value.trim().length < 3) {
                                              return 'Name must be at least 3 characters';
                                            }
                                            if (value.trim().length >
                                                ProfileValidationConstants
                                                    .maxNameLength) {
                                              return 'Name must not exceed ${ProfileValidationConstants.maxNameLength} characters';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 16),
                                        _buildFieldWithSaveCancel(
                                          fieldName: 'email',
                                          label: 'Email Address',
                                          controller: _emailController,
                                          onSave: (_) => _handleSave(),
                                          prefixIcon: Icons.email_outlined,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                        ),
                                        const SizedBox(height: 16),
                                        _buildFieldWithSaveCancel(
                                          fieldName: 'phone',
                                          label: 'Phone Number',
                                          controller: _phoneController,
                                          onSave: (_) => _handleSave(),
                                          prefixIcon: Icons.phone_outlined,
                                          hintText: 'Enter your phone number',
                                          keyboardType: TextInputType.phone,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                _buildSectionHeader('Additional Information',
                                    Icons.info_outline),
                                Card(
                                  elevation: 4,
                                  shadowColor: Colors.black.withOpacity(0.2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                        _buildFieldWithSaveCancel(
                                          fieldName: 'dob',
                                          label: 'Date of Birth',
                                          controller: _dobController,
                                          onSave: (_) => _handleSave(),
                                          prefixIcon:
                                              Icons.calendar_today_outlined,
                                          hintText: 'Select your date of birth',
                                        ),
                                        const SizedBox(height: 16),
                                        _buildFieldWithSaveCancel(
                                          fieldName: 'age',
                                          label: 'Age',
                                          controller: _ageController,
                                          onSave: (_) => _handleSave(),
                                          prefixIcon: Icons.cake_outlined,
                                        ),
                                        const SizedBox(height: 16),
                                        _buildFieldWithSaveCancel(
                                          fieldName: 'address',
                                          label: 'Address',
                                          controller: _addressController,
                                          onSave: (_) => _handleSave(),
                                          prefixIcon:
                                              Icons.location_on_outlined,
                                          hintText: 'Enter your address',
                                          keyboardType:
                                              TextInputType.streetAddress,
                                          maxLines: 2,
                                        ),
                                        const SizedBox(height: 16),
                                        _buildFieldWithSaveCancel(
                                          fieldName: 'gender',
                                          label: 'Gender',
                                          controller: _selectedGender,
                                          onSave: (_) => _handleSave(),
                                          prefixIcon: Icons.people_outline,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (isLoading && !isImageLoading && !isSaving)
                        Container(
                          color: Colors.black.withOpacity(0.3),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                    ],
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

// Add extension for string capitalization
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

// Widgets for form fields to keep build clean

class _NameField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Color fieldColor;
  final Color borderColor;
  final Function(String) onChanged;

  const _NameField({
    required this.controller,
    required this.focusNode,
    required this.fieldColor,
    required this.borderColor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      textInputAction: TextInputAction.next,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        labelText: 'Name',
        hintText: 'Enter your full name',
        prefixIcon: const Icon(Icons.person_outline),
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Name is required';
        }
        if (value.trim().length < 3) {
          return 'Name must be at least 3 characters';
        }
        if (value.trim().length > ProfileValidationConstants.maxNameLength) {
          return 'Name must not exceed ${ProfileValidationConstants.maxNameLength} characters';
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
        hintText: 'Enter your phone number',
        filled: true,
        fillColor: fieldColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        prefixText: '+20 ',
        prefixStyle: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge?.color,
          fontWeight: FontWeight.bold,
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
          return 'Phone number must be 11 digits';
        }
        if (!value.startsWith('01')) {
          return 'Phone number must start with 01';
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
        if (value.trim().length > ProfileValidationConstants.maxAddressLength) {
          return 'Address must not exceed ${ProfileValidationConstants.maxAddressLength} characters';
        }
        return null;
      },
    );
  }
}

class _GenderField extends StatelessWidget {
  final String selectedGender;
  final void Function(String?) onChanged;
  final void Function(String) onSave;
  final Color fieldColor;
  final Color borderColor;
  final FocusNode focusNode;

  const _GenderField({
    required this.selectedGender,
    required this.onChanged,
    required this.onSave,
    required this.fieldColor,
    required this.borderColor,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedGender.isEmpty ? null : selectedGender,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: 'Gender',
        prefixIcon: const Icon(Icons.person_outline),
        filled: true,
        fillColor: fieldColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
      ),
      items: genders.map((gender) {
        return DropdownMenuItem<String>(
          value: gender,
          child: Text(gender),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
          onSave(value);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a gender';
        }
        return null;
      },
    );
  }
}

class _ProfileImageWidget extends StatelessWidget {
  final String? imageUrl;
  final File? localImage;
  final bool isLoading;
  final VoidCallback onTap;
  final VoidCallback? onSave;

  const _ProfileImageWidget({
    required this.imageUrl,
    required this.localImage,
    required this.isLoading,
    required this.onTap,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 20, bottom: 30),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            GestureDetector(
              onTap: isLoading ? null : onTap,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (localImage != null)
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      backgroundImage: FileImage(localImage!),
                    )
                  else if (imageUrl != null && imageUrl!.isNotEmpty)
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      child: ClipOval(
                        child: Image.network(
                          imageUrl!,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            developer.log(
                                'ProfileChangeView: Error loading network image: $error');
                            return const Icon(Icons.person,
                                size: 60, color: Colors.white);
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  else
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      child: const Icon(Icons.person,
                          size: 60, color: Colors.white),
                    ),
                  if (isLoading)
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (!isLoading)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (localImage != null && onSave != null)
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: onSave,
                        child: const Icon(Icons.save,
                            size: 20, color: Colors.white),
                      ),
                    ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child:
                        const Icon(Icons.edit, size: 20, color: Colors.white),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
