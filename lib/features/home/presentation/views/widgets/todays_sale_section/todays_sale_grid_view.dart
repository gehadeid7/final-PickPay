import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product10.dart';
import 'package:pickpay/features/home/presentation/views/widgets/card_item.dart';

class TodaysSaleGridView extends StatefulWidget {
  const TodaysSaleGridView({super.key});

  @override
  State<TodaysSaleGridView> createState() => _TodaysSaleGridViewState();
}

class _TodaysSaleGridViewState extends State<TodaysSaleGridView>
    with SingleTickerProviderStateMixin {
  late Timer _timer;
  Duration _duration = const Duration(hours: 3);
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _startTimer();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_duration.inSeconds > 0) {
        setState(() {
          _duration -= const Duration(seconds: 1);
        });
      } else {
        _timer.cancel();
      }
    });
  }

  String _formattedTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final List<Map<String, dynamic>> saleProducts = [
      {
        'imagePath': 'assets/appliances/product8/1.png',
        'productName':
            'Black & Decker 1050W 2-Slice Stainless Steel Toaster, Silver/Black',
        'price': '2540.00',
        'rating': 3.1,
        'reviewCount': 9,
        'detailPage': const AppliancesProduct8(),
      },
      {
        'imagePath': 'assets/Home_products/home-decor/home_decor5/1.png',
        'productName':
            'oliruim Black Home Decor Accent Art Woman face Statue Collectible Statue for Modern Home Living Room Bookshelf Black Desk Decor 2 Pieces Set',
        'price': '400.00',
        'rating': 4.3,
        'reviewCount': 43,
        'detailPage': const HomeProduct10(),
      },
    ];

    return Container(
      height: 330,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDarkMode
              ? [
                  Colors.grey.shade800,
                  Colors.grey.shade900,
                ]
              : [
                  const Color.fromARGB(
                      255, 248, 250, 253), // very soft light blue
                  const Color.fromARGB(255, 228, 228, 228), // soft baby blue
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                // ignore: deprecated_member_use
                ? const Color.fromARGB(255, 38, 38, 38).withOpacity(0.6)
                // ignore: deprecated_member_use
                : const Color.fromARGB(255, 92, 92, 92).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Text(
                  "🔥 Today's Sale Ends In:",
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: isDarkMode
                        ? const Color(0xFFFFA726) // bright orange for dark mode
                        : const Color(0xFFFF6F00), // deep orange for light mode
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    shadows: [
                      Shadow(
                        color: isDarkMode
                            ? const Color(
                                0x99FFB74D) // transparent yellow-orange glow for dark mode
                            : const Color(0x99FFB74D), // same for light mode
                        blurRadius: 5,
                        offset: const Offset(0, 0),
                      ),
                      Shadow(
                        color: isDarkMode
                            ? const Color(
                                0x55FF8F00) // softer transparent orange glow
                            : const Color(0x55FF8F00),
                        blurRadius: 5,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Center(
              child: Text(
                _formattedTime(_duration),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white70 : Colors.black87,
                  letterSpacing: 1.3,
                  shadows: isDarkMode
                      ? [
                          Shadow(
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.7),
                            blurRadius: 6,
                            offset: const Offset(1, 1),
                          )
                        ]
                      : null,
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                mainAxisSpacing: 12,
                crossAxisSpacing: 16,
              ),
              itemCount: saleProducts.length,
              itemBuilder: (context, index) {
                final product = saleProducts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => product['detailPage'],
                      ),
                    );
                  },
                  child: CardItem(
                    imagePath: product['imagePath'],
                    productName: product['productName'],
                    price: product['price'],
                    rating: product['rating'],
                    reviewCount: product['reviewCount'],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
