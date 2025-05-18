part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoaded extends CartState {
  final List<CartItemModel> items;
  final CartAction? action;
  final CartItemModel? addedItem;
  final CartItemModel? removedItem;
  final CartItemModel? updatedItem;

  const CartLoaded(
    this.items, {
    this.action,
    this.addedItem,
    this.removedItem,
    this.updatedItem,
  });

  @override
  List<Object?> get props => [
        items,
        action,
        addedItem,
        removedItem,
        updatedItem,
      ];
}

enum CartAction { added, removed, updated }
