import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_images.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/features/home/presentation/views/widgets/cart_item_action_button.dart';

class CartItem extends StatefulWidget {
  const CartItem({
    super.key,
    // required this.cartItemEntity
  });

  // final CartItemEntity cartItemEntity;
  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFFF6F6FE),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFEDEDED),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  Assets.appLogo,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'product name',
                    style: TextStyles.semiBold16.copyWith(color: Colors.black),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'View details',
                    style: TextStyles.regular11.copyWith(
                      color: const Color.fromARGB(255, 78, 78, 78),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '\$29000',
                        style:
                            TextStyles.semiBold16.copyWith(color: Colors.black),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '25% Offer',
                        style:
                            TextStyles.semiBold13.copyWith(color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // Delete and quantity
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Image.asset(
                    Assets.trash,
                    width: 20,
                    height: 20,
                  ),
                  onPressed: () {},
                ),
                const CartItemActionButtons(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
