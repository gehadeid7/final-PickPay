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
    emit(WishlistLoaded(items: List.from(_wishlistItems)));
  }

  void addToWishlist(ProductsViewsModel product) {
    final newList = List<ProductsViewsModel>.from(_wishlistItems);
    if (!newList.any((item) => item.id == product.id)) {
      newList.add(product);
      _wishlistItems = newList;
      emit(WishlistLoaded(
        items: List.from(_wishlistItems),
        action: WishlistAction.added,
      ));
    }
  }

  void removeFromWishlist(String productId) {
    final newList = List<ProductsViewsModel>.from(_wishlistItems);
    newList.removeWhere((item) => item.id == productId);
    _wishlistItems = newList;
    emit(WishlistLoaded(
      items: List.from(_wishlistItems),
      action: WishlistAction.removed,
    ));
  }

  bool isInWishlist(String productId) {
    return _wishlistItems.any((item) => item.id == productId);
  }

  List<ProductsViewsModel> get wishlistItems => List.from(_wishlistItems);
}
