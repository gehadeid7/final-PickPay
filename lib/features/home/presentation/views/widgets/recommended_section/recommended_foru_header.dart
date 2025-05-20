import 'package:flutter/material.dart';

class RecommendedForuHeader extends StatelessWidget {
  const RecommendedForuHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft, // Explicitly left-align the text
            child: Text('Recommended For You',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                )),
          ),
          const SizedBox(height: 6),
          Container(
            height: 1,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(4),
              ),
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 32, 140, 229),
                  Colors.lightBlueAccent,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
