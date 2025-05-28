import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/appliances/presentation/views/appliances_view.dart';
import 'package:pickpay/features/categories_pages/beauty/presentation/views/beauty_view.dart';
import 'package:pickpay/features/categories_pages/electronics/presentation/views/electronics_view.dart';
import 'package:pickpay/features/categories_pages/fashion/presentation/views/fashion_view.dart';
import 'package:pickpay/features/categories_pages/homeCategory/presentation/views/home_category_view.dart';
import 'package:pickpay/features/categories_pages/videogames/presentation/views/videogames_view.dart';
import 'package:pickpay/features/sub_categories/electronics/laptop_page.dart';
import 'package:pickpay/features/sub_categories/electronics/mobile_and_tablets_page.dart';
import 'package:pickpay/features/sub_categories/electronics/tvs_page.dart';
import 'package:pickpay/features/sub_categories/appliances/large_appliances.dart';
import 'package:pickpay/features/sub_categories/appliances/small_appliances.dart';
import 'package:pickpay/features/sub_categories/home_products/Furniture.dart';
import 'package:pickpay/features/sub_categories/home_products/bath.dart';
import 'package:pickpay/features/sub_categories/home_products/home_decor.dart';
import 'package:pickpay/features/sub_categories/home_products/kitchen.dart';
import 'package:pickpay/features/sub_categories/fashion/kids.dart';
import 'package:pickpay/features/sub_categories/fashion/men.dart';
import 'package:pickpay/features/sub_categories/fashion/women.dart';
import 'package:pickpay/features/sub_categories/beauty/fragrance.dart';
import 'package:pickpay/features/sub_categories/beauty/haircare.dart';
import 'package:pickpay/features/sub_categories/beauty/makeup.dart';
import 'package:pickpay/features/sub_categories/beauty/skincare.dart';
import 'package:pickpay/features/sub_categories/subvideo_games/accessories.dart';
import 'package:pickpay/features/sub_categories/subvideo_games/console.dart';
import 'package:pickpay/features/sub_categories/subvideo_games/controllers.dart';

void navigateToCategory(BuildContext context, String category) {
  final normalized = category.toLowerCase().trim();
  final page = _getCategoryPage(normalized);

  if (page != null) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }
}

Widget? _getCategoryPage(String category) {
  // Main categories
  switch (category) {
    case 'electronics':
      return const ElectronicsView();
    case 'appliances':
      return const AppliancesView();
    case 'home':
      return const HomeCategoryView();
    case 'fashion':
      return const FashionView();
    case 'beauty':
      return const BeautyView();
    case 'video games':
      return const VideogamesView();
  }

  // Electronics subcategories
  switch (category) {
    case 'mobile & tablets':
      return MobileAndTabletsPage();
    case 'tvs':
      return TvsPage();
    case 'laptop':
      return LaptopPage();
  }

  // Appliances subcategories
  switch (category) {
    case 'large appliances':
      return LargeAppliances();
    case 'small appliances':
      return SmallAppliances();
  }

  // Home subcategories
  switch (category) {
    case 'furniture':
      return FurnitureView();
    case 'home decor':
      return HomeDecorview();
    case 'bath & bedding':
      return BathView();
    case 'kitchen & dining':
      return Kitchenview();
  }

  // Fashion subcategories
  switch (category) {
    case "women's fashion":
      return Women();
    case "men's fashion":
      return Men();
    case "kids' fashion":
      return Kids();
  }

  // Beauty subcategories
  switch (category) {
    case 'makeup':
      return Makeup();
    case 'skincare':
      return Skincare();
    case 'haircare':
      return Haircare();
    case 'fragrance':
      return Fragrance();
  }

  // Video Games subcategories
  switch (category) {
    case 'console':
      return Console();
    case 'controllers':
      return Controllers();
    case 'accessories':
      return Accessories();
  }

  // If no match found
  return null;
}
