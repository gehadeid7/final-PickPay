import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';

class HomeItem extends StatelessWidget {
  const HomeItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 250,
      decoration: ShapeDecoration(
        color: Color(0xFFF3F5F7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                SizedBox(
                  height :20
                ),
                Image.asset('assets/elecCat/AirPodsPro.jpeg'),
                ListTile(
                  title: Text('elec name',
                  style: TextStyles.semiBold13
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
