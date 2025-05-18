import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(const BottomNavigationInitial(0));

  /// Changes the current tab index if it's different from the current state
  void changeTab(int index) {
    if (index < 0 || index > 3) {
      // Assuming you have 4 tabs (0-3)
      throw ArgumentError('Invalid tab index: $index');
    }

    if (index != state.currentIndex) {
      emit(BottomNavigationChanged(index));
    }
  }

  /// Gets the current tab index
  int get currentIndex => state.currentIndex;
}
