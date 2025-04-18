import 'package:flutter/material.dart';

class HomeItem extends StatelessWidget {
  const HomeItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 200,
      decoration: ShapeDecoration(
        color: Color(0xFFF3F5F7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Image.asset('assets/elecCat/AirPodsPro.jpeg'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
