// features/home/presentation/views/widgets/theme_switch_button.dart
import 'package:flutter/material.dart';
import 'package:pickpay/core/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeSwitchButton extends StatelessWidget {
  const ThemeSwitchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return IconButton(
      icon: Icon(
        isDarkMode ? Icons.dark_mode : Icons.light_mode,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
      onPressed: () {
        themeProvider.toggleTheme();
      },
    );
  }
}
