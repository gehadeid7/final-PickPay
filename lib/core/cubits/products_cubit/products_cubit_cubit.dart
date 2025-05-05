// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:pickpay/core/entities/product_entity.dart';
// import 'package:pickpay/core/repos/product_repo/products_repo.dart';

// part 'products_cubit_state.dart';

// class ProductsCubit extends Cubit<ProductsState> {
//   ProductsCubit(this.productsRepo) : super(ProductsInitial());

//   final ProductsRepo productsRepo;

//   Future<void> getProducts() async {
//     emit(ProductsLoading());
//     final result = await productsRepo.getProducts();
//     result.fold(
//       (failure) => emit(ProductsFailure(failure.message)),
//       (products) => emit(ProductsSuccess(products)),
//     );
//   }

//   Future<void> getBsetSellingProducts() async {
//     emit(ProductsLoading());
//     final result = await productsRepo.getBestSellingProducts();
//     result.fold(
//       (failure) => emit(ProductsFailure(failure.message)),
//       (products) => emit(ProductsSuccess(products)),
//     );
//   }
// }
