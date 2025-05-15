import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';

AppBar buildAppBar({
  required BuildContext context,
  required String title,
  List<Widget>? actions,
  bool automaticallyImplyLeading = true,
  VoidCallback? onBackPressed,
  Color? backgroundColor,
  Color? iconColor,
  double elevation = 0,
  TextStyle? titleStyle,
  bool centerTitle = true,
}) {
  final theme = Theme.of(context);
  final isDarkMode = theme.brightness == Brightness.dark;

  return AppBar(
    backgroundColor: backgroundColor ?? theme.appBarTheme.backgroundColor,
    automaticallyImplyLeading: automaticallyImplyLeading,
    leading: automaticallyImplyLeading
        ? IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: 20,
              color: iconColor ?? (isDarkMode ? Colors.white : Colors.black),
            ),
            onPressed: onBackPressed ??
                () {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      Navigator.maybePop(context);
                    }
                  });
                },
          )
        : null,
    centerTitle: centerTitle,
    title: Text(
      title,
      style: titleStyle ??
          TextStyles.bold19.copyWith(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
    ),
    actions: actions,
    elevation: elevation,
    iconTheme: IconThemeData(
      color: iconColor ?? (isDarkMode ? Colors.white : Colors.black),
    ),
  );
}
