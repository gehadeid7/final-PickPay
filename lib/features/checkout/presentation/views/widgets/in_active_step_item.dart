// import 'package:flutter/material.dart';
// import 'package:pickpay/core/utils/app_text_styles.dart';

// class InActiveStepItem extends StatelessWidget {
//   const InActiveStepItem({super.key, required this.inActiveIndex, required this.inActiveText});

//   final String inActiveIndex;
//   final String inActiveText;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         CircleAvatar(
//           radius: 10,
//           backgroundColor: const Color.fromARGB(255, 213, 213, 213),
//           child: Text(
//             inActiveIndex,
//             style: TextStyles.semiBold13,
//           ),
//         ),
//         SizedBox(
//           width: 4,
//         ),
//         Text(
//           inActiveText,
//           style: TextStyles.semiBold13.copyWith(
//             color: Color(0xFFAAAAAA),
//           ),
//         ),
//       ],
//     );
//   }
// }
