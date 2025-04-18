import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_colors.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';

class ActiveItem extends StatelessWidget {
  const ActiveItem({super.key, required this.text, required this.image});

  final String text;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4),
        decoration: ShapeDecoration(
          color: const Color.fromARGB(255, 223, 223, 223),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: ShapeDecoration(
                color: const Color.fromARGB(173, 33, 149, 243),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              child: Center(
                child: Image.asset(
                  image,
                  width: 25,
                  height: 25,
                ),
              ),
            ),
            SizedBox(width: 2),
            Text(
              text,
              style: TextStyles.semiBold13.copyWith(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
