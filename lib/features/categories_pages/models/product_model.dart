class ProductsViewsModel {
  // general
  final String id;
  final String title;
  final double price;

  final double? originalPrice;
  final String? category;
  final List<String>? imagePaths;
  final double? rating;
  final int? reviewCount;
  final String? brand;
  final String? color;
  final String? aboutThisItem;
  final String? deliveryDate;
  final String? deliveryTimeLeft;
  final String? deliveryLocation;
  final bool? inStock;
  final String? shipsFrom;
  final String? soldBy;
  final String? specialfeatures;
  final String? finishType;
  final String? containerType;
  final String? manufacturer;

// appliances detailes
  final String? material;
  final String? dimensions;
  final String? style;
  final String? installationType;
  final String? accessLocation;
  final int? settingsCount;
  final String? powerSource;
  final String? modelName;
  final String? formFactor;
  final String? controlsType;
  final String? itemWeight;
  final String? efficiency;
  final String? mountingType;
  final String? capacity;
  final String? technology;
  final String? configration;
  final String? energyEfficency;
  final String? spinSpeed;
  final String? modelNumber;
  final String? numberofprograms;
  final String? noiselevel;
  final String? recommendedUsesForProduct;
  final String? outputWattage;
  final String? wattage;
  final String? coffeeMakerType;
  final String? filtertype;
  final String? stainlessSteelNumberofSpeeds;
  final String? bladeMaterial;
  final String? voltage;
  final String? finishtype;
  final String? components;
  final String? powersource;
  final String? pressure;
  final String? maximumpressure;
  final String? controllertype;
  final String? electricFanDesign;
  final String? roomtype;
  final String? surface;
  final String? isProductCordless;
  final String? frequency;
  final String? slotcount;
  final String? drawertype;
  final String? defrostSystem;

  // beauty
  final String? productbenefit;
  final String? itemform;
  final String? specialty;
  final String? unitcount;
  final String? numberofitems;
  final String? skintype;
  final String? coverage;
  final String? ageRangeDescription;
  final String? specialIngredients;
  final String? activeIngredients;
  final String? sunProtectionFactor;
  final String? itemvolume;
  final String? scent;
  final String? targetUseBodyPart;
  final String? hairtype;
  final String? liquidVolume;
  final String? resultingHairType;
  final String? materialfeature;
  final String? fragranceConcentration;

  ProductsViewsModel({
    required this.id,
    required this.title,
    required this.price,
    this.originalPrice,
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
    this.defrostSystem,
    this.settingsCount,
    this.powerSource,
    this.manufacturer,
    this.aboutThisItem,
    this.deliveryDate,
    this.deliveryTimeLeft,
    this.deliveryLocation,
    this.inStock,
    this.shipsFrom,
    this.soldBy,
    this.specialfeatures,
    this.finishType,
    this.modelName,
    this.formFactor,
    this.controlsType,
    this.itemWeight,
    this.efficiency,
    this.mountingType,
    this.capacity,
    this.technology,
    this.configration,
    this.energyEfficency,
    this.spinSpeed,
    this.modelNumber,
    this.numberofprograms,
    this.noiselevel,
    this.recommendedUsesForProduct,
    this.outputWattage,
    this.wattage,
    this.coffeeMakerType,
    this.filtertype,
    this.stainlessSteelNumberofSpeeds,
    this.bladeMaterial,
    this.containerType,
    this.voltage,
    this.finishtype,
    this.components,
    this.powersource,
    this.pressure,
    this.maximumpressure,
    this.controllertype,
    this.electricFanDesign,
    this.roomtype,
    this.surface,
    this.isProductCordless,
    this.frequency,
    this.slotcount,
    this.productbenefit,
    this.itemform,
    this.specialty,
    this.unitcount,
    this.numberofitems,
    this.skintype,
    this.coverage,
    this.ageRangeDescription,
    this.specialIngredients,
    this.activeIngredients,
    this.sunProtectionFactor,
    this.itemvolume,
    this.scent,
    this.targetUseBodyPart,
    this.hairtype,
    this.liquidVolume,
    this.resultingHairType,
    this.materialfeature,
    this.fragranceConcentration,
    this.drawertype,
  });

// for back
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
      aboutThisItem: json['description'],
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
      if (aboutThisItem != null) 'description': aboutThisItem,
      if (deliveryDate != null) 'deliveryDate': deliveryDate,
      if (deliveryTimeLeft != null) 'deliveryTimeLeft': deliveryTimeLeft,
      if (deliveryLocation != null) 'deliveryLocation': deliveryLocation,
      if (inStock != null) 'inStock': inStock,
      if (shipsFrom != null) 'shipsFrom': shipsFrom,
      if (soldBy != null) 'soldBy': soldBy,
    };
  }
}
