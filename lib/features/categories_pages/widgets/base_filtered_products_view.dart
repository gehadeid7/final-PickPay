// import 'package:flutter/material.dart';
// import 'package:pickpay/core/widgets/build_appbar.dart';
// import 'package:pickpay/features/categories_pages/models/product_model.dart';
// import 'package:pickpay/features/categories_pages/widgets/brand_filter_widget.dart';
// import 'package:pickpay/features/categories_pages/widgets/product_card.dart';

// abstract class BaseFilteredProductsView extends StatefulWidget {
//   final String categoryTitle;

//   const BaseFilteredProductsView({
//     Key? key,
//     required this.categoryTitle,
//   }) : super(key: key);
// }

// abstract class BaseFilteredProductsViewState<T extends BaseFilteredProductsView>
//     extends State<T> {
//   List<String> _selectedBrands = [];
//   late List<ProductsViewsModel> _allProducts;
//   bool _isLoading = true;
//   String? _error;

//   @override
//   void initState() {
//     super.initState();
//     _loadProducts();
//   }

//   Future<void> _loadProducts() async {
//     try {
//       final products = await fetchProducts();
//       setState(() {
//         _allProducts = products;
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _error = e.toString();
//         _isLoading = false;
//       });
//     }
//   }

//   Future<List<ProductsViewsModel>> fetchProducts();
//   Widget getProductPage(ProductsViewsModel product);

//   List<ProductsViewsModel> get _filteredProducts {
//     if (_selectedBrands.isEmpty) return _allProducts;
//     return _allProducts.where((product) {
//       return product.brand != null && _selectedBrands.contains(product.brand);
//     }).toList();
//   }

//   List<String> get _availableBrands {
//     final brands = _allProducts
//         .map((p) => p.brand)
//         .where((brand) => brand != null)
//         .map((brand) => brand!)
//         .toSet()
//         .toList()
//       ..sort();
//     return brands;
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     if (_error != null) {
//       return Center(child: Text('Error: $_error'));
//     }

//     return Scaffold(
//       appBar: buildAppBar(context: context, title: widget.categoryTitle),
//       body: ListView(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         children: [
//           const SizedBox(height: 16),
//           if (_availableBrands.isNotEmpty)
//             BrandFilterWidget(
//               availableBrands: _availableBrands,
//               onBrandsSelected: (selectedBrands) {
//                 setState(() {
//                   _selectedBrands = selectedBrands;
//                 });
//               },
//               title: 'Filter ${widget.categoryTitle} by Brand',
//             ),
//           ..._filteredProducts.map((product) {
//             return Column(
//               children: [
//                 ProductCard(
//                   product: product,
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => getProductPage(product),
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 10),
//               ],
//             );
//           }).toList(),
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
// }
