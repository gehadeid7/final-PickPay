import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';

class TodaysSaleHeader extends StatelessWidget {
  const TodaysSaleHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Center(
        child: Text("Today's Sale",
            style: TextStyles.bold16.copyWith(
              color: Colors.red,
            )),
      ),
    );
  }
}
