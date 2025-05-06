part of 'wishlist_cubit.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<ProductsViewsModel> items;
  final WishlistAction? action;

  const WishlistLoaded({required this.items, this.action});

  @override
  List<Object> get props => [items, action ?? ''];
}

enum WishlistAction { added, removed }
