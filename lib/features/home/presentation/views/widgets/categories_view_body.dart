import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/themes/theme_provider.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/features/home/presentation/cubits/categories_cubits/categories_cubits_cubit.dart';
import 'package:pickpay/features/home/presentation/cubits/categories_cubits/categories_cubits_state.dart';
import 'package:pickpay/features/home/presentation/views/widgets/category_navigation_helper.dart';
import 'package:pickpay/core/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class CategoriesViewBody extends StatelessWidget {
  const CategoriesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        SizedBox(height: kTopPadding),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CustomHomeAppbar(),
        ),
        const SizedBox(height: 22),
        Expanded(
          child: BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (state is CategoriesLoaded) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.85,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      final category = state.categories[index];
                      return _CatchyCategoryCard(
                        categoryName: category.name,
                        imagePath: category.image,
                        isDarkMode: isDarkMode,
                        index: index,
                        onTap: () => navigateToCategory(context, category.name),
                      );
                    },
                  ),
                );
              } else if (state is CategoriesError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 48,
                        color: colorScheme.error,
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: TextStyles.regular16.copyWith(
                            color: colorScheme.onBackground.withOpacity(0.7),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                        ),
                        onPressed: () =>
                            context.read<CategoriesCubit>().loadCategories(),
                        child: Text(
                          'Try Again',
                          style: TextStyles.regular16,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}

class _CatchyCategoryCard extends StatefulWidget {
  final String categoryName;
  final String imagePath;
  final bool isDarkMode;
  final int index;
  final VoidCallback onTap;

  const _CatchyCategoryCard({
    required this.categoryName,
    required this.imagePath,
    required this.isDarkMode,
    required this.index,
    required this.onTap,
  });

  @override
  State<_CatchyCategoryCard> createState() => _CatchyCategoryCardState();
}

class _CatchyCategoryCardState extends State<_CatchyCategoryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _alignmentAnimation;

  static const List<List<Color>> _gradientColorsLight = [
    [Color(0xFFA8DADC), Color(0xFF457B9D)], // Soft cyan to muted blue
    [Color(0xFFF1FAEE), Color(0xFFA8DADC)], // Very light mint to soft cyan
    [Color(0xFFEAEAEA), Color(0xFFB0BEC5)], // Light grey to cool steel blue
    [Color(0xFFD4ECDD), Color(0xFF8FB9A8)], // Pale green to sage green
    [Color(0xFFF9F7F7), Color(0xFFD3C0CD)], // Soft off-white to muted mauve
    [Color(0xFFF4E1D2), Color(0xFFBC9CA3)], // Light peach to dusty rose
  ];

  static const List<List<Color>> _gradientColorsDark = [
    [Color(0xFF1D3557), Color(0xFF457B9D)], // Deep navy to muted blue
    [Color(0xFF2A3A40), Color(0xFF5C6B73)], // Dark slate to dusty grey-blue
    [Color(0xFF36454F), Color(0xFF576F72)], // Charcoal to teal-grey
    [Color(0xFF3B3A40), Color(0xFF6D7B8D)], // Dark charcoal to muted blue-grey
    [Color(0xFF5C4D7D), Color(0xFF7E6A9E)], // Dusty purple to lavender-grey
    [Color(0xFF4B474A), Color(0xFF7E7A82)], // Dark grey to soft lavender-grey
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);

    _alignmentAnimation = Tween<Alignment>(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Color> _getGradientColors(bool isDarkMode, int index) {
    final colors = isDarkMode ? _gradientColorsDark : _gradientColorsLight;
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = widget.isDarkMode;

    final gradientColors = _getGradientColors(isDark, widget.index);

    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: gradientColors,
                begin: _alignmentAnimation.value,
                end: Alignment.center,
              ),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withOpacity(0.6)
                      : Colors.grey.withOpacity(0.2),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    widget.imagePath,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                        colors: [
                          Colors.black.withOpacity(0.35),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            gradientColors[1].withOpacity(0.85),
                            gradientColors[0].withOpacity(0.7),
                          ],
                        ),
                      ),
                      child: Text(
                        widget.categoryName.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.0,
                          shadows: [
                            Shadow(
                              blurRadius: 4,
                              color: Colors.black.withOpacity(0.5),
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
