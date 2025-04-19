import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';

AppBar buildCategoryAppBar(context, {required String title}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    leading: GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(
        Icons.arrow_back_ios_new,
      ),
    ),
    centerTitle: true,
    elevation: 0,
    title: Text(
      title,
      style: TextStyles.bold19,
    ),
  );
}
