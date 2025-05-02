import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/features/home/presentation/cubits/categories_cubits/categories_cubits_cubit.dart';
import 'package:pickpay/features/home/presentation/cubits/categories_cubits/categories_cubits_state.dart';
import 'package:pickpay/features/home/presentation/views/widgets/category_navigation_helper.dart';
import 'package:pickpay/features/home/presentation/views/widgets/custom_appbar.dart';

class CategoriesViewBody extends StatelessWidget {
  const CategoriesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: kTopPadding),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: CustomHomeAppbar(),
        ),
        Expanded(
          child: BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CategoriesLoaded) {
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .8,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    final category = state.categories[index];

                    return GestureDetector(
                      onTap: () => navigateToCategory(context, category.name),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                category.image,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.5),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  category.name,
                                  style: TextStyles.bold19.copyWith(
                                    color: Colors.white,
                                    shadows: [
                                      const Shadow(
                                        blurRadius: 4,
                                        color: Colors.black,
                                        offset: Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (state is CategoriesError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
