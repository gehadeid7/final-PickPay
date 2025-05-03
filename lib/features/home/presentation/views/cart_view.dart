import 'package:flutter/material.dart';
import 'package:pickpay/features/home/presentation/views/widgets/cart_view_body.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  static const routeName = 'Cart_View';

  @override
  Widget build(BuildContext context) {
    return CartViewBody();
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pickpay/features/home/presentation/cubits/cart_cubit/cart_cubit.dart';
// import 'package:pickpay/features/home/presentation/cubits/cart_cubit/cart_state.dart';

// class CartView extends StatelessWidget {
//   const CartView({super.key});

//   static const routeName = 'Cart_View';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Cart')),
//       body: BlocBuilder<CartCubit, CartState>(
//         builder: (context, state) {
//           if (state is CartLoaded) {
//             if (state.items.isEmpty) {
//               return const Center(child: Text("Your cart is empty"));
//             }
//             return ListView.builder(
//               itemCount: state.items.length,
//               itemBuilder: (context, index) {
//                 final product = state.items[index];
//                 return ListTile(
//                   title: Text(product.title), // Display product title
//                   subtitle: Text('${product.price} EGP'),
//                   trailing:
//                       Text('ID: ${product.id}'), // Displaying the backend ID
//                 );
//               },
//             );
//           } else if (state is CartError) {
//             return Center(child: Text(state.message));
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }
