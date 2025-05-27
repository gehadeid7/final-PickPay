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
      final response = await _apiService.addProductToWishlist(product.id);
      if (response.statusCode == 200 || response.statusCode == 201) {
        newList.add(product);
        _wishlistItems = newList;
        emit(WishlistLoaded(
          items: List.from(_wishlistItems),
          action: WishlistAction.added,
        ));
        await _saveWishlistData();
      } else {
        print('Failed to add product to wishlist: ${response.statusCode}');
      }
    }
  }

  Future<void> removeFromWishlist(String productId) async {
    if (_wishlistKey.isEmpty) return;

    final response = await _apiService.removeProductFromWishlist(productId);
    if (response.statusCode == 200 || response.statusCode == 204) {
      final newList = List<ProductsViewsModel>.from(_wishlistItems);
      newList.removeWhere((item) => item.id == productId);
      _wishlistItems = newList;
      emit(WishlistLoaded(
        items: List.from(_wishlistItems),
        action: WishlistAction.removed,
      ));
      await _saveWishlistData();
    } else {
      print('Failed to remove product from wishlist: ${response.statusCode}');
    }
  }

  bool isInWishlist(String productId) {
    return _wishlistItems.any((item) => item.id == productId);
  }

  List<ProductsViewsModel> get wishlistItems => List.from(_wishlistItems);
}
