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
            SlidingFeaturedList(),
            SizedBox(height: 12),
            RecommendedForuHeader(),
            SizedBox(height: 12),
            RecommendedForuGridView(),
            SizedBox(height: 12),
            TodaysSaleGridView(),
            SizedBox(height: 12),
            SubElecHeader(),
            SizedBox(height: 12),
            SubElectronicsGrid(),
            ElectronicsHeader(),
            SizedBox(height: 12),
            ElectronicsCarouselView(),
            SizedBox(height: 12),
            SubAppliancesHeader(),
            SizedBox(height: 12),
            SubAppliancesGrid(),
            SizedBox(height: 12),
            AppliancesHeader(),
            SizedBox(height: 12),
            AppliancesGrid(),
            SizedBox(height: 12),
            SubhomeHeader(),
            SizedBox(height: 12),
            SubhomesGrid(),
            HomeSectionHeader(),
            SizedBox(height: 12),
            HomeSectionGrid(),
            SizedBox(height: 12),
            SubvideoHeader(),
            SizedBox(height: 12),
            SubvideoGrid(),
            SizedBox(height: 12),
            VigamesSectionHeader(),
            SizedBox(height: 12),
            VgamesGrid(),
            SizedBox(height: 12),
            SubfashionHeader(),
            SizedBox(height: 12),
            SubfashionGrid(),
            SizedBox(height: 12),
            FashionHeader(),
            SizedBox(height: 12),
            FashionGrid(),
            SizedBox(height: 12),
            SubbeautyHeader(),
            SizedBox(height: 12),
            SubbeautyGrid(),
            SizedBox(height: 12),
            BeautyHeader(),
            SizedBox(height: 12),
            BeautyGrid(),
            SizedBox(height: 24),
            FooterWidget()
          ],
        ),
      ),
    );
  }
}
