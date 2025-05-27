part of 'wishlist_cubit.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<ProductsViewsModel> items;
  final WishlistAction? action;

  const WishlistLoaded({required this.items, this.action});

  @override
  List<Object> get props => [items, action ?? ''];
}

class WishlistError extends WishlistState {
  final String message;

  const WishlistError(this.message);

  @override
  List<Object> get props => [message];
}

enum WishlistAction { added, removed }
