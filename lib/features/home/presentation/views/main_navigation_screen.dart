import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/features/home/presentation/cubits/bottom_navigation_cubits/bottom_navigation_cubit.dart';
import 'package:pickpay/features/home/presentation/views/widgets/bottom_navigation/custom_bottom_navigation_bar.dart';
import 'package:pickpay/features/home/presentation/views/widgets/main_navigation_body.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  static const String routeName = '/main-navigation';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavigationCubit(),
      child: const _MainNavigationView(),
    );
  }
}

class _MainNavigationView extends StatelessWidget {
  const _MainNavigationView();

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
                onPressed: () =>
                    exit(0), // أو استخدم SystemNavigator.pop() لإغلاق التطبيق
                child: const Text('نعم'),
              ),
            ],
          ),
        );
        return shouldExit ?? false;
      },
      child: Scaffold(
        extendBody: true,
        body: const SafeArea(
          child: MainNavigationScreenBody(),
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
