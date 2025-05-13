import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/core/utils/app_colors.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/auth/presentation/cubits/change_password/change_password_cubit.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});
  static const routeName = 'change_pass';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Change Password'),
      body: BlocProvider(
        create: (context) => ChangePasswordCubit(),
        child: _ChangePasswordForm(isDarkMode: isDarkMode),
      ),
    );
  }
}

class _ChangePasswordForm extends StatefulWidget {
  final bool isDarkMode;
  const _ChangePasswordForm({required this.isDarkMode});

  @override
  State<_ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<_ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Color _getFillColor(BuildContext context) {
    return widget.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100;
  }

  Color _getBorderColor(BuildContext context) {
    return widget.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade400;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Password changed successfully'),
              behavior: SnackBarBehavior.floating,
              backgroundColor: AppColors.primaryColor,
            ),
          );
          Navigator.of(context).pop();
        } else if (state is ChangePasswordFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              behavior: SnackBarBehavior.floating,
              backgroundColor: theme.colorScheme.error,
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _currentPasswordController,
                obscureText: _obscureCurrentPassword,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: _getFillColor(context),
                  labelText: 'Current Password',
                  labelStyle: TextStyles.regular16.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: theme.iconTheme.color,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureCurrentPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureCurrentPassword = !_obscureCurrentPassword;
                      });
                    },
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _getBorderColor(context)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: _getBorderColor(context)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your current password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _newPasswordController,
                obscureText: _obscureNewPassword,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: _getFillColor(context),
                  labelText: 'New Password',
                  labelStyle: TextStyles.regular16.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Colors.grey,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureNewPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureNewPassword = !_obscureNewPassword;
                      });
                    },
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _getBorderColor(context)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: _getBorderColor(context)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: _getFillColor(context),
                  labelText: 'Confirm New Password',
                  labelStyle: TextStyles.regular16.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Colors.grey,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _getBorderColor(context)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: _getBorderColor(context)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new password';
                  }
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                builder: (context, state) {
                  if (state is ChangePasswordLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<ChangePasswordCubit>().changePassword(
                              currentPassword: _currentPasswordController.text,
                              newPassword: _newPasswordController.text,
                              confirmPassword: _confirmPasswordController.text,
                            );
                      }
                    },
                    child: Text(
                      'Change Password',
                      style: TextStyles.bold16.copyWith(color: Colors.white),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
