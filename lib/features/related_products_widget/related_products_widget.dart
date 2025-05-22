// import 'package:flutter/material.dart';
// import 'package:pickpay/features/categories_pages/models/product_model.dart';
// import 'package:pickpay/features/categories_pages/widgets/product_card.dart';
// import 'package:pickpay/features/related_products_widget/services/product_service.dart';
// import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

// class RelatedProductsWidget extends StatelessWidget {
//   final ProductsViewsModel currentProduct;

//   const RelatedProductsWidget({
//     super.key,
//     required this.currentProduct,
//   });

//   String _getSubCategoryDisplayName(String subcategory) {
//     switch (subcategory.toLowerCase()) {
//       case 'mobile_and_tablet':
//         return 'Mobile & Tablets';
//       case 'tvs':
//         return 'TVs';
//       case 'laptop':
//         return 'Laptops';
//       case 'women_fashion':
//         return 'Women\'s Fashion';
//       case 'men_fashion':
//         return 'Men\'s Fashion';
//       case 'kids_fashion':
//         return 'Kids\' Fashion';
//       case 'makeup':
//         return 'Makeup';
//       case 'skincare':
//         return 'Skincare';
//       case 'haircare':
//         return 'Haircare';
//       case 'fragrance':
//         return 'Fragrance';
//       case 'furniture':
//         return 'Furniture';
//       case 'home_decor':
//         return 'Home Decor';
//       case 'kitchen':
//         return 'Kitchen';
//       case 'bath_and_bedding':
//         return 'Bath & Bedding';
//       case 'large_appliances':
//         return 'Large Appliances';
//       case 'small_appliances':
//         return 'Small Appliances';
//       case 'console':
//         return 'Consoles';
//       case 'controllers':
//         return 'Controllers';
//       case 'accessories':
//         return 'Accessories';
//       default:
//         return subcategory;
//     }
//   }

//   String _getCategoryDisplayName(String category) {
//     switch (category.toLowerCase()) {
//       case 'electronics':
//         return 'Electronics';
//       case 'fashion':
//         return 'Fashion';
//       case 'beauty':
//         return 'Beauty';
//       case 'home':
//         return 'Home';
//       case 'appliances':
//         return 'Appliances';
//       case 'video_games':
//         return 'Video Games';
//       default:
//         return category;
//     }
//   }

//   void _navigateToProduct(BuildContext context, ProductsViewsModel product) {
//     if (product != null) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ProductDetailView(product: product),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDarkMode = theme.brightness == Brightness.dark;
//     final productService = ProductService.instance;

//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               'You May Also Like',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: isDarkMode ? Colors.white : Colors.black,
//               ),
//             ),
//           ),
//           FutureBuilder<List<ProductsViewsModel>>(
//             future: productService.getRelatedProducts(currentProduct.id),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.3,
//                   child: Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircularProgressIndicator(
//                           valueColor: AlwaysStoppedAnimation<Color>(
//                             Theme.of(context).primaryColor,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           'Finding similar products...',
//                           style: TextStyle(
//                             color: isDarkMode
//                                 ? Colors.grey[400]
//                                 : Colors.grey[600],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }

//               if (snapshot.hasError) {
//                 return Container(
//                   height: MediaQuery.of(context).size.height * 0.3,
//                   padding: const EdgeInsets.all(16.0),
//                   margin: const EdgeInsets.symmetric(horizontal: 16.0),
//                   decoration: BoxDecoration(
//                     color: isDarkMode ? Colors.grey[850] : Colors.grey[100],
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.error_outline,
//                         color: Theme.of(context).colorScheme.error,
//                         size: 32,
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         'Error loading recommendations',
//                         style: TextStyle(
//                           color: Theme.of(context).colorScheme.error,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         'Please try again later',
//                         style: TextStyle(
//                           color:
//                               isDarkMode ? Colors.grey[400] : Colors.grey[600],
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }

//               if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                 return Container(
//                   height: MediaQuery.of(context).size.height * 0.3,
//                   padding: const EdgeInsets.all(16.0),
//                   margin: const EdgeInsets.symmetric(horizontal: 16.0),
//                   decoration: BoxDecoration(
//                     color: isDarkMode ? Colors.grey[850] : Colors.grey[100],
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.info_outline,
//                         color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
//                         size: 32,
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         'No similar products found',
//                         style: TextStyle(
//                           color:
//                               isDarkMode ? Colors.grey[400] : Colors.grey[600],
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         'Check back later for more options',
//                         style: TextStyle(
//                           color:
//                               isDarkMode ? Colors.grey[500] : Colors.grey[700],
//                           fontSize: 14,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 );
//               }

//               final relatedProducts = snapshot.data!;
//               final currentCategory =
//                   productService.getCategoryFromId(currentProduct.id);

//               // Group products by category
//               final Map<String, List<ProductsViewsModel>> productsByCategory =
//                   {};
//               for (final product in relatedProducts) {
//                 final category = productService.getCategoryFromId(product.id);
//                 if (category == currentCategory) {
//                   productsByCategory
//                       .putIfAbsent(category, () => [])
//                       .add(product);
//                 }
//               }

//               if (productsByCategory.isEmpty) {
//                 return Container(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Center(
//                     child: Text(
//                       'No related products found in this category',
//                       style: TextStyle(
//                         color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
//                       ),
//                     ),
//                   ),
//                 );
//               }

//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   _buildProductSection(
//                     context,
//                     'More from ${_getCategoryDisplayName(currentCategory)}',
//                     productsByCategory[currentCategory] ?? [],
//                     isDarkMode,
//                   ),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProductSection(
//     BuildContext context,
//     String title,
//     List<ProductsViewsModel> products,
//     bool isDarkMode,
//   ) {
//     if (products.isEmpty) return const SizedBox.shrink();

//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
//             child: Text(
//               title,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 260, // Reduced height to prevent overflow
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               itemCount: products.length,
//               itemBuilder: (context, index) {
//                 final product = products[index];
//                 return Container(
//                   width: 180,
//                   margin: const EdgeInsets.only(right: 12),
//                   child: ProductCard(
//                     id: product.id,
//                     name: product.title,
//                     imagePaths: product.imagePaths ?? [],
//                     price: product.price,
//                     originalPrice: product.originalPrice ?? 0,
//                     rating: product.rating ?? 0,
//                     reviewCount: product.reviewCount ?? 0,
//                     onTap: () => _navigateToProduct(context, product),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
