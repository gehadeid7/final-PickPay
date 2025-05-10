// custom_bottom_navigation_bar.dart
import 'package:flutter/material.dart';
import 'package:pickpay/features/home/domain/entities/bottom_navigation_bar_entity.dart';
import 'package:pickpay/features/home/presentation/views/widgets/bottom_navigation/navigation_bar_item.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kBottomNavigationBarHeight + 10,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          bottomNavigationBarItems.length,
          (index) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onItemSelected(index),
            child: SizedBox(
              width: MediaQuery.of(context).size.width /
                  bottomNavigationBarItems.length,
              child: NavigationBarItem(
                isSelected: selectedIndex == index,
                bottomNavigationBarEntity: bottomNavigationBarItems[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
