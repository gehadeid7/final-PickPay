import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/core/services/get_it_service.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';
import 'package:pickpay/features/bottom_navigation/bottom_navigation_cubits/bottom_navigation_cubit.dart';
import 'package:pickpay/features/account_view/account_view.dart';
import 'package:pickpay/features/cart/cart_view.dart';
import 'package:pickpay/features/home/presentation/views/categories_view.dart';
import 'package:pickpay/features/home/presentation/views/home_view.dart';
import 'package:pickpay/features/bottom_navigation/custom_bottom_navigation_bar.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  static const String routeName = '/main-navigation';

  @override
  Widget build(BuildContext context) {
    final authRepo = getIt<AuthRepo>();
    return _MainNavigationView(authRepo: authRepo);
  }
}

class _MainNavigationView extends StatelessWidget {
  final AuthRepo authRepo;

  const _MainNavigationView({required this.authRepo});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldExit = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Do you want to exit?'),
            content: const Text('Are you sure you want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        );
        return shouldExit ?? false;
      },
      child: Scaffold(
        extendBody: true,
        body: SafeArea(
          child: MainNavigationScreenBody(authRepo: authRepo),
        ),
        bottomNavigationBar:
            BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
          builder: (context, state) {
            return CustomBottomNavigationBar(
              selectedIndex: state.currentIndex,
              onItemSelected: (index) =>
                  context.read<BottomNavigationCubit>().changeTab(index),
            );
          },
        ),
      ),
    );
  }
}

class MainNavigationScreenBody extends StatelessWidget {
  final AuthRepo authRepo;

  const MainNavigationScreenBody({required this.authRepo});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
      builder: (context, state) {
        return IndexedStack(
          index: state.currentIndex,
          children: [
            const HomeView(),
            const CategoriesView(),
            const CartView(),
            AccountView(),
          ],
        );
      },
    );
  }
}
