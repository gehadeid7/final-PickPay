// bottom_navigation/custom_bottom_navigation_bar.dart
import 'package:flutter/material.dart';
import 'package:pickpay/features/bottom_navigation/bottom_navigation_items.dart';
import 'package:pickpay/features/bottom_navigation/navigation_bar_item.dart';

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
    final size = MediaQuery.of(context).size;

    return Container(
      height: kBottomNavigationBarHeight + 12,
      padding: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.0, -0.8), // 80% above center
          end: Alignment(0.0, 0.5), // 50% below center
          colors: Theme.of(context).brightness == Brightness.dark
              ? [
                  Colors.grey.shade800,
                  Colors.grey.shade900,
                ]
              : [
                  Colors.blue.shade50,
                  Colors.white,
                ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            spreadRadius: 0,
            offset: const Offset(0, -4),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutQuad,
            left:
                (size.width / bottomNavigationBarItems.length) * selectedIndex,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                width: 80,
                height: 3,
                margin: const EdgeInsets.only(top: 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 32, 140, 229),
                      Colors.lightBlueAccent
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              bottomNavigationBarItems.length,
              (index) => GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onItemSelected(index),
                child: SizedBox(
                  width: size.width / bottomNavigationBarItems.length,
                  child: NavigationBarItem(
                    isSelected: selectedIndex == index,
                    bottomNavigationBarEntity: bottomNavigationBarItems[index],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
