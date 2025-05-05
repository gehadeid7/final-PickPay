// import 'package:flutter/material.dart';
// import 'package:pickpay/features/home/domain/entities/cart_item_entity.dart';
// import 'package:pickpay/features/home/presentation/views/widgets/cart_item.dart';

// class CartItemsList extends StatelessWidget {
//   const CartItemsList({super.key, required this.cartItems});
//   final List<CartItemEntity> cartItems;
//   @override
//   Widget build(BuildContext context) {
//     return SliverList.separated(
//         separatorBuilder: (context, index) => CustomDivder(),
//         itemCount: 10,
//         itemBuilder: (context, index) {
//           return CartItem(
//               // cartItemEntity: cartItems[index],
//               );
//         });
//   }
// }

// class CustomDivder extends StatelessWidget {
//   const CustomDivder({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Divider(
//       color: const Color.fromARGB(255, 228, 228, 228),
//       height: 22,
//     );
//   }
// }
