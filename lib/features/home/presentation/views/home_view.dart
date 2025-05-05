import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/core/cubits/products_cubit/products_cubit_cubit.dart';
import 'package:pickpay/core/repos/product_repo/products_repo.dart';
import 'package:pickpay/core/services/get_it_service.dart';
import 'package:pickpay/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = 'home_view';

  @override
  Widget build(BuildContext context) {
    // return BlocProvider(
    //   create: (context) => ProductsCubit(
    //     getIt.get<ProductsRepo>()
    //   ),
    return Scaffold(
      body: SafeArea(child: HomeViewBody()),
    );
  }
}
