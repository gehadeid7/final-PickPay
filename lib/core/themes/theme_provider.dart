import 'package:flutter/material.dart';
import 'package:pickpay/core/services/shared_preferences_singletone.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    // ignore: await_only_futures
    _isDarkMode = await Prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await Prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }
}
