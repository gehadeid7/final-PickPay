import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_images.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/core/widgets/search_text_field.dart';
import 'package:pickpay/core/themes/theme_switch_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/features/wishlist/wishlist_cubits/wishlist_cubit.dart';
import 'package:pickpay/features/wishlist/wishlist_view.dart';

class CustomHomeAppbar extends StatelessWidget {
  const CustomHomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final containerColor = isDarkMode ? Colors.grey[800] : Colors.grey.shade200;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              Assets.appLogo,
              width: 45,
              height: 45,
            ),
            const SizedBox(width: 5),
            Text(
              'PickPay',
              style: TextStyles.bold23.copyWith(
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
            ),
            const Spacer(),
            BlocBuilder<WishlistCubit, WishlistState>(
              builder: (context, state) {
                int wishlistCount = 0;
                if (state is WishlistLoaded) {
                  wishlistCount = state.items.length;
                }

                return Row(
                  children: [
                    // Wishlist Icon in themed container
                    Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: containerColor,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.favorite_border_rounded,
                              size: 24,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WishlistView(),
                                ),
                              );
                            },
                          ),
                          if (wishlistCount > 0)
                            Positioned(
                              top: 5,
                              right: 5,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.redAccent,
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 16,
                                  minHeight: 16,
                                ),
                                child: Text(
                                  wishlistCount.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Theme switch in same styled container
                    Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: containerColor,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Center(child: ThemeSwitchButton()),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: SearchTextField(),
        ),
      ],
    );
  }
}
