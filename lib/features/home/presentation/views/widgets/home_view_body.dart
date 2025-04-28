import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/core/cubits/products_cubit/products_cubit_cubit.dart';
import 'package:pickpay/features/home/presentation/views/widgets/Fashion_section/fashion_grid.dart';
import 'package:pickpay/features/home/presentation/views/widgets/Fashion_section/fashion_header.dart';
import 'package:pickpay/features/home/presentation/views/widgets/appliances_section/appliances_grid.dart';
import 'package:pickpay/features/home/presentation/views/widgets/appliances_section/appliances_header.dart';
import 'package:pickpay/features/home/presentation/views/widgets/beauty_section/beauty_grid.dart';
import 'package:pickpay/features/home/presentation/views/widgets/beauty_section/beauty_header.dart';
import 'package:pickpay/features/home/presentation/views/widgets/custom_appbar.dart';
import 'package:pickpay/features/home/presentation/views/widgets/electronics_section/electronics_grid_view.dart';
import 'package:pickpay/features/home/presentation/views/widgets/electronics_section/electronics_header.dart';
import 'package:pickpay/features/home/presentation/views/widgets/home_section/home_section_grid.dart';
import 'package:pickpay/features/home/presentation/views/widgets/home_section/home_section_header.dart';
import 'package:pickpay/features/home/presentation/views/widgets/recommended_section/recommended_foru_grid_view.dart';
import 'package:pickpay/features/home/presentation/views/widgets/recommended_section/recommended_foru_header.dart';
import 'package:pickpay/features/home/presentation/views/widgets/sliding_cards_bannars/sliding_cards_feature_list.dart';
import 'package:pickpay/features/home/presentation/views/widgets/todays_sale_section/todays_sale_grid_view.dart';
import 'package:pickpay/features/home/presentation/views/widgets/todays_sale_section/todays_sale_header.dart';
import 'package:pickpay/features/home/presentation/views/widgets/video_games_bestsellers/vgames_grid.dart';
import 'package:pickpay/features/home/presentation/views/widgets/video_games_bestsellers/vigames_section_header.dart';

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
        RecommendedForuHeader(),
        SizedBox(height: 12),
        RecommendedForuGridView(),
        SizedBox(height: 12),
        TodaysSaleHeader(),
        SizedBox(height: 12),
        TodaysSaleGridView(),
        SizedBox(height: 12),
        ElectronicsHeader(),
        SizedBox(height: 12),
        ElectronicsGridView(products: []),
        SizedBox(height: 12),
        AppliancesHeader(),
        SizedBox(height: 12),
        AppliancesGrid(),
        SizedBox(height: 12),
        HomeSectionHeader(),
        SizedBox(height: 12),
        HomeSectionGrid(),
        SizedBox(height: 12),
        VigamesSectionHeader(),
        SizedBox(height: 12),
        VgamesGrid(),
        SizedBox(height: 12),
        FashionHeader(),
        SizedBox(height: 12),
        FashionGrid(),
        SizedBox(height: 12),
        BeautyHeader(),
        SizedBox(height: 12),
        BeautyGrid(),
        SizedBox(height: 12),

        // BestSellingGridViewBlocBuilder()
      ],
    );
  }
}
