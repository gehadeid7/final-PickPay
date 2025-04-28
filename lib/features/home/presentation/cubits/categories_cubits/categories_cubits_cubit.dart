import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/features/home/domain/models/categories_view_model.dart';
import 'package:pickpay/features/home/presentation/cubits/categories_cubits/categories_cubits_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  void loadCategories() {
    emit(CategoriesLoading());
    try {
      final categories = [
        CategoryModel(
            name: "Today's Sale",
            image: 'assets/Categories/Electronics/iPhone.png'),
        CategoryModel(
            name: 'Electronics',
            image: 'assets/Categories/Electronics/iPhone.png'),
        CategoryModel(
            name: 'Appliances',
            image: 'assets/Categories/Appliances/Appliances.png'),
        CategoryModel(
            name: 'Home', image: 'assets/Categories/Home/Furniture.png'),
        CategoryModel(
            name: 'Fashion', image: 'assets/Categories/Fashion/fashion1.png'),
        CategoryModel(
            name: 'Beauty', image: 'assets/Categories/Beauty/makeup.png'),
        CategoryModel(
            name: 'Video Games',
            image: 'assets/Categories/VideoGames/videogames.png'),
        CategoryModel(
            name: 'Toys & Games', image: 'assets/Categories/Toys/Toy.png'),
      ];

      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(CategoriesError("Failed to load categories"));
    }
  }

//   void loadCategories() {
//   emit(CategoriesLoading());
//   try {
//     final categories = [
//       CategoryModel(name: 'Sale', image: 'assets/images/sale.jpg'),
//       CategoryModel(name: 'Electronics', image: 'assets/images/electronics.jpg'),
//       CategoryModel(name: 'Appliances', image: 'assets/images/appliances.jpg'),
//       CategoryModel(name: 'Home', image: 'assets/images/home.jpg'),
//       CategoryModel(name: 'Fashion', image: 'assets/images/fashion.jpg'),
//       CategoryModel(name: 'Beauty', image: 'assets/images/beauty.jpg'),
//       CategoryModel(name: 'Video Games', image: 'assets/images/games.jpg'),
//       CategoryModel(name: 'Toys & Games', image: 'assets/images/toys.jpg'),
//     ];
//     emit(CategoriesLoaded(categories));
//   } catch (e) {
//     emit(CategoriesError("Failed to load categories"));
//   }
// }
}
