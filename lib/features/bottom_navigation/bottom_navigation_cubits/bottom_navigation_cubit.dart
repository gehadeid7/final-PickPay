// lib/features/home/presentation/cubits/bottom_navigation_cubits/bottom_navigation_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pickpay/features/bottom_navigation/bottom_navigation_items.dart';

part 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(const BottomNavigationInitial(0));

  void changeTab(int index) {
    if (index < 0 || index >= bottomNavigationBarItems.length) {
      throw ArgumentError('Invalid tab index: $index');
    }

    if (index != state.currentIndex) {
      emit(BottomNavigationChanged(index));
    }
  }

  int get currentIndex => state.currentIndex;
}
