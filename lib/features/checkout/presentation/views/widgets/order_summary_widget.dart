import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_colors.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/features/checkout/presentation/views/widgets/payment_item.dart';

class OrderSummaryWidget extends StatelessWidget {
  const OrderSummaryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PaymentItem(
      title: 'Order Summary',
      child: Column(
        children: [
          Row(
            children: [
              Text('Subtotal',
                  style: TextStyles.regular13.copyWith(
                    color: AppColors.secondColor,
                    fontSize: 15,
                  )),
              const Spacer(),
              Text(
                '150 Egp',
                style: TextStyles.bold16,
              )
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Text('Delivery :',
                  style: TextStyles.regular13.copyWith(
                    color: AppColors.secondColor,
                    fontSize: 15,
                  )),
              const Spacer(),
              Text('50 Egp',
                  style: TextStyles.regular16.copyWith(
                    color: AppColors.secondColor,
                  ))
            ],
          ),
          SizedBox(height: 9),
          Divider(
            thickness: .5,
            color: Color(0xFFCACECE),
          ),
          SizedBox(height: 9),
          Row(
            children: [
              Text('All',
                  style: TextStyles.bold13.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                  )),
              const Spacer(),
              Text('200 Egp',
                  style: TextStyles.bold13.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
