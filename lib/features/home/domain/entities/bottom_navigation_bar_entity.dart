class BottomNavigationBarEntity {
  final String activeImage, inActiveImage;
  final String name;

  BottomNavigationBarEntity(
      {required this.activeImage,
      required this.inActiveImage,
      required this.name});
}

List<BottomNavigationBarEntity> get bottomNavigationBarItems => [
      BottomNavigationBarEntity(
          activeImage: 'assets/icons/home(1).png',
          inActiveImage: 'assets/icons/home.png',
          name: 'Home'),
      BottomNavigationBarEntity(
          activeImage: 'assets/icons/categories(1).png',
          inActiveImage: 'assets/icons/categories.png',
          name: 'Categories'),
      BottomNavigationBarEntity(
          activeImage: 'assets/icons/shopping-cart(1).png',
          inActiveImage: 'assets/icons/shopping-cart.png',
          name: 'Cart'),
      BottomNavigationBarEntity(
          activeImage: 'assets/icons/user_filled.png',
          inActiveImage: 'assets/icons/user_unfilled.png',
          name: 'Profile'),
    ];
