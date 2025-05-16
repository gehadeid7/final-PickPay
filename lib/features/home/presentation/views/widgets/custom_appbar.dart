import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_images.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/core/widgets/search_text_field.dart';
import 'package:pickpay/core/themes/theme_switch_button.dart';

class CustomHomeAppbar extends StatelessWidget {
  const CustomHomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          Assets.appLogo,
          width: 45,
          height: 45,
          // Removed the color property to maintain original logo colors
        ),
        const SizedBox(width: 5),
        Text(
          'PickPay',
          style: TextStyles.bold19.copyWith(
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            width: 260,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[700]!
                    : Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
              color: Theme.of(context).brightness == Brightness.dark
                  // ignore: deprecated_member_use
                  ? Colors.grey[800]?.withOpacity(0.5)
                  // ignore: deprecated_member_use
                  : Colors.grey[100]?.withOpacity(0.5),
            ),
            child: const SearchTextField(),
          ),
        ),
        const SizedBox(width: 8),
        const ThemeSwitchButton(),
      ],
    );
  }
}
