// bottom_navigation/bottom_navigation_items.dart
import 'package:pickpay/core/utils/app_images.dart';
import 'package:pickpay/features/bottom_navigation/entities/bottom_navigation_bar_entity.dart';

List<BottomNavigationBarEntity> bottomNavigationBarItems = [
  BottomNavigationBarEntity(
    activeImage: Assets.navHomeIcon,
    inActiveImage: Assets.navUnFillHomeIcon,
    name: 'Home',
  ),
  BottomNavigationBarEntity(
    activeImage: Assets.navCategoriesIcon,
    inActiveImage: Assets.navUnFillCategoriesIcon,
    name: 'Categories',
  ),
  BottomNavigationBarEntity(
    activeImage: Assets.navCartIcon,
    inActiveImage: Assets.navUnFillCartIcon,
    name: 'Cart',
  ),
  BottomNavigationBarEntity(
    activeImage: Assets.navAccountIcon,
    inActiveImage: Assets.navUnFillAccountIcon,
    name: 'Profile',
  ),
];
