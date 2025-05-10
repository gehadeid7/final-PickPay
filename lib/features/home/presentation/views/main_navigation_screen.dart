// main_navigation_screen.dart
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
    return Scaffold(
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
    );
  }
}
