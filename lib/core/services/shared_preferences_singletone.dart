import 'dart:convert';
import 'package:pickpay/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static SharedPreferences? _instance;

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

  // ======== User caching methods =========

  static const _userKey = 'cached_user';

  // Save user model as JSON string
  static Future<void> saveUser(UserModel user) async {
    final jsonString = jsonEncode(user.toMap());
    await setString(_userKey, jsonString);
  }

  // Load user model from cached JSON string, returns null if none
  static UserModel? getUser() {
    final jsonString = getString(_userKey);
    if (jsonString.isEmpty) return null;

    final Map<String, dynamic> userMap = jsonDecode(jsonString);
    return UserModel.fromMap(userMap);
  }

  // Remove cached user
  static Future<void> clearUser() async {
    await remove(_userKey);
  }
}
