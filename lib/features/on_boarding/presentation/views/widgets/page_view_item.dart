import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/services/shared_preferences_singletone.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/features/auth/presentation/views/signin_view.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({
    super.key,
    required this.image,
    required this.backgroundimage,
    required this.subTitle,
    required this.title,
    required this.isVisible,
  });

  final String image, backgroundimage;
  final String subTitle;
  final Widget title;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onBackground;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(backgroundimage, fit: BoxFit.fill),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Image.asset(image, width: 200, height: 200),
              ),
              Positioned(
                top: 15,
                right: 20,
                child: Visibility(
                  visible: isVisible,
                  child: GestureDetector(
                    onTap: () {
                      Prefs.setBool(kIsOnBoardingViewSeen, true);
                      Navigator.of(context)
                          .pushReplacementNamed(SigninView.routeName);
                    },
                    child: Text(
                      'Skip',
                      style: TextStyles.semiBold16.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        DefaultTextStyle.merge(
          style: TextStyle(color: textColor),
          child: title,
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            subTitle,
            textAlign: TextAlign.center,
            style: TextStyles.semiBold16.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ),
      ],
    );
  }
}
