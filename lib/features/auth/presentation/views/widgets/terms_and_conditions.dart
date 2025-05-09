import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_colors.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/features/auth/presentation/views/widgets/custom_checkbox.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key, required this.onChanged});

  final ValueChanged<bool> onChanged;

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  bool isTermsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCheckbox(
          onChecked: (value) {
            isTermsAccepted = value;
            widget.onChanged(value);
            setState(() {});
          },
          isChecked: isTermsAccepted,
        ),
        SizedBox(width: 16),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'I agree to the ',
                  style: TextStyles.semiBold13.copyWith(
                    color: AppColors.secondColor,
                  ),
                ),
                TextSpan(
                  text: 'Terms & Conditions ',
                  style: TextStyles.semiBold13.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                TextSpan(
                  text: 'and',
                  style: TextStyles.semiBold13.copyWith(
                    color: AppColors.secondColor,
                  ),
                ),
                TextSpan(
                  text: ' Privacy Policy',
                  style: TextStyles.semiBold13.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
