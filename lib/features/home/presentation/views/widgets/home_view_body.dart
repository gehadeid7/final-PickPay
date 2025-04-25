import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/core/cubits/products_cubit/products_cubit_cubit.dart';
import 'package:pickpay/features/home/presentation/views/widgets/bestselling_grid_view_bloc_builder.dart';
import 'package:pickpay/features/home/presentation/views/widgets/custom_appbar.dart';
import 'package:pickpay/features/home/presentation/views/widgets/electronics_section/electronics_header.dart';
import 'package:pickpay/features/home/presentation/views/widgets/sliding_cards_bannars/sliding_cards_feature_list.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    context.read<ProductsCubit>().getBsetSellingProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      children: const [
        SizedBox(height: 12),
        CustomHomeAppbar(),
        SlidingFeaturedList(),
        SizedBox(height: 12),
        // RecommendedForuHeader(),
        // SizedBox(height: 12),
        // RecommendedForuGridView(),
        // SizedBox(height: 12),
        // TodaysSaleHeader(),
        // SizedBox(height: 12),
        // TodaysSaleGridView(),
        // SizedBox(height: 12),
        ElectronicsHeader(),
        SizedBox(height: 12),
        BestSellingGridViewBlocBuilder()
      ],
    );
  }
}

