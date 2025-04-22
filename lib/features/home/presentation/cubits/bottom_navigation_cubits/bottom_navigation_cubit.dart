import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(const BottomNavigationChanged(index: 0));

  void changeTab(int index) {
    emit(BottomNavigationChanged(index: index));
  }
}
