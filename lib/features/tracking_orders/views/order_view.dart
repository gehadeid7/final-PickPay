import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/order_model.dart';
import '../cubit/order_cubit.dart';
import '../cubit/order_state.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/core/utils/app_colors.dart';

class OrderView extends StatelessWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return BlocProvider.value(
      value: context.read<OrderCubit>(),
      child: Scaffold(
        appBar: buildAppBar(context: context, title: 'Track Orders'),
        backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.grey[50],
        body: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.error != null) {
              return Center(child: Text(state.error!));
            }

            if (state.orders.isEmpty) {
              return _buildEmptyState(context);
            }

            return DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey[800] : Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TabBar(
                      tabs: const [
                        Tab(text: 'Pending'),
                        Tab(text: 'Delivered'),
                      ],
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: theme.primaryColor,
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor:
                          isDarkMode ? Colors.white70 : Colors.grey[600],
                      padding: const EdgeInsets.all(4),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _OrderList(
                            orders: state.pendingOrders, isPending: true),
                        _OrderList(
                            orders: state.deliveredOrders, isPending: false),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.local_shipping_outlined,
            size: 64,
            color: isDarkMode ? Colors.white54 : Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No orders yet',
            style: theme.textTheme.titleLarge?.copyWith(
              color: isDarkMode ? Colors.white70 : Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your order tracking history will appear here',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDarkMode ? Colors.white54 : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderList extends StatelessWidget {
  final List<OrderModel> orders;
  final bool isPending;

  const _OrderList({
    Key? key,
    required this.orders,
    required this.isPending,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Center(
        child: Text(
          isPending ? 'No pending orders' : 'No delivered orders',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white54
                    : Colors.grey[600],
              ),
        ),
      );
    }

    return ListView.builder(
      itemCount: orders.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final order = orders[index];
        return _buildOrderCard(context, order);
      },
    );
  }

  Widget _buildOrderCard(BuildContext context, OrderModel order) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: isDarkMode ? Colors.grey[800] : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order.id}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
                _buildStatusChip(context, order.status),
              ],
            ),
            const Divider(height: 24),
            _buildInfoRow('Amount', '\$${order.totalAmount.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            _buildInfoRow('Created', _formatDate(order.createdAt)),
            if (order.deliveredAt != null) ...[
              const SizedBox(height: 8),
              _buildInfoRow('Delivered', _formatDate(order.deliveredAt!)),
            ],
            if (isPending) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    context
                        .read<OrderCubit>()
                        .updateOrderStatus(order.id, OrderStatus.delivered);
                  },
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Mark as Delivered'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context, OrderStatus status) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = status == OrderStatus.pending
        ? (isDarkMode ? Colors.orange[900] : Colors.orange[100])
        : (isDarkMode ? Colors.green[900] : Colors.green[100]);
    final textColor = status == OrderStatus.pending
        ? (isDarkMode ? Colors.orange[100] : Colors.orange[900])
        : (isDarkMode ? Colors.green[100] : Colors.green[900]);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status == OrderStatus.pending ? 'Pending' : 'Delivered',
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
