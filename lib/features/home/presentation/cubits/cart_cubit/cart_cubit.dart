import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/features/home/domain/models/cart_item_model.dart';
import 'package:pickpay/features/home/presentation/cubits/cart_cubit/cart_state.dart';
import 'package:pickpay/core/services/cart_service.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  // Method to add items to the cart and update the state
  Future<void> addToCart(CartItemModel cartItem) async {
    final currentState = state;
    if (currentState is CartLoaded) {
      // Directly call the static addToCart method from CartService
      final updatedItems = await CartService.addToCart(cartItem.id);

      if (updatedItems.isNotEmpty) {
        emit(CartLoaded(
            items:
                updatedItems.map((e) => CartItemModel.fromJson(e)).toList()));
      } else {
        emit(CartError("Failed to add item to cart"));
      }
    }
  }
}
