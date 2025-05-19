import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/features/wishlist/wishlist_cubits/wishlist_cubit.dart';
import 'package:pickpay/features/wishlist/wishlist_view_body.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  static const routeName = 'wishlist';

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<WishlistCubit>(),
      child: const Scaffold(
        body: WishlistViewBody(),
      ),
    );
  }
}
