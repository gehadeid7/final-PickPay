// import 'package:flutter/material.dart';

// class BrandFilterWidget extends StatefulWidget {
//   final List<String> availableBrands;
//   final ValueChanged<List<String>> onBrandsSelected;
//   final String title;

//   const BrandFilterWidget({
//     Key? key,
//     required this.availableBrands,
//     required this.onBrandsSelected,
//     this.title = 'Filter by Brand',
//   }) : super(key: key);

//   @override
//   _BrandFilterWidgetState createState() => _BrandFilterWidgetState();
// }

// class _BrandFilterWidgetState extends State<BrandFilterWidget> {
//   final List<String> _selectedBrands = [];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 widget.title,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               if (_selectedBrands.isNotEmpty)
//                 TextButton(
//                   onPressed: () {
//                     setState(() {
//                       _selectedBrands.clear();
//                       widget.onBrandsSelected(_selectedBrands);
//                     });
//                   },
//                   child: const Text('Clear'),
//                 ),
//             ],
//           ),
//         ),
//         Wrap(
//           spacing: 8.0,
//           children: widget.availableBrands.map((brand) {
//             final isSelected = _selectedBrands.contains(brand);
//             return FilterChip(
//               label: Text(brand),
//               selected: isSelected,
//               onSelected: (selected) {
//                 setState(() {
//                   if (selected) {
//                     _selectedBrands.add(brand);
//                   } else {
//                     _selectedBrands.remove(brand);
//                   }
//                   widget.onBrandsSelected(_selectedBrands);
//                 });
//               },
//               selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
//               checkmarkColor: Theme.of(context).primaryColor,
//             );
//           }).toList(),
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }
// }
