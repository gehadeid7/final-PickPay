import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/beauty/presentation/views/widgets/beauty_view_body.dart';

class BeautyView extends StatelessWidget {
  const BeautyView({super.key});

  static const routeName = 'beauty_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: BeautyViewBody()),
    );
  }
}
