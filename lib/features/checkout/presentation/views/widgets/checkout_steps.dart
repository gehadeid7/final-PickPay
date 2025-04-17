import 'package:flutter/material.dart';
import 'package:pickpay/features/checkout/presentation/views/widgets/step_item.dart';

class CheckoutSteps extends StatelessWidget {
  const CheckoutSteps({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(getSteps().length, (index) {
        return Expanded(
          child: StepItem(
            isActive: false,
            index: (index + 1).toString(),
            text: getSteps()[index],
          ),
        );
      }),
    );
  }
}

List<String> getSteps() {
  return [
    'Shipping',
    'Address',
    'Payment',
    'Review',
  ];
}
