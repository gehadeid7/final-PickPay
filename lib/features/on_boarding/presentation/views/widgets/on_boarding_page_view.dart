import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_images.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/features/on_boarding/presentation/views/widgets/page_view_item.dart';

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
          image: Assets.onBoardingImage1,
          backgroundimage: Assets.pageViewItem1BkColor,
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
          image: Assets.onBoardingImage2,
          backgroundimage: Assets.pageViewItem2BkColor,
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
