import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/search_text_field.dart';
import 'package:standard_searchbar/new/standard_search_anchor.dart';
import 'package:standard_searchbar/new/standard_search_bar.dart';
import 'package:standard_searchbar/new/standard_suggestion.dart';
import 'package:standard_searchbar/new/standard_suggestions.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          SizedBox(width: 5),
          Image.asset(
            'assets/logo/logo1.png',
            width: 50, // Width of the image in pixels
            height: 50, // Height of the image in pixels
            // fit: BoxFit.contain, // Make sure it fits nicely
          ),
          Text('PickPay', style: TextStyle(fontSize: 22)),
          SizedBox(width: 10),
          Container(
            width: 260,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: SearchTextField(),
          ),
        ],
      ),
    );
  }
}
