// features/checkout/presentation/views/order_confirmation_view.dart
import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_colors.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/core/widgets/custom_app.dart';
import 'package:pickpay/core/widgets/custom_button.dart';
import 'package:pickpay/features/checkout/domain/models/checkout_model.dart';
import 'package:pickpay/features/home/presentation/views/home_view.dart';

class OrderConfirmationView extends StatelessWidget {
  final OrderModel order;

  const OrderConfirmationView({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Order Confirmation'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 80,
            ),
            const SizedBox(height: 16),
            Text(
              'Thank you for your order!',
              style: TextStyles.bold19.copyWith(color: AppColors.primaryColor),
            ),
            const SizedBox(height: 8),
            Text(
              'Your order has been placed successfully',
              style: TextStyles.regular16,
            ),
            const SizedBox(height: 24),
            _buildOrderInfoCard(),
            const SizedBox(height: 24),
            _buildShippingInfoCard(),
            const SizedBox(height: 24),
            _buildPaymentInfoCard(),
            const SizedBox(height: 32),
            CustomButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(HomeView.routeName);
              },
              buttonText: 'Continue Shopping',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderInfoCard() {
    return Card(
      color: const Color.fromARGB(255, 243, 243, 243),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Details',
              style: TextStyles.bold16.copyWith(color: AppColors.primaryColor),
            ),
            const SizedBox(height: 12),
            _buildInfoRow('Order Number', order.id),
            _buildInfoRow('Order Date',
                '${order.date.day}/${order.date.month}/${order.date.year}'),
            _buildInfoRow('Status', order.status),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            Text(
              'Items (${order.items.length})',
              style: TextStyles.semiBold13,
            ),
            const SizedBox(height: 8),
            ...order.items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${item.product.title} x ${item.quantity}',
                          style: TextStyles.regular13,
                        ),
                      ),
                      Text(
                        'EGP ${(item.product.price * item.quantity).toStringAsFixed(2)}',
                        style: TextStyles.semiBold13,
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Total',
                    style: TextStyles.bold16,
                  ),
                ),
                Text(
                  'EGP ${order.total.toStringAsFixed(2)}',
                  style: TextStyles.bold16.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShippingInfoCard() {
    return Card(
      color: const Color.fromARGB(255, 243, 243, 243),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shipping Information',
              style: TextStyles.bold16.copyWith(color: AppColors.primaryColor),
            ),
            const SizedBox(height: 12),
            _buildInfoRow('Name', order.shippingInfo.name),
            _buildInfoRow('Address', order.shippingInfo.address),
            _buildInfoRow('City', order.shippingInfo.city),
            _buildInfoRow('Phone', order.shippingInfo.phone),
            _buildInfoRow('Email', order.shippingInfo.email),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentInfoCard() {
    return Card(
      color: const Color.fromARGB(255, 243, 243, 243),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Information',
              style: TextStyles.bold16.copyWith(color: AppColors.primaryColor),
            ),
            const SizedBox(height: 12),
            _buildInfoRow('Method', order.paymentInfo.method),
            if (order.paymentInfo.method == 'Credit Card') ...[
              _buildInfoRow('Card Number',
                  '•••• •••• •••• ${order.paymentInfo.cardLastFour}'),
              _buildInfoRow('Transaction ID', order.paymentInfo.transactionId),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style:
                  TextStyles.semiBold13.copyWith(color: Colors.grey.shade600),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyles.regular13,
            ),
          ),
        ],
      ),
    );
  }
}
