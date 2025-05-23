import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/services/shared_preferences_singletone.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  late final StreamSubscription<User?> _authSubscription;
  List<ProductsViewsModel> _wishlistItems = [];

  WishlistCubit() : super(WishlistInitial()) {
    // Listen to auth state changes
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        // User logged in - load their wishlist
        _loadWishlistData();
      } else {
        // User logged out - clear current wishlist
        _wishlistItems = [];
        emit(WishlistLoaded(items: []));
      }
    });
    // Initial load of wishlist data
    _loadWishlistData();
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }

  String get _wishlistKey {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return ''; // Return empty if no user
    return 'wishlist_${user.uid}';
  }

  Future<void> _loadWishlistData() async {
    try {
      final key = _wishlistKey;
      if (key.isEmpty) {
        _wishlistItems = [];
        emit(WishlistLoaded(items: []));
        return;
      }

      final wishlistJson = Prefs.getString(key);
      if (wishlistJson.isNotEmpty) {
        final List<dynamic> wishlistList = jsonDecode(wishlistJson);
        _wishlistItems = wishlistList
            .map((item) => ProductsViewsModel.fromJson(item))
            .toList();
      } else {
        _wishlistItems = [];
      }
      emit(WishlistLoaded(items: List.from(_wishlistItems)));
    } catch (e) {
      print('Error loading wishlist data: $e');
      _wishlistItems = [];
      emit(WishlistLoaded(items: []));
    }
  }

  Future<void> _saveWishlistData() async {
    try {
      final key = _wishlistKey;
      if (key.isEmpty) return; // Don't save if no user

      final wishlistList = _wishlistItems.map((item) => item.toJson()).toList();
      final wishlistJson = jsonEncode(wishlistList);
      await Prefs.setString(key, wishlistJson);
    } catch (e) {
      print('Error saving wishlist data: $e');
    }
  }

  void addToWishlist(ProductsViewsModel product) {
    if (_wishlistKey.isEmpty) return; // Don't add if no user

    final newList = List<ProductsViewsModel>.from(_wishlistItems);
    if (!newList.any((item) => item.id == product.id)) {
      newList.add(product);
      _wishlistItems = newList;
      emit(WishlistLoaded(
        items: List.from(_wishlistItems),
        action: WishlistAction.added,
      ));
      _saveWishlistData();
    }
  }

  void removeFromWishlist(String productId) {
    if (_wishlistKey.isEmpty) return; // Don't remove if no user

    final newList = List<ProductsViewsModel>.from(_wishlistItems);
    newList.removeWhere((item) => item.id == productId);
    _wishlistItems = newList;
    emit(WishlistLoaded(
      items: List.from(_wishlistItems),
      action: WishlistAction.removed,
    ));
    _saveWishlistData();
  }

  bool isInWishlist(String productId) {
    return _wishlistItems.any((item) => item.id == productId);
  }

  List<ProductsViewsModel> get wishlistItems => List.from(_wishlistItems);
}
