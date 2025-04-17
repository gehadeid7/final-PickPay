import 'package:flutter/material.dart';

abstract class AppDecoration {
  static var greyBoxDecoration = ShapeDecoration(
    color: const Color.fromARGB(126, 248, 249, 249),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  );
}
