import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/homeCategory/presentation/views/home_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product8.dart';
import 'package:pickpay/features/home/presentation/views/card_item.dart';

class TodaysSaleGridView extends StatefulWidget {
  const TodaysSaleGridView({super.key});

  @override
  State<TodaysSaleGridView> createState() => _TodaysSaleGridViewState();
}

class _TodaysSaleGridViewState extends State<TodaysSaleGridView> {
  late Timer _timer;
  Duration _duration = const Duration(hours: 3); // Countdown from 3 hours

  @override
  void initState() {
    super.initState();
    _startTimer();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> saleProducts = [
      {
        'imagePath': 'assets/appliances/product8/1.png',
        'productName':
            'Black & Decker 1050W 2-Slice Stainless Steel Toaster, Silver/Black',
        'price': '2540.00',
        'rating': 4.8,
        'reviewCount': 200,
        'detailPage': const AppliancesProduct8(),
      },
      {
        'imagePath': 'assets/Home_products/furniture/furniture4/1.png',
        'productName':
            'Gaming Chair, Furgle Gocker Ergonomic Adjustable 3D Swivel Chair',
        'price': '9696.55',
        'rating': 4.6,
        'reviewCount': 150,
        'detailPage': const HomeCategoryView(),
      },
    ];

    return Container(
      height: 330,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: const Color.fromARGB(255, 241, 241, 241),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: Text(
                "Today’s Sale Ends In:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Center(
              child: Text(
                _formattedTime(_duration),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 180 / 230,
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
                    MaterialPageRoute(builder: (_) => product['detailPage']),
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
        ],
      ),
    );
  }
}
