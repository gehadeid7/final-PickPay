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
    } catch (e) {
      rethrow;
    }
  }

  // Load user model from cached JSON string, returns null if none
  static UserModel? getUser() {
    try {
      final jsonString = getString(_userKey);
      if (jsonString.isEmpty) {
        return null;
      }

      final Map<String, dynamic> userMap = jsonDecode(jsonString);
      final user = UserModel.fromMap(userMap);
      return user;
    } catch (e) {
      return null;
    }
  }

  static Future<void> clearUser() async {
    try {
      await remove(_userKey);
    } catch (e) {
      rethrow;
    }
  }

  static const _wishlistKey = 'wishlist';

  static Future<void> saveWishlist(List<dynamic> wishlist) async {
    try {
      final jsonString = jsonEncode(wishlist);
      await setString(_wishlistKey, jsonString);
    } catch (e) {
      rethrow;
    }
  }

  // استرجاع قائمة الرغبات (ترجع null إذا لم توجد)
  static List<dynamic>? getWishlist() {
    try {
      final jsonString = getString(_wishlistKey);
      if (jsonString.isEmpty) {
        return null;
      }
      final List<dynamic> wishlist = jsonDecode(jsonString);
      return wishlist;
    } catch (e) {
      return null;
    }
  }

  // حذف قائمة الرغبات من التخزين المحلي
  static Future<void> clearWishlist() async {
    try {
      await remove(_wishlistKey);
    } catch (e) {
      rethrow;
    }
  }

  // Order storage methods
  static const _orderKey = 'user_orders';

  // Save orders for a specific user
  static Future<void> saveUserOrders(
      String userId, List<dynamic> orders) async {
    try {
      final key = '${_orderKey}_$userId';
      final jsonString = jsonEncode(orders);
      await setString(key, jsonString);
    } catch (e) {
      rethrow;
    }
  }

  // Load orders for a specific user
  static List<dynamic>? getUserOrders(String userId) {
    try {
      final key = '${_orderKey}_$userId';
      final jsonString = getString(key);
      if (jsonString.isEmpty) {
        return null;
      }
      final List<dynamic> orders = jsonDecode(jsonString);
      return orders;
    } catch (e) {
      return null;
    }
  }

  // Clear orders for a specific user
  static Future<void> clearUserOrders(String userId) async {
    try {
      final key = '${_orderKey}_$userId';
      await remove(key);
    } catch (e) {
      rethrow;
    }
  }
}
