// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pickpay/core/cubits/products_cubit/products_cubit_cubit.dart';
// import 'package:pickpay/core/helper_functions/get_dummy_product.dart';
// import 'package:pickpay/features/home/presentation/views/widgets/electronics_section/electronics_grid_view.dart';
// import 'package:skeletonizer/skeletonizer.dart';

// class BestSellingGridViewBlocBuilder extends StatelessWidget {
//   const BestSellingGridViewBlocBuilder({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProductsCubit, ProductsState>(
//       builder: (context, state) {
//         return Skeletonizer.sliver(
//             enabled: true,
//             child: ElectronicsGridView(
//               products: getDummyProducts(),
//             ));
//         // if (state is ProductsSuccess) {
//         //   return ElectronicsGridView(
//         //     products: state.products,
//         //   );
//         // } else if (state is ProductsFailure) {
//         //   return SliverToBoxAdapter(
//         //       child: CustomErrorWidget(text: state.errMessage));
//         // } else {
//         //   return Skeletonizer.sliver(
//         //       enabled: true,
//         //       child: ElectronicsGridView(
//         //         products: getDummyProducts(),
//         //       ));
//         // }
//       },
//     );
//   }
// }

// //tharwat
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:pickpay/core/cubits/products_cubit/products_cubit_cubit.dart';
// // import 'package:pickpay/core/helper_functions/get_dummy_product.dart';
// // import 'package:pickpay/core/widgets/custom_error_widget.dart';
// // import 'package:pickpay/features/home/presentation/views/widgets/electronics_section/electronics_grid_view.dart';
// // import 'package:skeletonizer/skeletonizer.dart';
// // import 'package:pickpay/core/services/supabase_storage_service.dart';  // Add this import

// // class BestSellingGridViewBlocBuilder extends StatelessWidget {
// //   const BestSellingGridViewBlocBuilder({
// //     super.key,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocBuilder<ProductsCubit, ProductsState>(
// //       builder: (context, state) {
// //         if (state is ProductsSuccess) {
// //           final storageService = SupabaseStorageService(); // Create an instance of the storage service

// //           return ElectronicsGridView(
// //             products: state.products.map((product) {
// //               final publicUrl = storageService.getPublicUrl(product.image.path); // Get public URL from Supabase
// //               return product.copyWith(imageUrl: publicUrl); // Set the image URL in the product
// //             }).toList(),
// //           );
// //         } else if (state is ProductsFailure) {
// //           return SliverToBoxAdapter(
// //               child: CustomErrorWidget(text: state.errMessage));
// //         } else {
// //           return Skeletonizer.sliver(
// //               enabled: true,
// //               child: ElectronicsGridView(
// //                 products: getDummyProducts(),
// //               ));
// //         }
// //       },
// //     );
// //   }
// // }
