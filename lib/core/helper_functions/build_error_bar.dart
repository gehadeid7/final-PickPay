  import 'package:flutter/material.dart';

void buildErrorBar(BuildContext context, String message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.blue,
      content: Text(message),
    ));
  }