import 'package:flutter/material.dart';
import 'package:pickpay/features/home/domain/entities/bottom_navigation_bar_entity.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 25,
            offset: Offset(0, -2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: bottomNavigationBarItems.map((e) {
          return NavigationBarItem(
            isSelected: false,
          );
        }).toList(),
      ),
    );
  }
}

class InActiveItem extends StatelessWidget {
  const InActiveItem({super.key, required this.image});

  final String image;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(color: Colors.red, child: Image.asset(image)),
    );
  }
}

class NavigationBarItem extends StatelessWidget {
  const NavigationBarItem({super.key, required this.isSelected});

  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return isSelected
        ? ActiveItem()
        : InActiveItem(
            image: 'assets/star.png',
          );
  }
}

class ActiveItem extends StatelessWidget {
  const ActiveItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
