part of 'bottom_navigation_cubit.dart';

sealed class BottomNavigationState extends Equatable {
  final int currentIndex;

  const BottomNavigationState(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}

class BottomNavigationInitial extends BottomNavigationState {
  const BottomNavigationInitial(super.currentIndex);
}

class BottomNavigationChanged extends BottomNavigationState {
  const BottomNavigationChanged(super.currentIndex);
}
