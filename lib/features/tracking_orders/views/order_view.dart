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
                      tabs: [
                        Tab(
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const Text('Pending'),
                          ),
                        ),
                        Tab(
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const Text('Delivered'),
                          ),
                        ),
                      ],
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: theme.primaryColor,
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.white,
                      unselectedLabelColor:
                          isDarkMode ? Colors.white70 : Colors.grey[600],
                      padding: const EdgeInsets.all(4),
                    ),
                  ),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: TabBarView(
                        key: ValueKey(state.orders.length.toString() + state.orders.hashCode.toString()),
                        children: [
                          _OrderList(
                              orders: state.pendingOrders, isPending: true),
                          _OrderList(
                              orders: state.deliveredOrders, isPending: false),
                        ],
                      ),
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
            Icons.inbox_rounded,
            size: 80,
            color: isDarkMode ? Colors.white24 : Colors.grey[300],
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
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: FadeTransition(opacity: animation, child: child),
          ),
          child: _buildOrderCard(context, order, key: ValueKey(order.id)),
        );
      },
    );
  }

  Widget _buildOrderCard(BuildContext context, OrderModel order, {Key? key}) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final orderCubit = context.read<OrderCubit>();
    bool isLoading = false;

    return StatefulBuilder(
      builder: (context, setState) => GestureDetector(
        key: key,
        onTapDown: (_) {
          // Optional: Add a subtle scale animation or ripple effect
        },
        child: Card(
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
                  children: [
                    Expanded(
                      child: Text(
                        'Order #${order.id}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildStatusChip(context, order.status),
                  ],
                ),
                const Divider(height: 24),
                _buildInfoRow('Amount', 'EGP ${order.totalAmount.toStringAsFixed(2)}'),
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
                      onPressed: isLoading
                          ? null
                          : () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Confirm Delivery'),
                                  content: const Text('Are you sure you want to mark this order as delivered?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(false),
                                      child: const Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => Navigator.of(context).pop(true),
                                      child: const Text('Yes, Mark as Delivered'),
                                    ),
                                  ],
                                ),
                              );
                              if (confirm == true) {
                                setState(() => isLoading = true);
                                try {
                                  await orderCubit.updateOrderStatus(order.id, OrderStatus.delivered);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: [
                                          Icon(
                                            Icons.check_circle,
                                            color: Colors.white,
                                            size: 28,
                                          ),
                                          const SizedBox(width: 12),
                                          const Text('Order marked as delivered!'),
                                        ],
                                      ),
                                      duration: const Duration(seconds: 2),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: theme.primaryColor,
                                    ),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: [
                                          Icon(Icons.error, color: Colors.white, size: 28),
                                          const SizedBox(width: 12),
                                          Text('Failed: ${e.toString()}'),
                                        ],
                                      ),
                                      duration: const Duration(seconds: 2),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: theme.colorScheme.error,
                                    ),
                                  );
                                } finally {
                                  setState(() => isLoading = false);
                                }
                              }
                            },
                      icon: isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : const Icon(Icons.check_circle_outline),
                      label: Text(isLoading ? 'Processing...' : 'Mark as Delivered'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
                if (!isPending) ...[
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Order Details'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Order ID: ${order.id}'),
                                Text('Amount: EGP ${order.totalAmount.toStringAsFixed(2)}'),
                                Text('Created: ${_formatDate(order.createdAt)}'),
                                if (order.deliveredAt != null)
                                  Text('Delivered: ${_formatDate(order.deliveredAt!)}'),
                                // Add more details as needed
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text('View Details'),
                    ),
                  ),
                ],
              ],
            ),
          ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            flex: 3,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
