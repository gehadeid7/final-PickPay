import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';

AppBar buildAppBar({required BuildContext context, required String title}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    leading: GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(Icons.arrow_back_ios_new),
    ),
    centerTitle: true,
    title: Text(title, textAlign: TextAlign.center, style: TextStyles.bold19),
  );
}
