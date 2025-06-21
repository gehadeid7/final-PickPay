import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pickpay/core/services/shared_preferences_singletone.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/services/api_service.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final ApiService _apiService = ApiService();
  late final StreamSubscription<User?> _authSubscription;
  List<ProductsViewsModel> _wishlistItems = [];

  WishlistCubit() : super(WishlistInitial()) {
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        reloadWishlist();
      } else {
        _wishlistItems = [];
        emit(WishlistLoaded(items: []));
      }
    });
    reloadWishlist();
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }

  String get _wishlistKey {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return '';
    return 'wishlist_${user.uid}';
  }

  Future<void> reloadWishlist() async {
    emit(WishlistLoading());
    await _loadWishlistData();
  }

  Future<void> _loadWishlistData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        _wishlistItems = [];
        emit(WishlistLoaded(items: []));
        return;
      }

      final responseList = await _apiService.getLoggedUserWishlist();

      if (responseList.isNotEmpty) {
        _wishlistItems = responseList
            .map((item) => ProductsViewsModel.fromJson(item))
            .toList();
        await _saveWishlistData();
      } else {
        final wishlistJson = Prefs.getString(_wishlistKey);
        if (wishlistJson.isNotEmpty) {
          final List<dynamic> wishlistList = jsonDecode(wishlistJson);
          _wishlistItems = wishlistList
              .map((item) => ProductsViewsModel.fromJson(item))
              .toList();
        } else {
          _wishlistItems = [];
        }
      }

      emit(WishlistLoaded(items: List.from(_wishlistItems)));
    } catch (e) {
      print('Error loading wishlist data: $e');
      final wishlistJson = Prefs.getString(_wishlistKey);
      if (wishlistJson.isNotEmpty) {
        final List<dynamic> wishlistList = jsonDecode(wishlistJson);
        _wishlistItems = wishlistList
            .map((item) => ProductsViewsModel.fromJson(item))
            .toList();
      } else {
        _wishlistItems = [];
      }
      emit(WishlistError('Failed to load wishlist. Please try again.'));
    }
  }

  Future<void> _saveWishlistData() async {
    try {
      final key = _wishlistKey;
      if (key.isEmpty) return;

      final wishlistList = _wishlistItems.map((item) => item.toJson()).toList();
      final wishlistJson = jsonEncode(wishlistList);
      await Prefs.setString(key, wishlistJson);
    } catch (e) {
      print('Error saving wishlist data: $e');
    }
  }

  Future<void> addToWishlist(ProductsViewsModel product) async {
    if (_wishlistKey.isEmpty) return;

    final newList = List<ProductsViewsModel>.from(_wishlistItems);
    if (!newList.any((item) => item.id == product.id)) {
      // Optimistic update - immediately update UI
      newList.add(product);
      _wishlistItems = newList;
      emit(WishlistLoaded(
        items: List.from(_wishlistItems),
        action: WishlistAction.added,
      ));

      // API call in background
      try {
        final response = await _apiService.addProductToWishlist(product.id);
        if (response.statusCode == 200 || response.statusCode == 201) {
          await _saveWishlistData();
        } else {
          // Revert on failure
          print('Failed to add product to wishlist: ${response.statusCode}');
          newList.removeWhere((item) => item.id == product.id);
          _wishlistItems = newList;
          emit(WishlistLoaded(
            items: List.from(_wishlistItems),
            action: WishlistAction.removed,
          ));
        }
      } catch (e) {
        // Revert on error
        print('Error adding product to wishlist: $e');
        newList.removeWhere((item) => item.id == product.id);
        _wishlistItems = newList;
        emit(WishlistLoaded(
          items: List.from(_wishlistItems),
          action: WishlistAction.removed,
        ));
      }
    }
  }

  Future<void> removeFromWishlist(String productId) async {
    if (_wishlistKey.isEmpty) return;

    final newList = List<ProductsViewsModel>.from(_wishlistItems);
    final removedProduct = newList.firstWhere((item) => item.id == productId);

    // Optimistic update - immediately update UI
    newList.removeWhere((item) => item.id == productId);
    _wishlistItems = newList;
    emit(WishlistLoaded(
      items: List.from(_wishlistItems),
      action: WishlistAction.removed,
    ));

    // API call in background
    try {
      final response = await _apiService.removeProductFromWishlist(productId);
      if (response.statusCode == 200 || response.statusCode == 204) {
        await _saveWishlistData();
      } else {
        // Revert on failure
        print('Failed to remove product from wishlist: ${response.statusCode}');
        newList.add(removedProduct);
        _wishlistItems = newList;
        emit(WishlistLoaded(
          items: List.from(_wishlistItems),
          action: WishlistAction.added,
        ));
      }
    } catch (e) {
      // Revert on error
      print('Error removing product from wishlist: $e');
      newList.add(removedProduct);
      _wishlistItems = newList;
      emit(WishlistLoaded(
        items: List.from(_wishlistItems),
        action: WishlistAction.added,
      ));
    }
  }

  bool isInWishlist(String productId) {
    return _wishlistItems.any((item) => item.id == productId);
  }

  List<ProductsViewsModel> get wishlistItems => List.from(_wishlistItems);
}
