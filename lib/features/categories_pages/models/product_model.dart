class ProductsViewsModel {
  final String id;
  final String title;
  final double price;
  final double originalPrice;

  final String? brand;
  final String? category;
  final List<String>? imagePaths;
  final double? rating;
  final int? reviewCount;
  final String? color;
  final String? material;
  final String? dimensions;
  final String? style;
  final String? installationType;
  final String? accessLocation;
  final int? settingsCount;
  final String? powerSource;
  final String? manufacturer;
  final String? description;
  final String? deliveryDate;
  final String? deliveryTimeLeft;
  final String? deliveryLocation;
  final bool? inStock;
  final String? shipsFrom;
  final String? soldBy;

  ProductsViewsModel({
    required this.id,
    required this.title,
    required this.price,
    required this.originalPrice,
    this.brand,
    this.category,
    this.imagePaths,
    this.rating,
    this.reviewCount,
    this.color,
    this.material,
    this.dimensions,
    this.style,
    this.installationType,
    this.accessLocation,
    this.settingsCount,
    this.powerSource,
    this.manufacturer,
    this.description,
    this.deliveryDate,
    this.deliveryTimeLeft,
    this.deliveryLocation,
    this.inStock,
    this.shipsFrom,
    this.soldBy,
  });

  factory ProductsViewsModel.fromJson(Map<String, dynamic> json) {
    return ProductsViewsModel(
      id: json['_id']?['\$oid'] ?? json['id'] ?? '',
      title: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      originalPrice: (json['originalPrice'] ?? 0).toDouble(),
      brand: json['brand'],
      category: json['category'],
      imagePaths: json['imagePaths'] != null
          ? List<String>.from(json['imagePaths'])
          : null,
      rating: (json['rating'] as num?)?.toDouble(),
      reviewCount: json['reviewCount'],
      color: json['color'],
      material: json['material'],
      dimensions: json['dimensions'],
      style: json['style'],
      installationType: json['installationType'],
      accessLocation: json['accessLocation'],
      settingsCount: json['settingsCount'],
      powerSource: json['powerSource'],
      manufacturer: json['manufacturer'],
      description: json['description'],
      deliveryDate: json['deliveryDate'],
      deliveryTimeLeft: json['deliveryTimeLeft'],
      deliveryLocation: json['deliveryLocation'],
      inStock: json['inStock'],
      shipsFrom: json['shipsFrom'],
      soldBy: json['soldBy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': title,
      'price': price,
      'originalPrice': originalPrice,
      if (brand != null) 'brand': brand,
      if (category != null) 'category': category,
      if (imagePaths != null) 'imagePaths': imagePaths,
      if (rating != null) 'rating': rating,
      if (reviewCount != null) 'reviewCount': reviewCount,
      if (color != null) 'color': color,
      if (material != null) 'material': material,
      if (dimensions != null) 'dimensions': dimensions,
      if (style != null) 'style': style,
      if (installationType != null) 'installationType': installationType,
      if (accessLocation != null) 'accessLocation': accessLocation,
      if (settingsCount != null) 'settingsCount': settingsCount,
      if (powerSource != null) 'powerSource': powerSource,
      if (manufacturer != null) 'manufacturer': manufacturer,
      if (description != null) 'description': description,
      if (deliveryDate != null) 'deliveryDate': deliveryDate,
      if (deliveryTimeLeft != null) 'deliveryTimeLeft': deliveryTimeLeft,
      if (deliveryLocation != null) 'deliveryLocation': deliveryLocation,
      if (inStock != null) 'inStock': inStock,
      if (shipsFrom != null) 'shipsFrom': shipsFrom,
      if (soldBy != null) 'soldBy': soldBy,
    };
  }
}
