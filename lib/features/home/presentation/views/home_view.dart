import 'package:flutter/material.dart';
import 'package:pickpay/features/home/presentation/views/widgets/bottom_navigation/custom_bottom_navigation_bar.dart';
import 'package:pickpay/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = 'home_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: SafeArea(child: HomeViewBody()),
    );
  }
}
