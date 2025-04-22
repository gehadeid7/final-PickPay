import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/features/home/presentation/cubits/bottom_navigation_cubits/bottom_navigation_cubit.dart';
import 'package:pickpay/features/home/presentation/views/widgets/bottom_navigation/custom_bottom_navigation_bar.dart';
import 'package:pickpay/features/home/presentation/views/widgets/main_navigation_body.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  static const routeName = 'main_navigation';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavigationCubit(),
      child: Scaffold(
        bottomNavigationBar: BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
          builder: (context, state) {
            final index = state is BottomNavigationChanged ? state.index : 0;
            return CustomBottomNavigationBar(
              selectedIndex: index,
              onItemSelected: (newIndex) =>
                  context.read<BottomNavigationCubit>().changeTab(newIndex),
            );
          },
        ),
        body: const SafeArea(child: MainNavigationScreenBody()),
      ),
    );
  }
}
