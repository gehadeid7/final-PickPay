import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pickpay/core/utils/app_colors.dart';
import 'package:pickpay/core/utils/app_images.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/features/on_boarding/presentation/views/widgets/page_view_item.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingPageView extends StatefulWidget {
  const OnBoardingPageView({super.key, required this.pageController});

  final PageController pageController;

  @override
  State<OnBoardingPageView> createState() => _OnBoardingPageViewState();
}

class _OnBoardingPageViewState extends State<OnBoardingPageView> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: widget.pageController,
      children: [
        PageViewItem(
          isVisible: true,
          image: Lottie.asset(
            "assets/animations/onboarding1.json",
          ),
          backgroundimage: SvgPicture.asset(
            Assets.pageViewItem2BkColor,
            fit: BoxFit.fill,
            color: Color(0xFF83AFE0),
          ),
          subTitle:
              'Choose what you love, pay your way,  and enjoy the experience - simple as that.',
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('pick', style: TextStyles.bold23),
              Text(' • ', style: TextStyles.bold23),
              Text('Pay', style: TextStyles.bold23),
              Text(' • ', style: TextStyles.bold23),
              Text('Enjoy', style: TextStyles.bold23),
            ],
          ),
        ),
        PageViewItem(
          isVisible: false,
          image: Lottie.asset("assets/animations/on22.json"),
          backgroundimage: SvgPicture.asset(
            Assets.pageViewItem2BkColor,
            fit: BoxFit.fill,
            color: AppColors.primaryColor,
          ),
          subTitle:
              'Browse thousands of products, find the best deals, and experience shopping like never before.',
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Discover Amazing Deals',
                style: TextStyles.bold23,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
