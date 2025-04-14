import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.socialButtonIconImage,
    required this.socialButtonTitle,
    required this.onPressed,
  });

  final String socialButtonIconImage;
  final String socialButtonTitle;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color(0xFFDCDEDE), width: 1),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onPressed,
        child: ListTile(
          visualDensity: VisualDensity(vertical: VisualDensity.minimumDensity),
          leading: Image.asset(
            socialButtonIconImage,
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 35.0),
            child: Text(socialButtonTitle),
          ),
        ),
      ),
    );
  }
}
