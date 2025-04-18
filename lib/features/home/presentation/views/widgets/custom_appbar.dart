import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_images.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/core/widgets/search_text_field.dart';

class CustomHomeAppbar extends StatelessWidget {
  const CustomHomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(children: [
        Image.asset(Assets.appLogo, width: 45, height: 45),
        SizedBox(width: 5),
        Text(
          'Pay',
          style: TextStyle(
            fontFamily: 'Pseudonym',
            fontWeight: FontWeight.w500,
            fontSize: 22,
            color: Colors.black,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Container(
            width: 260,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: SearchTextField(),
          ),
        )
      ]),
    );
  }
}
