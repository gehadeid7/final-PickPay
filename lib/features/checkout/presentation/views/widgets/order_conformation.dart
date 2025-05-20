import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/checkout/domain/models/checkout_model.dart';

class OrderConfirmationView extends StatelessWidget {
  final OrderModel order;

  const OrderConfirmationView({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Order Confirmation'),
      // ignore: deprecated_member_use
      backgroundColor: colorScheme.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 80,
            ),
            const SizedBox(height: 16),
            Text(
              'Thank you for your order!',
              style: TextStyles.bold19.copyWith(color: colorScheme.primary),
            ),
            const SizedBox(height: 8),
            Text(
              'Your order has been placed successfully',
              style:
                  TextStyles.regular16.copyWith(color: colorScheme.onSurface),
            ),
            const SizedBox(height: 24),
            _buildOrderInfoCard(context),
            const SizedBox(height: 24),
            _buildShippingInfoCard(context),
            const SizedBox(height: 24),
            _buildPaymentInfoCard(context),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed('/main-navigation');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Continue Shopping',
                  style: TextStyles.semiBold13.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderInfoCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      color: colorScheme.surface,
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
              style: TextStyles.bold16.copyWith(color: colorScheme.primary),
            ),
            const SizedBox(height: 12),
            _buildInfoRow('Order Number', order.id, context),
            _buildInfoRow(
                'Order Date',
                '${order.date.day}/${order.date.month}/${order.date.year}',
                context),
            _buildInfoRow('Status', order.status, context),
            const SizedBox(height: 12),
            // ignore: deprecated_member_use
            Divider(color: colorScheme.outline.withOpacity(0.5)),
            const SizedBox(height: 12),
            Text(
              'Items (${order.items.length})',
              style:
                  TextStyles.semiBold13.copyWith(color: colorScheme.onSurface),
            ),
            const SizedBox(height: 8),
            ...order.items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${item.product.title} x ${item.quantity}',
                          style: TextStyles.regular13
                              .copyWith(color: colorScheme.onSurface),
                        ),
                      ),
                      Text(
                        'EGP ${(item.product.price * item.quantity).toStringAsFixed(2)}',
                        style: TextStyles.semiBold13
                            .copyWith(color: colorScheme.onSurface),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 12),
            // ignore: deprecated_member_use
            Divider(color: colorScheme.outline.withOpacity(0.5)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Total',
                    style: TextStyles.bold16
                        .copyWith(color: colorScheme.onSurface),
                  ),
                ),
                Text(
                  'EGP ${order.total.toStringAsFixed(2)}',
                  style: TextStyles.bold16.copyWith(color: colorScheme.primary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShippingInfoCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      color: colorScheme.surface,
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
              style: TextStyles.bold16.copyWith(color: colorScheme.primary),
            ),
            const SizedBox(height: 12),
            _buildInfoRow('Name', order.shippingInfo.name, context),
            _buildInfoRow('Address', order.shippingInfo.address, context),
            _buildInfoRow('City', order.shippingInfo.city, context),
            _buildInfoRow('Phone', order.shippingInfo.phone, context),
            _buildInfoRow('Email', order.shippingInfo.email, context),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentInfoCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      color: colorScheme.surface,
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
              style: TextStyles.bold16.copyWith(color: colorScheme.primary),
            ),
            const SizedBox(height: 12),
            _buildInfoRow('Method', order.paymentInfo.method, context),
            if (order.paymentInfo.method == 'Credit Card') ...[
              _buildInfoRow('Card Number',
                  '•••• •••• •••• ${order.paymentInfo.cardLastFour}', context),
              _buildInfoRow(
                  'Transaction ID', order.paymentInfo.transactionId, context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyles.semiBold13
                  // ignore: deprecated_member_use
                  .copyWith(color: colorScheme.onSurface.withOpacity(0.7)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style:
                  TextStyles.regular13.copyWith(color: colorScheme.onSurface),
            ),
          ),
        ],
      ),
    );
  }
}
