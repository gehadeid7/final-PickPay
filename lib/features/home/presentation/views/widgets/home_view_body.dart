import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/footer_widget.dart';
import 'package:pickpay/features/home/presentation/views/widgets/Fashion_section/fashion_grid.dart';
import 'package:pickpay/features/home/presentation/views/widgets/Fashion_section/fashion_header.dart';
import 'package:pickpay/features/home/presentation/views/widgets/appliances_section/appliances_grid.dart';
import 'package:pickpay/features/home/presentation/views/widgets/appliances_section/appliances_header.dart';
import 'package:pickpay/features/home/presentation/views/widgets/beauty_section/beauty_grid.dart';
import 'package:pickpay/features/home/presentation/views/widgets/beauty_section/beauty_header.dart';
import 'package:pickpay/core/widgets/custom_appbar.dart';
import 'package:pickpay/features/home/presentation/views/widgets/electronics_section/electronics_grid_view.dart';
import 'package:pickpay/features/home/presentation/views/widgets/electronics_section/electronics_header.dart';
import 'package:pickpay/features/home/presentation/views/widgets/home_section/home_section_grid.dart';
import 'package:pickpay/features/home/presentation/views/widgets/home_section/home_section_header.dart';
import 'package:pickpay/features/home/presentation/views/widgets/recommended_section/recommended_foru_grid_view.dart';
import 'package:pickpay/features/home/presentation/views/widgets/recommended_section/recommended_foru_header.dart';
import 'package:pickpay/features/home/presentation/views/widgets/sliding_cards_bannars/sliding_cards_feature_list.dart';
import 'package:pickpay/features/home/presentation/views/widgets/todays_sale_section/todays_sale_grid_view.dart';
import 'package:pickpay/features/home/presentation/views/widgets/video_games_bestsellers/vgames_grid.dart';
import 'package:pickpay/features/home/presentation/views/widgets/video_games_bestsellers/vigames_section_header.dart';
import 'package:pickpay/features/sub_categories/appliances/appliances_grid.dart';
import 'package:pickpay/features/sub_categories/appliances/appliances_header.dart';
import 'package:pickpay/features/sub_categories/beauty/subbeauty_grid.dart';
import 'package:pickpay/features/sub_categories/beauty/subbeauty_header.dart';
import 'package:pickpay/features/sub_categories/electronics/elec_header.dart';
import 'package:pickpay/features/sub_categories/electronics/electronics_grid.dart';
import 'package:pickpay/features/sub_categories/fashion/subfashion_grid.dart';
import 'package:pickpay/features/sub_categories/fashion/subfashion_header.dart';
import 'package:pickpay/features/sub_categories/home_products/subhome_header.dart';
import 'package:pickpay/features/sub_categories/home_products/subhomes_grid.dart';
import 'package:pickpay/features/sub_categories/subvideo_games/subvideo_grid.dart';
import 'package:pickpay/features/sub_categories/subvideo_games/subvideo_header.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            CustomHomeAppbar(),
            SizedBox(height: 12),
            SlidingFeaturedList(),
            SizedBox(height: 20),
            RecommendedForuHeader(),
            SizedBox(height: 16),
            RecommendedForuGridView(),
            SizedBox(height: 16),
            TodaysSaleGridView(),
            SizedBox(height: 16),
            SubElecHeader(),
            SizedBox(height: 16),
            SubElectronicsGrid(),
            ElectronicsHeader(),
            SizedBox(height: 16),
            ElectronicsCarouselView(),
            SizedBox(height: 16),
            SubAppliancesHeader(),
            SizedBox(height: 16),
            SubAppliancesGrid(),
            SizedBox(height: 16),
            AppliancesHeader(),
            SizedBox(height: 16),
            AppliancesGrid(),
            SizedBox(height: 16),
            SubhomeHeader(),
            SizedBox(height: 16),
            SubhomesGrid(),
            HomeSectionHeader(),
            SizedBox(height: 16),
            HomeSectionGrid(),
            SizedBox(height: 16),
            SubvideoHeader(),
            SizedBox(height: 16),
            SubvideoGrid(),
            SizedBox(height: 16),
            VigamesSectionHeader(),
            SizedBox(height: 16),
            VgamesGrid(),
            SizedBox(height: 16),
            SubfashionHeader(),
            SizedBox(height: 16),
            SubfashionGrid(),
            SizedBox(height: 16),
            FashionHeader(),
            SizedBox(height: 16),
            FashionGrid(),
            SizedBox(height: 16),
            SubbeautyHeader(),
            SizedBox(height: 16),
            SubbeautyGrid(),
            SizedBox(height: 16),
            BeautyHeader(),
            SizedBox(height: 16),
            BeautyGrid(),
            SizedBox(height: 16),
            FooterWidget()
          ],
        ),
      ),
    );
  }
}
