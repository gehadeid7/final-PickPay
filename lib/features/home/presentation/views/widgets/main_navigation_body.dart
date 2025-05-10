// main_navigation_body.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/features/home/presentation/cubits/bottom_navigation_cubits/bottom_navigation_cubit.dart';
import 'package:pickpay/features/home/presentation/views/account_view.dart';
import 'package:pickpay/features/home/presentation/views/cart_view.dart';
import 'package:pickpay/features/home/presentation/views/categories_view.dart';
import 'package:pickpay/features/home/presentation/views/home_view.dart';

class MainNavigationScreenBody extends StatelessWidget {
  const MainNavigationScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
      builder: (context, state) {
        return IndexedStack(
          index: state.currentIndex,
          children: const [
            HomeView(),
            CategoriesView(),
            CartView(),
            AccountView(),
          ],
        );
      },
    );
  }
}
