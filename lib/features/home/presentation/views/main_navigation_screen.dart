import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/core/services/get_it_service.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';
import 'package:pickpay/features/bottom_navigation/bottom_navigation_cubits/bottom_navigation_cubit.dart';
import 'package:pickpay/features/bottom_navigation/custom_bottom_navigation_bar.dart';
import 'package:pickpay/features/home/presentation/views/widgets/main_navigation_body.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  static const String routeName = '/main-navigation';

  /// Tab indexes for better readability
  static const int homeTab = 0;
  static const int categoriesTab = 1;
  static const int cartTab = 2;
  static const int accountTab = 3;

  /// Helper method for consistent tab navigation
  static void navigateToTab(BuildContext context, int tabIndex) {
    // Check if we're already in the main navigation flow
    final isInMainFlow = ModalRoute.of(context)?.settings.name == routeName;

    if (isInMainFlow) {
      // Just change the tab if we're already in main flow
      context.read<BottomNavigationCubit>().changeTab(tabIndex);
    } else {
      // Push the main navigation screen with the desired tab
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MainNavigationScreen(),
          settings: const RouteSettings(name: routeName),
        ),
      );
      // Change to the desired tab after build completes
      Future.delayed(Duration.zero, () {
        context.read<BottomNavigationCubit>().changeTab(tabIndex);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authRepo = getIt<AuthRepo>();

    return BlocProvider(
      create: (_) => BottomNavigationCubit(),
      child: _MainNavigationView(authRepo: authRepo),
    );
  }
}

class _MainNavigationView extends StatelessWidget {
  final AuthRepo authRepo;

  const _MainNavigationView({
    required this.authRepo,
  });

  Future<bool> _onWillPop(BuildContext context) async {
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
            onPressed: () => exit(0),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
    return shouldExit ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
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
