class ProductsViewsModel {
  final String id;
  final String title;
  final double price;
  final String brand;
  final String category;
  final List<String> imagePaths;
  final double originalPrice;
  final double rating;
  final int reviewCount;
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
  final String deliveryDate;
  final String deliveryTimeLeft;
  final String deliveryLocation;
  final bool inStock;
  final String shipsFrom;
  final String soldBy;

  ProductsViewsModel({
    required this.id,
    required this.category,
    required this.title,
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
    required this.deliveryDate,
    required this.deliveryTimeLeft,
    required this.deliveryLocation,
    required this.inStock,
    required this.shipsFrom,
    required this.soldBy,
  });

  factory ProductsViewsModel.fromJson(Map<String, dynamic> json) {
    return ProductsViewsModel(
      id: json['_id']?['\$oid'] ??
          json['id'] ??
          '', // Handles MongoDB or Supabase ID
      category: json['category'] ?? '',
      title: json['name'] ?? '',
      imagePaths: List<String>.from(json['imagePaths'] ?? []),
      price: (json['price'] ?? 0).toDouble(),
      originalPrice: (json['originalPrice'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      brand: json['brand'] ?? '',
      color: json['color'] ?? '',
      material: json['material'] ?? '',
      dimensions: json['dimensions'] ?? '',
      style: json['style'] ?? '',
      installationType: json['installationType'] ?? '',
      accessLocation: json['accessLocation'] ?? '',
      settingsCount: json['settingsCount'] ?? 0,
      powerSource: json['powerSource'] ?? '',
      manufacturer: json['manufacturer'] ?? '',
      description: json['description'] ?? '',
      deliveryDate: json['deliveryDate'] ?? '',
      deliveryTimeLeft: json['deliveryTimeLeft'] ?? '',
      deliveryLocation: json['deliveryLocation'] ?? '',
      inStock: json['inStock'] ?? false,
      shipsFrom: json['shipsFrom'] ?? '',
      soldBy: json['soldBy'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, // You might skip this if backend auto-generates
      'category': category,
      'name': title,
      'imagePaths': imagePaths,
      'price': price,
      'originalPrice': originalPrice,
      'rating': rating,
      'reviewCount': reviewCount,
      'brand': brand,
      'color': color,
      'material': material,
      'dimensions': dimensions,
      'style': style,
      'installationType': installationType,
      'accessLocation': accessLocation,
      'settingsCount': settingsCount,
      'powerSource': powerSource,
      'manufacturer': manufacturer,
      'description': description,
      'deliveryDate': deliveryDate,
      'deliveryTimeLeft': deliveryTimeLeft,
      'deliveryLocation': deliveryLocation,
      'inStock': inStock,
      'shipsFrom': shipsFrom,
      'soldBy': soldBy,
    };
  }
}
