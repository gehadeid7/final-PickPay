import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/features/home/presentation/cubits/categories_cubits/categories_cubits_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  void loadCategories() {
    emit(CategoriesLoading());
    try {
      final categories = [
        'Sale',
        'Electronics',
        'Appliances',
        'Home',
        'Fashion',
        'Beauty',
        'Video Games',
        'Toys & Games',
      ];
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(CategoriesError("Failed to load categories"));
    }
  }
}
