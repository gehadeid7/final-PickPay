// lib/features/bottom_navigation/entities/bottom_navigation_bar_entity.dart
class BottomNavigationBarEntity {
  final String activeImage;
  final String inActiveImage;
  final String name;

  const BottomNavigationBarEntity({
    required this.activeImage,
    required this.inActiveImage,
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BottomNavigationBarEntity &&
          runtimeType == other.runtimeType &&
          activeImage == other.activeImage &&
          inActiveImage == other.inActiveImage &&
          name == other.name;

  @override
  int get hashCode =>
      activeImage.hashCode ^ inActiveImage.hashCode ^ name.hashCode;
}
