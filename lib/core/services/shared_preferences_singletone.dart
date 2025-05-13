import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static SharedPreferences? _instance;

  // Initialize SharedPreferences instance
  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }

  static SharedPreferences get instance {
    if (_instance == null) {
      throw Exception('Prefs not initialized. Call Prefs.init() before use.');
    }
    return _instance!;
  }

  static Future<void> setBool(String key, bool value) async {
    await instance.setBool(key, value);
  }

  static bool getBool(String key) {
    return instance.getBool(key) ?? false;
  }

  static Future<void> setString(String key, String value) async {
    await instance.setString(key, value);
  }

  static String getString(String key) {
    return instance.getString(key) ?? "";
  }

  static Future<void> remove(String key) async {
    await instance.remove(key);
  }
}
