// import 'package:flutter/material.dart';

// class LanguageView extends StatefulWidget {
//   const LanguageView({super.key});

//   @override
//   State<LanguageView> createState() => _LanguageViewState();
// }

// class _LanguageViewState extends State<LanguageView> {
//   String _selectedLanguage = 'English';

//   final List<Map<String, String>> _languages = [
//     {'code': 'en', 'name': 'English', 'native': 'English'},
//     {'code': 'es', 'name': 'Spanish', 'native': 'Español'},
//     {'code': 'fr', 'name': 'French', 'native': 'Français'},
//     {'code': 'de', 'name': 'German', 'native': 'Deutsch'},
//     {'code': 'it', 'name': 'Italian', 'native': 'Italiano'},
//     {'code': 'pt', 'name': 'Portuguese', 'native': 'Português'},
//     {'code': 'ru', 'name': 'Russian', 'native': 'Русский'},
//     {'code': 'zh', 'name': 'Chinese', 'native': '中文'},
//     {'code': 'ja', 'name': 'Japanese', 'native': '日本語'},
//     {'code': 'ar', 'name': 'Arabic', 'native': 'العربية'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDarkMode = theme.brightness == Brightness.dark;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Language'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: TextField(
//               decoration: InputDecoration(
//                 prefixIcon: const Icon(Icons.search),
//                 hintText: 'Search language',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 filled: true,
//                 fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[100],
//               ),
//               onChanged: (value) {
//                 // Implement search functionality
//               },
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _languages.length,
//               itemBuilder: (context, index) {
//                 final language = _languages[index];
//                 return RadioListTile<String>(
//                   title: Row(
//                     children: [
//                       Text(
//                         language['name']!,
//                         style: const TextStyle(fontWeight: FontWeight.w500),
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         language['native']!,
//                         style: TextStyle(
//                           color:
//                               isDarkMode ? Colors.grey[400] : Colors.grey[600],
//                         ),
//                       ),
//                     ],
//                   ),
//                   value: language['name']!,
//                   groupValue: _selectedLanguage,
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedLanguage = value!;
//                     });
//                     // Here you would typically save the language preference
//                   },
//                   secondary: Text(
//                     language['code']!.toUpperCase(),
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                       color: Theme.of(context).primaryColor,
//                     ),
//                   ),
//                   activeColor: Theme.of(context).primaryColor,
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Save language preference and maybe restart app
//                   Navigator.pop(context);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Text('Apply Language'),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
