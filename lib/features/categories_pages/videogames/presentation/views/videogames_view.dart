import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/videogames/presentation/views/widgets/videogames_view_body.dart';

class VideogamesView extends StatelessWidget {
  const VideogamesView({super.key});

  static const routeName = 'videogames_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: VideogamesViewBody()),
    );
  }
}
