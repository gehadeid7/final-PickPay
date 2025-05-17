import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/themes/theme_provider.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/features/home/presentation/cubits/categories_cubits/categories_cubits_cubit.dart';
import 'package:pickpay/features/home/presentation/cubits/categories_cubits/categories_cubits_state.dart';
import 'package:pickpay/features/home/presentation/views/widgets/category_navigation_helper.dart';
import 'package:pickpay/features/home/presentation/views/widgets/custom_appbar.dart';
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
                    child: CircularProgressIndicator.adaptive());
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
                      return AnimatedCategoryCard(
                        categoryName: category.name,
                        imagePath: category.image,
                        isDarkMode: isDarkMode,
                        color: _getCategoryColor(index, colorScheme),
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
                      Icon(Icons.error_outline,
                          size: 48, color: colorScheme.error),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: TextStyles.regular16.copyWith(
                            // ignore: deprecated_member_use
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
                        child: Text('Try Again', style: TextStyles.regular16),
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

  Color _getCategoryColor(int index, ColorScheme colorScheme) {
    final colors = [
      const Color(0xFF6D8B74),
      const Color(0xFF7A6F5F),
      const Color(0xFF6B7A8B),
      const Color(0xFF8B776D),
      const Color(0xFF7A8B6F),
      const Color(0xFF8B6D7A),
    ];
    return colors[index % colors.length];
  }
}

class AnimatedCategoryCard extends StatefulWidget {
  final String categoryName;
  final String imagePath;
  final bool isDarkMode;
  final Color color;
  final VoidCallback onTap;

  const AnimatedCategoryCard({
    super.key,
    required this.categoryName,
    required this.imagePath,
    required this.isDarkMode,
    required this.color,
    required this.onTap,
  });

  @override
  State<AnimatedCategoryCard> createState() => _AnimatedCategoryCardState();
}

class _AnimatedCategoryCardState extends State<AnimatedCategoryCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.0,
      upperBound: 1.0,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          elevation: 6,
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      alignment: Alignment.center,
                      child: const Icon(Icons.broken_image, size: 40),
                    );
                  },
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        // ignore: deprecated_member_use
                        widget.color.withOpacity(0.4),
                        // ignore: deprecated_member_use
                        widget.color.withOpacity(0.2),
                      ],
                    ),
                  ),
                  child: Text(
                    widget.categoryName.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pickpay/constants.dart';
// import 'package:pickpay/core/themes/theme_provider.dart';
// import 'package:pickpay/core/utils/app_text_styles.dart';
// import 'package:pickpay/features/home/presentation/cubits/categories_cubits/categories_cubits_cubit.dart';
// import 'package:pickpay/features/home/presentation/cubits/categories_cubits/categories_cubits_state.dart';
// import 'package:pickpay/features/home/presentation/views/widgets/category_navigation_helper.dart';
// import 'package:pickpay/features/home/presentation/views/widgets/custom_appbar.dart';
// import 'package:provider/provider.dart';

// class CategoriesViewBody extends StatelessWidget {
//   const CategoriesViewBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     final isDarkMode = themeProvider.isDarkMode;
//     final colorScheme = Theme.of(context).colorScheme;

//     return Column(
//       children: [
//         SizedBox(height: kTopPadding),
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16),
//           child: CustomHomeAppbar(),
//         ),
//         const SizedBox(height: 22),
//         Expanded(
//           child: BlocBuilder<CategoriesCubit, CategoriesState>(
//             builder: (context, state) {
//               if (state is CategoriesLoading) {
//                 return const Center(
//                   child: CircularProgressIndicator.adaptive(),
//                 );
//               } else if (state is CategoriesLoaded) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: GridView.builder(
//                     physics: const BouncingScrollPhysics(),
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       childAspectRatio: 0.85,
//                       crossAxisSpacing: 16,
//                       mainAxisSpacing: 16,
//                     ),
//                     itemCount: state.categories.length,
//                     itemBuilder: (context, index) {
//                       final category = state.categories[index];
//                       return _CatchyCategoryCard(
//                         categoryName: category.name,
//                         imagePath: category.image,
//                         isDarkMode: isDarkMode,
//                         color: _getCategoryColor(index, colorScheme),
//                         onTap: () => navigateToCategory(context, category.name),
//                       );
//                     },
//                   ),
//                 );
//               } else if (state is CategoriesError) {
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.error_outline,
//                         size: 48,
//                         color: colorScheme.error,
//                       ),
//                       const SizedBox(height: 16),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 24),
//                         child: Text(
//                           state.message,
//                           textAlign: TextAlign.center,
//                           style: TextStyles.regular16.copyWith(
//                             color: colorScheme.onBackground.withOpacity(0.7),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 24, vertical: 12),
//                         ),
//                         onPressed: () =>
//                             context.read<CategoriesCubit>().loadCategories(),
//                         child: Text(
//                           'Try Again',
//                           style: TextStyles.regular16,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }
//               return const SizedBox.shrink();
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Color _getCategoryColor(int index, ColorScheme colorScheme) {
//     final colors = [
//       const Color(0xFF6D8B74), // Sage green
//       const Color(0xFF7A6F5F), // Taupe
//       const Color(0xFF6B7A8B), // Dusty blue
//       const Color(0xFF8B776D), // Muted clay
//       const Color(0xFF7A8B6F), // Soft fern
//       const Color(0xFF8B6D7A), // Dusky rose
//     ];
//     return colors[index % colors.length];
//   }
// }

// class _CatchyCategoryCard extends StatefulWidget {
//   final String categoryName;
//   final String imagePath;
//   final bool isDarkMode;
//   final Color color;
//   final VoidCallback onTap;

//   const _CatchyCategoryCard({
//     required this.categoryName,
//     required this.imagePath,
//     required this.isDarkMode,
//     required this.color,
//     required this.onTap,
//   });

//   @override
//   State<_CatchyCategoryCard> createState() => _CatchyCategoryCardState();
// }

// class _CatchyCategoryCardState extends State<_CatchyCategoryCard>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _elevationAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 200),
//       vsync: this,
//     );

//     _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOut),
//     );

//     _elevationAnimation = Tween<double>(begin: 6.0, end: 2.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOut),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _onTapDown(TapDownDetails details) {
//     _controller.forward();
//   }

//   void _onTapUp(TapUpDetails details) {
//     _controller.reverse().then((_) => widget.onTap());
//   }

//   void _onTapCancel() {
//     _controller.reverse();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return GestureDetector(
//       onTapDown: _onTapDown,
//       onTapUp: _onTapUp,
//       onTapCancel: _onTapCancel,
//       child: AnimatedBuilder(
//         animation: _controller,
//         builder: (context, child) {
//           return Transform.scale(
//             scale: _scaleAnimation.value,
//             child: child,
//           );
//         },
//         child: Material(
//           borderRadius: BorderRadius.circular(20),
//           elevation: 6,
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 12,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(20),
//               child: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   // Image with fade overlay
//                   _buildImageWithOverlay(),

//                   // Category name with background
//                   Positioned(
//                     left: 0,
//                     right: 0,
//                     bottom: 0,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 12, horizontal: 8),
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment.bottomCenter,
//                           end: Alignment.topCenter,
//                           colors: [
//                             widget.color.withOpacity(0.9),
//                             widget.color.withOpacity(0.7),
//                           ],
//                         ),
//                       ),
//                       child: Text(
//                         widget.categoryName.toUpperCase(),
//                         textAlign: TextAlign.center,
//                         style: theme.textTheme.titleMedium?.copyWith(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w700,
//                           letterSpacing: 0.8,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildImageWithOverlay() {
//     return Stack(
//       fit: StackFit.expand,
//       children: [
//         Image.asset(
//           widget.imagePath,
//           fit: BoxFit.cover,
//         ),
//         Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.bottomCenter,
//               end: Alignment.center,
//               colors: [
//                 Colors.black.withOpacity(0.3),
//                 Colors.transparent,
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
