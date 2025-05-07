// import 'package:flutter/material.dart';
// import 'package:pickpay/features/checkout/presentation/views/widgets/address_input_section.dart';
// import 'package:pickpay/features/checkout/presentation/views/widgets/payment_section.dart';
// import 'package:pickpay/features/checkout/presentation/views/widgets/shipping_section.dart';

// class CheckoutStepsPageView extends StatelessWidget {
//   const CheckoutStepsPageView({
//     super.key,
//     required this.pageController,
//   });

//   final PageController pageController;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 16),
//       child: PageView.builder(
//         controller: pageController,
//         physics: NeverScrollableScrollPhysics(),
//         itemCount: getPages().length,
//         itemBuilder: (context, index) {
//           return getPages()[index];
//         },
//       ),
//     );
//   }

//   List<Widget> getPages() {
//     return [
//       ShippingSection(),
//       AddressInputSection(),
//       PaymentSection(),

//     ];
//   }
// }
