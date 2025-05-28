import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/features/home/presentation/cubits/categories_cubits/categories_cubits_cubit.dart';
import 'package:pickpay/features/home/presentation/cubits/categories_cubits/categories_cubits_state.dart';
import 'package:pickpay/features/home/presentation/views/widgets/category_navigation_helper.dart';
import 'package:provider/provider.dart';
import 'package:pickpay/core/themes/theme_provider.dart';
import 'package:pickpay/core/widgets/footer_widget.dart';
import 'package:pickpay/features/home/presentation/views/widgets/Fashion_section/fashion_grid.dart';
import 'package:pickpay/features/home/presentation/views/widgets/Fashion_section/fashion_header.dart';
import 'package:pickpay/features/home/presentation/views/widgets/appliances_section/appliances_grid.dart';
import 'package:pickpay/features/home/presentation/views/widgets/appliances_section/appliances_header.dart';
import 'package:pickpay/features/home/presentation/views/widgets/beauty_section/beauty_grid.dart';
import 'package:pickpay/features/home/presentation/views/widgets/beauty_section/beauty_header.dart';
import 'package:pickpay/features/home/presentation/views/widgets/electronics_section/electronics_grid_view.dart';
import 'package:pickpay/features/home/presentation/views/widgets/electronics_section/electronics_header.dart';
import 'package:pickpay/features/home/presentation/views/widgets/home_section/home_section_grid.dart';
import 'package:pickpay/features/home/presentation/views/widgets/home_section/home_section_header.dart';
import 'package:pickpay/features/home/presentation/views/widgets/recommended_section/recommended_foru_header.dart';
import 'package:pickpay/features/home/presentation/views/widgets/recommended_section/recommended_foru_grid_view.dart';
import 'package:pickpay/features/home/presentation/views/widgets/sliding_cards_bannars/sliding_cards_feature_list.dart';
import 'package:pickpay/features/home/presentation/views/widgets/todays_sale_section/todays_sale_grid_view.dart';
import 'package:pickpay/features/home/presentation/views/widgets/video_games_bestsellers/vgames_grid.dart';
import 'package:pickpay/features/home/presentation/views/widgets/video_games_bestsellers/vigames_section_header.dart';
import 'package:pickpay/core/widgets/custom_appbar.dart';
import 'package:pickpay/features/home/presentation/views/widgets/category_card.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomHomeAppbar(),
                  const SlidingFeaturedList(),
                  const SizedBox(height: 20),

                  // Categories section with horizontal sliding
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'Top collections',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 130,
                    child: BlocBuilder<CategoriesCubit, CategoriesState>(
                      builder: (context, state) {
                        if (state is CategoriesLoading) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        } else if (state is CategoriesLoaded) {
                          return ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            itemCount: state.categories.length,
                            clipBehavior: Clip.none,
                            itemBuilder: (context, index) {
                              final category = state.categories[index];
                              return CategoryCard(
                                imagePath: category.image,
                                categoryName: category.name,
                                index: index,
                                onTap: () => navigateToCategory(
                                  context,
                                  category.name,
                                ),
                              );
                            },
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  const RecommendedForuHeader(),
                  const SizedBox(height: 16),
                  const RecommendedForuGridView(),
                  const SizedBox(height: 20),
                  const TodaysSaleGridView(),
                  const SizedBox(height: 20),
                  const ElectronicsHeader(),
                  const SizedBox(height: 16),
                  const ElectronicsCarouselView(),
                  const SizedBox(height: 20),
                  const AppliancesHeader(),
                  const SizedBox(height: 16),
                  const AppliancesGrid(),
                  const SizedBox(height: 20),
                  const HomeSectionHeader(),
                  const SizedBox(height: 16),
                  const HomeSectionGrid(),
                  const SizedBox(height: 20),
                  const VigamesSectionHeader(),
                  const SizedBox(height: 16),
                  const VgamesGrid(),
                  const SizedBox(height: 20),
                  const FashionHeader(),
                  const SizedBox(height: 16),
                  const FashionGrid(),
                  const SizedBox(height: 20),
                  const BeautyHeader(),
                  const SizedBox(height: 16),
                  const BeautyGrid(),
                  const SizedBox(height: 30),
                  const FooterWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularCategoryCard(
    BuildContext context,
    String categoryName,
    String imagePath,
    bool isDarkMode,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDarkMode ? Colors.grey[900] : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                categoryName,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
