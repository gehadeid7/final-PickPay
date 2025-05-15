import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_colors.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    this.onPressed, // Changed to nullable
    required this.buttonText,
    this.isLoading = false,
  });

  final VoidCallback? onPressed; // Now nullable
  final String buttonText;
  final bool isLoading;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: widget.onPressed != null
              ? AppColors.primaryColor
              // ignore: deprecated_member_use
              : AppColors.primaryColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
          boxShadow: _isHovered && widget.onPressed != null
              ? [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: TextButton(
          onPressed: widget.onPressed,
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.zero,
          ),
          child: widget.isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : AnimatedScale(
                  duration: const Duration(milliseconds: 200),
                  scale: _isHovered ? 1.02 : 1.0,
                  child: Text(
                    widget.buttonText,
                    style: TextStyles.bold16.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
