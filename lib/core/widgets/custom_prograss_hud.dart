import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:lottie/lottie.dart';

class CustomPrograssHud extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const CustomPrograssHud({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: Lottie.asset(
        'assets/animations/loading.json',
        width: 200,
        fit: BoxFit.contain,
      ),
      opacity: 0.4,
      child: child,
    );
  }
}
