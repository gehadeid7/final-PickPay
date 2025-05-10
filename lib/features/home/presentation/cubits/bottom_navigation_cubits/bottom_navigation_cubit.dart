// bottom_navigation_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(const BottomNavigationInitial(0));

  void changeTab(int index) {
    if (index != state.currentIndex) {
      emit(BottomNavigationChanged(index));
    }
  }
}
