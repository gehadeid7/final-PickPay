import 'package:flutter/material.dart';
import 'package:pickpay/features/bottom_navigation/entities/bottom_navigation_bar_entity.dart';
import 'package:pickpay/features/bottom_navigation/active_item.dart';
import 'package:pickpay/features/bottom_navigation/in_active_item.dart';

class NavigationBarItem extends StatelessWidget {
  const NavigationBarItem({
    super.key,
    required this.isSelected,
    required this.bottomNavigationBarEntity,
    this.itemCount,
  });

  final bool isSelected;
  final BottomNavigationBarEntity bottomNavigationBarEntity;
  final int? itemCount;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.9, end: 1.0).animate(animation),
          child: child,
        ),
      ),
      child: isSelected
          ? ActiveItem(
              key: ValueKey('active-${bottomNavigationBarEntity.name}'),
              image: bottomNavigationBarEntity.activeImage,
              text: bottomNavigationBarEntity.name,
              itemCount: itemCount,
            )
          : InActiveItem(
              key: ValueKey('inactive-${bottomNavigationBarEntity.name}'),
              image: bottomNavigationBarEntity.inActiveImage,
              text: bottomNavigationBarEntity.name,
              itemCount: itemCount,
            ),
    );
  }
}
