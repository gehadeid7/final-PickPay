class ProductsViewsModel {
  final String name;
  final List<String> imagePaths;
  final double price;
  final double originalPrice;
  final double rating;
  final int reviewCount;
  final String brand;
  final String color;
  final String material;
  final String dimensions;
  final String style;
  final String installationType;
  final String accessLocation;
  final int settingsCount;
  final String powerSource;
  final String manufacturer;
  final String description;

  ProductsViewsModel({
    required this.name,
    required this.imagePaths,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.reviewCount,
    required this.brand,
    required this.color,
    required this.material,
    required this.dimensions,
    required this.style,
    required this.installationType,
    required this.accessLocation,
    required this.settingsCount,
    required this.powerSource,
    required this.manufacturer,
    required this.description,
  });
}
