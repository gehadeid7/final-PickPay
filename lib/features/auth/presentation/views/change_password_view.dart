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
      appBar: buildAppBar(
        context: context,
        title: 'Change Password',
        backgroundColor:
            isDarkMode ? Colors.grey.shade900 : AppColors.primaryColor,
        titleStyle: TextStyles.bold19.copyWith(color: Colors.white),
        iconColor: Colors.white,
      ),
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

class _ChangePasswordFormState extends State<_ChangePasswordForm>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  late AnimationController _controller;
  late Animation<Color?> _colorAnimation1;
  late Animation<Color?> _colorAnimation2;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5))
          ..repeat(reverse: true);

    if (widget.isDarkMode) {
      _colorAnimation1 = ColorTween(
        begin: Colors.deepPurple.shade700,
        end: Colors.indigo.shade900,
      ).animate(_controller);
      _colorAnimation2 = ColorTween(
        begin: Colors.black87,
        end: Colors.deepPurple.shade900,
      ).animate(_controller);
    } else {
      _colorAnimation1 = ColorTween(
        begin: Colors.blue.shade300,
        end: Colors.purple.shade300,
      ).animate(_controller);
      _colorAnimation2 = ColorTween(
        begin: Colors.pink.shade300,
        end: Colors.orange.shade300,
      ).animate(_controller);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Color _getFillColor(BuildContext context) {
    return widget.isDarkMode ? Colors.grey.shade900 : Colors.white;
  }

  Widget _styledPasswordField({
    required BuildContext context,
    required String label,
    required bool obscureText,
    required VoidCallback onToggle,
    required TextEditingController controller,
    required FormFieldValidator<String> validator,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: widget.isDarkMode
                ? Colors.black45
                // ignore: deprecated_member_use
                : Colors.grey.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        style: TextStyles.regular16.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: _getFillColor(context),
          labelText: label,
          labelStyle: TextStyles.regular16.copyWith(
            color: Theme.of(context).hintColor,
          ),
          prefixIcon: Icon(icon, color: Theme.of(context).iconTheme.color),
          suffixIcon: IconButton(
            icon: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: onToggle,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [_colorAnimation1.value!, _colorAnimation2.value!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            );
          },
        ),
        Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: widget.isDarkMode
                    // ignore: deprecated_member_use
                    ? Colors.black.withOpacity(0.6)
                    // ignore: deprecated_member_use
                    : Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: widget.isDarkMode
                        ? Colors.black54
                        // ignore: deprecated_member_use
                        : Colors.grey.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: _buildForm(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
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
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _styledPasswordField(
              context: context,
              label: 'Current Password',
              obscureText: _obscureCurrentPassword,
              onToggle: () => setState(
                  () => _obscureCurrentPassword = !_obscureCurrentPassword),
              controller: _currentPasswordController,
              icon: Icons.lock,
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter your current password'
                  : null,
            ),
            _styledPasswordField(
              context: context,
              label: 'New Password',
              obscureText: _obscureNewPassword,
              onToggle: () =>
                  setState(() => _obscureNewPassword = !_obscureNewPassword),
              controller: _newPasswordController,
              icon: Icons.lock_outline,
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
            _styledPasswordField(
              context: context,
              label: 'Confirm New Password',
              obscureText: _obscureConfirmPassword,
              onToggle: () => setState(
                  () => _obscureConfirmPassword = !_obscureConfirmPassword),
              controller: _confirmPasswordController,
              icon: Icons.lock_outline,
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
            const SizedBox(height: 30),
            BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
              builder: (context, state) {
                if (state is ChangePasswordLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: const Size(double.infinity, 50),
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
    );
  }
}
