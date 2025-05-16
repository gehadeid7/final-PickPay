import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/core/services/get_it_service.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';
import 'package:pickpay/features/home/presentation/cubits/bottom_navigation_cubits/bottom_navigation_cubit.dart';
import 'package:pickpay/features/home/presentation/views/widgets/bottom_navigation/custom_bottom_navigation_bar.dart';
import 'package:pickpay/features/home/presentation/views/widgets/main_navigation_body.dart';

class MainNavigationScreen extends StatelessWidget {

  const MainNavigationScreen({super.key});

  static const String routeName = '/main-navigation';

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
  final AuthRepo authRepo;  // non-nullable

  const _MainNavigationView({
    required this.authRepo,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        final shouldExit = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('هل تريد الخروج؟'),
            content: const Text('هل أنت متأكد أنك تريد الخروج من التطبيق؟'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('لا'),
              ),
              TextButton(
                onPressed: () => exit(0), // Or SystemNavigator.pop()
                child: const Text('نعم'),
              ),
            ],
          ),
        );
        return shouldExit ?? false;
      },
      child: Scaffold(
        extendBody: true,
        body: SafeArea(
          child: MainNavigationScreenBody(authRepo: authRepo),  // Pass it here!
        ),
        bottomNavigationBar: BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
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
