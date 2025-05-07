// import 'package:flutter/material.dart';
// import 'package:pickpay/features/checkout/presentation/views/widgets/active_step_item.dart';
// import 'package:pickpay/features/checkout/presentation/views/widgets/in_active_step_item.dart';

// class StepItem extends StatelessWidget {
//   const StepItem(
//       {super.key,
//       required this.index,
//       required this.text,
//       required this.isActive});

//   final String index, text;
//   final bool isActive;
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedCrossFade(
//       firstChild: InActiveStepItem(
//         inActiveIndex: index,
//         inActiveText: text,
//       ),
//       secondChild: ActiveStepItem(
//         activeStepText: text,
//       ),
//       crossFadeState:
//           isActive ? CrossFadeState.showSecond : CrossFadeState.showFirst,
//       duration: Duration(milliseconds: 300),
//     );
//   }
// }
