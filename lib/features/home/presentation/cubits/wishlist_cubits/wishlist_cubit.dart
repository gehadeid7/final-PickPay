import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitial()) {
    loadInitialWishlist();
  }

  List<ProductsViewsModel> _wishlistItems = [];

  void loadInitialWishlist() {
    // You can load from local storage here if needed
    emit(WishlistLoaded(items: _wishlistItems));
  }

  void addToWishlist(ProductsViewsModel product) {
    if (!_wishlistItems.any((item) => item.id == product.id)) {
      _wishlistItems.add(product);
      emit(WishlistLoaded(items: _wishlistItems, action: WishlistAction.added));
    }
  }

  void removeFromWishlist(String productId) {
    _wishlistItems.removeWhere((item) => item.id == productId);
    emit(WishlistLoaded(items: _wishlistItems, action: WishlistAction.removed));
  }

  bool isInWishlist(String productId) {
    return _wishlistItems.any((item) => item.id == productId);
  }
}
