// features/home/presentation/views/widgets/theme_switch_button.dart
import 'package:flutter/material.dart';
import 'package:pickpay/core/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeSwitchButton extends StatelessWidget {
  const ThemeSwitchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return IconButton(
      icon: Icon(
        themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
        color: Theme.of(context).iconTheme.color,
      ),
      onPressed: () {
        themeProvider.toggleTheme();
      },
    );
  }
}
