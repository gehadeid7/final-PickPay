import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class AppFlushbar {
  static void showSuccess(BuildContext context, String message) {
    _showFlushbar(
      context: context,
      message: message,
      backgroundColor: Theme.of(context).colorScheme.primary,
      icon: Icons.check_circle_outline,
    );
  }

  static void showError(BuildContext context, String message) {
    _showFlushbar(
      context: context,
      message: message,
      backgroundColor: Theme.of(context).colorScheme.error,
      icon: Icons.error_outline,
    );
  }

  static void _showFlushbar({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    required IconData icon,
  }) {
    Flushbar(
      message: message,
      icon: Icon(icon, color: Colors.white),
      duration: const Duration(seconds: 3),
      backgroundColor: backgroundColor,
      margin: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(12),
      flushbarPosition: FlushbarPosition.TOP,
      animationDuration: const Duration(milliseconds: 500),
    ).show(context);
  }
}
