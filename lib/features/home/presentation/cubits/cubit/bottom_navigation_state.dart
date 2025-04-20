part of 'bottom_navigation_cubit.dart';

sealed class BottomNavigationState extends Equatable {
  const BottomNavigationState();

  @override
  List<Object> get props => [];
}

final class BottomNavigationChanged extends BottomNavigationState {
  final int index;

  const BottomNavigationChanged({required this.index});

  @override
  List<Object> get props => [index];
}
