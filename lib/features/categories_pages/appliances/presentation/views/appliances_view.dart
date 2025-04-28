import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/appliances/presentation/views/widgets/appliances_view_body.dart';

class AppliancesView extends StatelessWidget {
  const AppliancesView({super.key});



static const routeName = 'appliances_view';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: AppliancesViewBody(),
      ),
    );
  }
}
