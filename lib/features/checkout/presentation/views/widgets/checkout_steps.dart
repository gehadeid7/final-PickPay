// import 'package:flutter/material.dart';
// import 'package:pickpay/features/checkout/presentation/views/widgets/step_item.dart';

// class CheckoutSteps extends StatelessWidget {
//   const CheckoutSteps(
//       {super.key,
//       required this.currentPageIndex,
//       required this.pageController});

//   final int currentPageIndex;
//   final PageController pageController;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: List.generate(getSteps().length, (index) {
//         return Expanded(
//           child: GestureDetector(
//             onTap: () {
//               pageController.animateToPage(index,
//                   duration: Duration(milliseconds: 300), curve: Curves.easeIn);
//             },
//             child: StepItem(
//               isActive: index <= currentPageIndex,
//               index: (index + 1).toString(),
//               text: getSteps()[index],
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }

// List<String> getSteps() {
//   return [
//     'Shipping',
//     'Address',
//     'Payment',
//     // 'Review',
//   ];
// }
