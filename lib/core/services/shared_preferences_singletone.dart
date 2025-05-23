import 'dart:convert';
import 'package:pickpay/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pickpay/constants.dart';

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

  static const _userKey = kUserData;

  // Save user model as JSON string
  static Future<void> saveUser(UserModel user) async {
    try {
      final jsonString = jsonEncode(user.toMap());
      await setString(_userKey, jsonString);
      print('✅ User data saved to local storage: ${user.toMap()}');
    } catch (e) {
      print('❌ Error saving user data to local storage: $e');
      rethrow;
    }
  }

  // Load user model from cached JSON string, returns null if none
  static UserModel? getUser() {
    try {
      final jsonString = getString(_userKey);
      if (jsonString.isEmpty) {
        print('ℹ️ No user data found in local storage');
        return null;
      }

      final Map<String, dynamic> userMap = jsonDecode(jsonString);
      final user = UserModel.fromMap(userMap);
      print('✅ User data loaded from local storage: ${user.toMap()}');
      return user;
    } catch (e) {
      print('❌ Error loading user data from local storage: $e');
      return null;
    }
  }

  // Remove cached user
  static Future<void> clearUser() async {
    try {
      await remove(_userKey);
      print('✅ User data cleared from local storage');
    } catch (e) {
      print('❌ Error clearing user data from local storage: $e');
      rethrow;
    }
  }
 // مفتاح التخزين لقائمة الرغبات
  static const _wishlistKey = 'wishlist';

  // حفظ قائمة الرغبات (تخزينها كـ JSON String)
  static Future<void> saveWishlist(List<dynamic> wishlist) async {
    try {
      final jsonString = jsonEncode(wishlist);
      await setString(_wishlistKey, jsonString);
      print('✅ Wishlist saved to local storage');
    } catch (e) {
      print('❌ Error saving wishlist to local storage: $e');
      rethrow;
    }
  }

  // استرجاع قائمة الرغبات (ترجع null إذا لم توجد)
  static List<dynamic>? getWishlist() {
    try {
      final jsonString = getString(_wishlistKey);
      if (jsonString.isEmpty) {
        print('ℹ️ No wishlist found in local storage');
        return null;
      }
      final List<dynamic> wishlist = jsonDecode(jsonString);
      print('✅ Wishlist loaded from local storage');
      return wishlist;
    } catch (e) {
      print('❌ Error loading wishlist from local storage: $e');
      return null;
    }
  }

  // حذف قائمة الرغبات من التخزين المحلي
  static Future<void> clearWishlist() async {
    try {
      await remove(_wishlistKey);
      print('✅ Wishlist cleared from local storage');
    } catch (e) {
      print('❌ Error clearing wishlist from local storage: $e');
      rethrow;
    }
  }
}
