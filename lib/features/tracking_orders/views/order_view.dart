import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/order_model.dart';
import '../cubit/order_cubit.dart';
import '../cubit/order_state.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/gestures.dart';

class OrderView extends StatelessWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    // Tab persistence using PageStorage
    final tabControllerKey = PageStorageKey('orderTabController');
    return BlocProvider.value(
      value: context.read<OrderCubit>(),
      child: Scaffold(
        appBar: buildAppBar(context: context, title: 'Track Orders'),
        backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.grey[50],
        body: RefreshIndicator(
          onRefresh: () async {
            await context.read<OrderCubit>().loadOrders();
            _showPullToRefreshFeedback(context);
          },
          child: BlocBuilder<OrderCubit, OrderState>(
            builder: (context, state) {
              if (state.isLoading) {
                return ListView(
                  children: List.generate(3, (i) => Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  )),
                );
              }
              if (state.error != null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, color: Colors.red, size: 48),
                      const SizedBox(height: 12),
                      Text(state.error!, style: theme.textTheme.titleMedium),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: () => context.read<OrderCubit>().loadOrders(),
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }
              if (state.orders.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox_rounded, size: 180, color: isDarkMode ? Colors.white70 : Colors.grey[700]),
                      const SizedBox(height: 16),
                      Text(
                        'No orders yet',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: isDarkMode ? Colors.white70 : Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your order tracking history will appear here.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isDarkMode ? Colors.white54 : Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Navigate to home or shop page
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                        icon: const Icon(Icons.storefront),
                        label: const Text('Start Shopping'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ],
                  ),
                );
              }
              // Sort orders by most recent first
              final sortedPending = List<OrderModel>.from(state.pendingOrders)
                ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
              final sortedDelivered = List<OrderModel>.from(state.deliveredOrders)
                ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
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
                        key: tabControllerKey,
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
                    // Optional: Add search/filter bar here
                    // _OrderSearchBar(onSearch: ...),
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: TabBarView(
                          key: ValueKey(state.orders.length.toString() + state.orders.hashCode.toString()),
                          children: [
                            _OrderList(
                                orders: sortedPending, isPending: true),
                            _OrderList(
                                orders: sortedDelivered, isPending: false),
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
      ),
    );
  }
  // Pull-to-refresh feedback
  static void _showPullToRefreshFeedback(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Orders refreshed!'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
    HapticFeedback.lightImpact();
  }
}

class _OrderList extends StatelessWidget {
  final List<OrderModel> orders;
  final bool isPending;
  const _OrderList({Key? key, required this.orders, required this.isPending}) : super(key: key);
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
        return _OrderCard(order: order, isPending: isPending, key: ValueKey(order.id));
      },
    );
  }
  static Widget buildStatusChip(BuildContext context, OrderStatus status) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color backgroundColor;
    Color textColor;
    String label;
    switch (status) {
      case OrderStatus.pending:
        backgroundColor = isDarkMode ? Colors.orange[900]! : const Color(0xFFFFF3E0); // soft orange
        textColor = isDarkMode ? Colors.orange[100]! : const Color(0xFFEF6C00); // deep orange
        label = 'Pending';
        break;
      case OrderStatus.paid:
        backgroundColor = isDarkMode ? Colors.blue[900]! : const Color(0xFFE3F2FD); // soft blue
        textColor = isDarkMode ? Colors.blue[100]! : const Color(0xFF1976D2); // deep blue
        label = 'Paid';
        break;
      case OrderStatus.delivered:
        backgroundColor = isDarkMode ? Colors.green[900]! : const Color(0xFFE8F5E9); // soft green
        textColor = isDarkMode ? Colors.green[100]! : const Color(0xFF388E3C); // deep green
        label = 'Delivered';
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: isDarkMode ? null : Border.all(color: Colors.grey[200]!),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
  static Widget buildInfoRow(String label, String value) {
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
  static String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

// Order Card with tap/press animation, progress bar, carousel, accessibility
class _OrderCard extends StatefulWidget {
  final OrderModel order;
  final bool isPending;
  const _OrderCard({Key? key, required this.order, required this.isPending}) : super(key: key);
  @override
  State<_OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<_OrderCard> with SingleTickerProviderStateMixin {
  bool isLoading = false;
  double _scale = 1.0;
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
      lowerBound: 0.97,
      upperBound: 1.0,
      value: 1.0,
    );
    _controller.addListener(() {
      setState(() {
        _scale = _controller.value;
      });
    });
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  void _onTapDown(TapDownDetails details) {
    _controller.reverse();
    HapticFeedback.selectionClick();
  }
  void _onTapUp(TapUpDetails details) {
    _controller.forward();
  }
  void _onTapCancel() {
    _controller.forward();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final order = widget.order;
    final orderCubit = context.read<OrderCubit>();
    // Product carousel
    final productImages = <String>[]; // No longer used, but keep for compatibility
    final productName = order.cartItems.isNotEmpty
        ? getProductDisplayName(order.cartItems.first['product'])
        : '';
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[900]
              : Theme.of(context).scaffoldBackgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          builder: (context) => _OrderDetailsSheet(order: order),
        );
      },
      child: Transform.scale(
        scale: _scale,
        child: Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[800] : Colors.white,
          shadowColor: Theme.of(context).brightness == Brightness.dark ? Colors.black54 : Colors.grey.withOpacity(0.15),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (productImages.isNotEmpty)
                      buildProductCarousel(productImages)
                    else
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.image, color: Colors.grey[400]),
                      ),
                    const SizedBox(width: 12),
                    Expanded(
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
                                    color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black87,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.copy, size: 18),
                                tooltip: 'Copy Order ID',
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(text: order.id));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Order ID copied!'),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                  HapticFeedback.lightImpact();
                                },
                              ),
                              _OrderList.buildStatusChip(context, order.status),
                            ],
                          ),
                          if (productName.isNotEmpty)
                            Text(
                              productName,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.grey[700],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                buildOrderStepper(order.status, isDark: Theme.of(context).brightness == Brightness.dark),
                const Divider(height: 24),
                _OrderList.buildInfoRow('Amount', 'EGP ${order.totalAmount.toStringAsFixed(2)}'),
                const SizedBox(height: 8),
                _OrderList.buildInfoRow('Created', _OrderList.formatDate(order.createdAt)),
                if (order.deliveredAt != null) ...[
                  const SizedBox(height: 8),
                  _OrderList.buildInfoRow('Delivered', _OrderList.formatDate(order.deliveredAt!)),
                ],
                if (order.cartItems.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Products:',
                    style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  ...order.cartItems.take(2).map((item) => Text(
                    '- ${getProductDisplayName(item['product'])} x${item['quantity'] ?? 1}',
                    style: theme.textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
                  if (order.cartItems.length > 2)
                    Text('+${order.cartItems.length - 2} more', style: theme.textTheme.bodySmall),
                ],
                if (widget.isPending) ...[
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
                                  HapticFeedback.mediumImpact();
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
                                  HapticFeedback.heavyImpact();
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
                if (!widget.isPending) ...[
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey[900]
                              : Theme.of(context).scaffoldBackgroundColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                          ),
                          builder: (context) => _OrderDetailsSheet(order: order),
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
}

// --- ADVANCED UI/LOGIC HELPERS ---

/// Order progress stepper (Pending → Paid → Delivered)
Widget buildOrderStepper(OrderStatus status, {bool isDark = false}) {
  final steps = ['Pending', 'Paid', 'Delivered'];
  int current = status == OrderStatus.delivered ? 2 : status == OrderStatus.paid ? 1 : 0;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: List.generate(steps.length, (i) {
      final active = i <= current;
      return Expanded(
        child: Column(
          children: [
            CircleAvatar(
              radius: 14,
              backgroundColor: active
                  ? (isDark ? Colors.green[400] : const Color(0xFF43A047))
                  : (isDark ? Colors.grey[700] : Colors.grey[200]),
              child: Icon(
                i == 0 ? Icons.hourglass_empty : i == 1 ? Icons.payment : Icons.check,
                color: active ? Colors.white : (isDark ? Colors.grey[400] : Colors.grey[500]),
                size: 18,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              steps[i],
              style: TextStyle(
                fontSize: 12,
                color: active
                    ? (isDark ? Colors.green[200] : const Color(0xFF388E3C))
                    : (isDark ? Colors.grey[400] : Colors.grey[500]),
                fontWeight: active ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (i < steps.length - 1)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                height: 2,
                width: 32,
                color: active && i < current
                    ? (isDark ? Colors.green[400] : const Color(0xFF43A047))
                    : (isDark ? Colors.grey[700] : Colors.grey[200]),
              ),
          ],
        ),
      );
    }),
  );
}

/// Carousel for product thumbnails (shows up to 5, with +N more if needed)
Widget buildProductCarousel(List<String> images) {
  return Row(
    children: [
      ...images.take(5).map((img) => Padding(
            padding: const EdgeInsets.only(right: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(img, width: 32, height: 32, fit: BoxFit.cover),
            ),
          )),
      if (images.length > 5)
        Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text('+${images.length - 5}', style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
    ],
  );
}

/// Card tap/press animation wrapper
Widget animatedCard({required Widget child, required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: AnimatedScale(
      scale: 1.0,
      duration: const Duration(milliseconds: 100),
      child: child,
    ),
  );
}

/// Responsive layout helper: returns true if wide (tablet/landscape)
bool isWide(BuildContext context) {
  return MediaQuery.of(context).size.width > 600;
}

/// Copy address to clipboard with feedback
void copyAddress(BuildContext context, String address) {
  Clipboard.setData(ClipboardData(text: address));
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Address copied!'), duration: Duration(seconds: 1)),
  );
  HapticFeedback.lightImpact();
}

/// Order status timeline (vertical)
Widget buildOrderTimeline(OrderStatus status, DateTime created, {DateTime? paid, DateTime? delivered}) {
  final steps = [
    {'label': 'Order Placed', 'date': created, 'icon': Icons.shopping_cart},
    if (status == OrderStatus.paid || status == OrderStatus.delivered)
      {'label': 'Paid', 'date': paid, 'icon': Icons.payment},
    if (status == OrderStatus.delivered)
      {'label': 'Delivered', 'date': delivered, 'icon': Icons.local_shipping},
  ];
  return Column(
    children: steps.map((step) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(step['icon'] as IconData, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(step['label'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
              if (step['date'] != null)
                Text(_OrderList.formatDate(step['date'] as DateTime), style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      );
    }).toList(),
  );
}

/// Payment status chip
Widget buildPaymentChip(BuildContext context, OrderStatus status) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  Color bg;
  Color fg;
  String label;
  if (status == OrderStatus.paid) {
    bg = isDark ? Colors.blue[900]! : Colors.blue[100]!;
    fg = isDark ? Colors.blue[100]! : Colors.blue[900]!;
    label = 'Paid';
  } else if (status == OrderStatus.delivered) {
    bg = isDark ? Colors.green[900]! : Colors.green[100]!;
    fg = isDark ? Colors.green[100]! : Colors.green[900]!;
    label = 'Delivered';
  } else {
    bg = isDark ? Colors.orange[900]! : Colors.orange[100]!;
    fg = isDark ? Colors.orange[100]! : Colors.orange[900]!;
    label = 'Pending';
  }
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Text(label, style: TextStyle(color: fg, fontWeight: FontWeight.w600)),
  );
}

/// Haptic feedback on tap
void hapticTap() {
  HapticFeedback.selectionClick();
}

/// Tab persistence using PageStorage
TabController? getPersistentTabController(BuildContext context, {int length = 2, String storageKey = 'orderTab'}) {
  final storage = PageStorage.of(context);
  int initialIndex = storage.readState(context, identifier: storageKey) as int? ?? 0;
  final controller = TabController(length: length, vsync: Scaffold.of(context), initialIndex: initialIndex);
  controller.addListener(() {
    storage.writeState(context, controller.index, identifier: storageKey);
  });
  return controller;
}

/// Search/filter bar for orders
Widget buildOrderSearchBar({required TextEditingController controller, required ValueChanged<String> onChanged}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: 'Search orders... (ID, product, address)',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        filled: true,
        fillColor: Colors.grey[100],
      ),
    ),
  );
}

// Order details sheet
class _OrderDetailsSheet extends StatelessWidget {
  final OrderModel order;
  const _OrderDetailsSheet({required this.order});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (context, scrollController) => SingleChildScrollView(
        controller: scrollController,
        child: Container(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[900]
              : Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Order #${order.id}',
                        style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _OrderList.buildStatusChip(context, order.status),
                  ],
                ),
                const SizedBox(height: 12),
                // _OrderProgressBar(status: order.status),
                const SizedBox(height: 12),
                _OrderList.buildInfoRow('Amount', 'EGP ${order.totalAmount.toStringAsFixed(2)}'),
                _OrderList.buildInfoRow('Created', _OrderList.formatDate(order.createdAt)),
                if (order.deliveredAt != null)
                  _OrderList.buildInfoRow('Delivered', _OrderList.formatDate(order.deliveredAt!)),
                const Divider(height: 32),
                Text('Products:', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ...order.cartItems.map((item) {
                  // Remove all backend image logic, use a local asset or icon
                  return ListTile(
                    leading: Icon(Icons.image, color: Colors.grey[400]),
                    title: Text(getProductDisplayName(item['product']), maxLines: 1, overflow: TextOverflow.ellipsis),
                    subtitle: Text('x${item['quantity'] ?? 1}'),
                  );
                }).toList(),
                const SizedBox(height: 16),
                if (order.shippingAddress.isNotEmpty)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _OrderList.buildInfoRow('Delivery Address', _formatAddress(order.shippingAddress))),
                      IconButton(
                        icon: const Icon(Icons.copy, size: 18),
                        tooltip: 'Copy Address',
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: _formatAddress(order.shippingAddress)));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Address copied!'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                          HapticFeedback.lightImpact();
                        },
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                _OrderStatusTimeline(order: order),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  String _formatAddress(Map<String, dynamic> address) {
    final parts = [
      address['street'],
      address['city'],
      address['state'],
      address['country'],
      address['postalCode'],
    ];
    return parts.where((e) => e != null && e.toString().isNotEmpty).join(', ');
  }
}

// Order status timeline widget
class _OrderStatusTimeline extends StatelessWidget {
  final OrderModel order;
  const _OrderStatusTimeline({required this.order});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<_TimelineEvent> events = [
      _TimelineEvent('Order Placed', order.createdAt, Icons.shopping_cart),
      if (order.status == OrderStatus.paid || order.status == OrderStatus.delivered)
        _TimelineEvent('Paid', order.paidAt ?? order.createdAt, Icons.payment),
      if (order.status == OrderStatus.delivered)
        _TimelineEvent('Delivered', order.deliveredAt ?? DateTime.now(), Icons.check_circle),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Order Timeline', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...events.map((e) => Row(
              children: [
                Icon(e.icon, size: 18, color: theme.primaryColor),
                const SizedBox(width: 8),
                Text(e.label, style: theme.textTheme.bodyMedium),
                const SizedBox(width: 8),
                Text(_OrderList.formatDate(e.time), style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
              ],
            )),
      ],
    );
  }
}
class _TimelineEvent {
  final String label;
  final DateTime time;
  final IconData icon;
  _TimelineEvent(this.label, this.time, this.icon);
}

String getProductDisplayName(dynamic product) {
  if (product is Map) {
    return product['title']?.toString() ?? product['name']?.toString() ?? product['id']?.toString() ?? '';
  } else if (product is String) {
    return product;
  }
  return '';
}
