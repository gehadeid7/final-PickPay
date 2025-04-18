import 'package:pickpay/core/utils/app_images.dart';

class BottomNavigationBarEntity {
  final String activeImage, inActiveImage;
  final String name;

  BottomNavigationBarEntity(
      {required this.activeImage,
      required this.inActiveImage,
      required this.name});
}

List<BottomNavigationBarEntity> get bottomNavigationBarItems => [
      BottomNavigationBarEntity(
          activeImage: Assets.navHomeIcon,
          inActiveImage: Assets.navUnFillHomeIcon,
          name: 'Home'),
      BottomNavigationBarEntity(
          activeImage: Assets.navCategoriesIcon,
          inActiveImage: Assets.navUnFillCategoriesIcon,
          name: 'Categories'),
      BottomNavigationBarEntity(
          activeImage: Assets.navCartIcon,
          inActiveImage: Assets.navUnFillCartIcon,
          name: 'Cart'),
      BottomNavigationBarEntity(
          activeImage: Assets.navAccountIcon,
          inActiveImage: Assets.navUnFillAccountIcon,
          name: 'Profile'),
    ];
