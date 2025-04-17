import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/custom_button.dart';
import 'package:pickpay/features/checkout/presentation/views/widgets/checkout_steps.dart';
import 'package:pickpay/features/checkout/presentation/views/widgets/checkout_steps_page_view.dart';

class CheckoutViewBody extends StatefulWidget {
  const CheckoutViewBody({super.key});

  @override
  State<CheckoutViewBody> createState() => _CheckoutViewBodyState();
}

class _CheckoutViewBodyState extends State<CheckoutViewBody> {
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    pageController.addListener(() {
      setState(() {
        currentPageIndex = pageController.page!.toInt();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          CheckoutSteps(
            pageController: pageController,
            currentPageIndex: currentPageIndex,
          ),
          Expanded(
              child: CheckoutStepsPageView(pageController: pageController)),
          CustomButton(
            onPressed: () {
              pageController.animateToPage(
                currentPageIndex + 1,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            },
            buttonText: getNextButtonText(currentPageIndex),
          ),
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }

  String getNextButtonText(int currentPageIndex) {
    switch (currentPageIndex) {
      case 0:
        return 'Next';
      case 1:
        return 'Next';
      case 2:
        return 'Place order';
      default:
        return 'Next';
    }
  }
}
