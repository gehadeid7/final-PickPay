import 'package:flutter/material.dart';
import 'package:pickpay/features/checkout/presentation/views/widgets/shipping_item.dart';

class ShippingSection extends StatefulWidget {
  const ShippingSection({super.key});

  @override
  State<ShippingSection> createState() => _ShippingSectionState();
}

class _ShippingSectionState extends State<ShippingSection> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        ShippingItem(
          onTap: () {
            selectedIndex = 0;
            setState(() {});
          },
          isSelected: selectedIndex == 0,
          title: 'Cash on Delivery',
          subTitle: 'Delivered to your address',
          price: '60',
        ),
        SizedBox(
          height: 16,
        ),
        ShippingItem(
          onTap: () {
            selectedIndex = 1;
            setState(() {});
          },
          isSelected: selectedIndex == 1,
          title: 'Online Payment',
          subTitle: 'Please select a payment method',
          price: '60',
        ),
      ],
    );
  }
}
