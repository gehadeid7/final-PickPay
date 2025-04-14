  import 'package:flutter/material.dart';

void buildErrorBar(BuildContext context, String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 1),
      backgroundColor: Colors.blue,
      content: Text(message),
    ));
  }
  