class ProductsViewsModel {
  // General product information
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

  // appliances specifications
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
  final String? size;
  final String? specialfeatures;
  final String? finishType;
  final String? containerType;
  final String? manufacturer;

  // Beauty-specific properties
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
  final List<String>? colorOptions;
  final List<String>? scentOption;

  // fashion information
  final String? careInstruction;
  final String? closureType;
  final String? soleMaterial;
  final String? outerMaterial;
  final String? innerMaterial;
  final String? waterResistanceLevel;
  final String? shaftHeight;
  final String? lining;
  final String? materialcomposition;
  final List<String>? availableSizes;
  final Map<String, bool>? sizeAvailability;
  final Map<String, bool>? colorAvailability;

// video games & electronics information
  final String? compatibleDevices;
  final String? controllerType;
  final String? connectivityTechnology;
  final String? buttonQuantity;
  final String? itemPackageQuantity;
  final String? hardwarePlatform;
  final String? compatiblePhoneModels;
  final String? includedComponents;
  final String? inputVoltage;
  final String? digitalStorageCapacity;
  final String? hardDiskDescription;
  final String? hardDiskFormFactor;
  final String? connectorType;
  //
  final String? patternName;
  final String? memoryStorageCapacity;
  final String? screenSize;
  final String? displayResolution;
  final String? operatingSystem;
  final String? ramMemoryInstalled;
  final String? generation;
  final String? displayResolutionMaximum;
  final String? modelYear;
  final String? wirelessProvider;
  final String? cellularTechnology;
  final String? wirelessNetworkTechnology;
  final String? pattern;
  final String? embellishmentFeature;
  final String? theme;
  final String? resolution;
  final String? refreshRate;
  final String? aspectRatio;
  final String? displayTechnology;
  final String? supportedInternetServices;
  final String? graphicsDescription;
  final String? cpuModel;
  final String? cpuSpeed;
  final String? hardDiskSize;
  final String? printerTechnology;
  final String? printerOutput;
  final String? maximumPrintSpeedColor;
  final String? coolingMethod;

  // home category information
  final String? requiredAssembly;
  final String? seatingCapacity;
  final String? sofaType;
  final String? upholsteryFabricType;
  final String? itemShape;
  final String? armStyle;
  final String? fillMaterial;
  final String? fabricType;
  final String? maximumWeightRecommendation;
  final String? frameMaterial;
  final String? topMaterialType;
  final String? productCareInstructions;
  final String? backStyle;
  final String? seatMaterial;
  final String? itemFirmnessDescription;
  final String? topStyle;
  final String? coverMatrial;
  final String? pileheight;
  final String? indoorOutdoorUsage;
  final String? isStainResistant;
  final String? displayType;
  final String? roomType;
  final String? occasion;
  final String? subjectCharacter;
  final String? handleMaterial;
  final String? closureMaterial;
  final String? materialTypeFree;
  final String? compatibilityOptions;
  final String? numberOfPieces;
  final String? upc;
  final String? towelFormType;
  final String? pillowType;
  final String? blanketForm;
  final String? threadCount;
  final String? amperage;

  ProductsViewsModel({
    required this.id,
    required this.title,
    required this.price,
    this.originalPrice,
    this.category,
    this.imagePaths,
    this.rating,
    this.reviewCount,
    this.brand,
    this.color,
    this.amperage,
    this.aboutThisItem,
    this.deliveryDate,
    this.deliveryTimeLeft,
    this.deliveryLocation,
    this.inStock,
    this.shipsFrom,
    this.soldBy,
    this.material,
    this.dimensions,
    this.style,
    this.installationType,
    this.accessLocation,
    this.settingsCount,
    this.powerSource,
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
    this.voltage,
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
    this.drawertype,
    this.defrostSystem,
    this.size,
    this.specialfeatures,
    this.finishType,
    this.containerType,
    this.manufacturer,
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
    this.colorOptions,
    this.scentOption,
    this.careInstruction,
    this.closureType,
    this.soleMaterial,
    this.outerMaterial,
    this.innerMaterial,
    this.waterResistanceLevel,
    this.shaftHeight,
    this.lining,
    this.materialcomposition,
    this.availableSizes,
    this.sizeAvailability,
    this.colorAvailability,
    this.compatibleDevices,
    this.controllerType,
    this.connectivityTechnology,
    this.buttonQuantity,
    this.itemPackageQuantity,
    this.hardwarePlatform,
    this.compatiblePhoneModels,
    this.includedComponents,
    this.inputVoltage,
    this.digitalStorageCapacity,
    this.hardDiskDescription,
    this.hardDiskFormFactor,
    this.connectorType,
    this.patternName,
    this.memoryStorageCapacity,
    this.screenSize,
    this.displayResolution,
    this.operatingSystem,
    this.ramMemoryInstalled,
    this.generation,
    this.displayResolutionMaximum,
    this.modelYear,
    this.wirelessProvider,
    this.cellularTechnology,
    this.wirelessNetworkTechnology,
    this.pattern,
    this.embellishmentFeature,
    this.theme,
    this.resolution,
    this.refreshRate,
    this.aspectRatio,
    this.displayTechnology,
    this.supportedInternetServices,
    this.graphicsDescription,
    this.cpuModel,
    this.cpuSpeed,
    this.hardDiskSize,
    this.printerTechnology,
    this.printerOutput,
    this.maximumPrintSpeedColor,
    this.coolingMethod,
    this.requiredAssembly,
    this.seatingCapacity,
    this.sofaType,
    this.upholsteryFabricType,
    this.itemShape,
    this.armStyle,
    this.fillMaterial,
    this.fabricType,
    this.maximumWeightRecommendation,
    this.frameMaterial,
    this.topMaterialType,
    this.productCareInstructions,
    this.backStyle,
    this.seatMaterial,
    this.itemFirmnessDescription,
    this.topStyle,
    this.coverMatrial,
    this.pileheight,
    this.indoorOutdoorUsage,
    this.isStainResistant,
    this.displayType,
    this.roomType,
    this.occasion,
    this.subjectCharacter,
    this.handleMaterial,
    this.closureMaterial,
    this.materialTypeFree,
    this.compatibilityOptions,
    this.numberOfPieces,
    this.upc,
    this.towelFormType,
    this.pillowType,
    this.blanketForm,
    this.threadCount,
  });

  factory ProductsViewsModel.fromJson(Map<String, dynamic> json) {
<<<<<<< Updated upstream
    return ProductsViewsModel(
      id: json['_id']?['\$oid'] ?? json['id'] ?? '',
      title: json['name'] ?? json['title'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      originalPrice:
          (json['originalPrice'] ?? json['listPrice'] ?? 0).toDouble(),
      brand: json['brand'],
      category: json['category'],
      imagePaths: json['imagePaths'] != null
          ? List<String>.from(json['imagePaths'])
          : json['images'] != null
              ? List<String>.from(json['images'])
              : null,
      rating: (json['rating'] as num?)?.toDouble(),
      reviewCount: json['reviewCount'],
    );
  }
=======
  return ProductsViewsModel(
    id: json['_id']?['\$oid'] ?? json['id'] ?? '',
    title: json['title'] ?? json['name'] ?? '',
    price: (json['price'] ?? 0).toDouble(),
    originalPrice: (json['originalPrice'] ?? json['listPrice'])?.toDouble(),
    category: json['category'],
    imagePaths: json['imagePaths'] != null
        ? List<String>.from(json['imagePaths'])
        : json['images'] != null
            ? List<String>.from(json['images'])
            : null,
    rating: (json['rating'] as num?)?.toDouble(),
    reviewCount: json['reviewCount'],
    brand: json['brand'],
    color: json['color'],
    aboutThisItem: json['aboutThisItem'] ?? json['description'],
    deliveryDate: json['deliveryDate'],
    deliveryTimeLeft: json['deliveryTimeLeft'],
    deliveryLocation: json['deliveryLocation'],
    inStock: json['inStock'],
    shipsFrom: json['shipsFrom'],
    soldBy: json['soldBy'],

    // Continue adding remaining fields below
    material: json['material'],
    dimensions: json['dimensions'],
    style: json['style'],
    installationType: json['installationType'],
    accessLocation: json['accessLocation'],
    settingsCount: json['settingsCount'],
    powerSource: json['powerSource'],
    modelName: json['modelName'],
    formFactor: json['formFactor'],
    controlsType: json['controlsType'],
    itemWeight: json['itemWeight'],
    efficiency: json['efficiency'],
    mountingType: json['mountingType'],
    capacity: json['capacity'],
    technology: json['technology'],
    configration: json['configration'],
    energyEfficency: json['energyEfficency'],
    spinSpeed: json['spinSpeed'],
    modelNumber: json['modelNumber'],
    numberofprograms: json['numberofprograms'],
    noiselevel: json['noiselevel'],
    recommendedUsesForProduct: json['recommendedUsesForProduct'],
    outputWattage: json['outputWattage'],
    wattage: json['wattage'],
    coffeeMakerType: json['coffeeMakerType'],
    filtertype: json['filtertype'],
    stainlessSteelNumberofSpeeds: json['stainlessSteelNumberofSpeeds'],
    bladeMaterial: json['bladeMaterial'],
    voltage: json['voltage'],
    components: json['components'],
    powersource: json['powersource'],
    pressure: json['pressure'],
    maximumpressure: json['maximumpressure'],
    controllertype: json['controllertype'],
    electricFanDesign: json['electricFanDesign'],
    roomtype: json['roomtype'],
    surface: json['surface'],
    isProductCordless: json['isProductCordless'],
    frequency: json['frequency'],
    slotcount: json['slotcount'],
    drawertype: json['drawertype'],
    defrostSystem: json['defrostSystem'],
    size: json['size'],
    specialfeatures: json['specialfeatures'],
    finishType: json['finishType'],
    containerType: json['containerType'],
    manufacturer: json['manufacturer'],
  );
}

>>>>>>> Stashed changes

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': title,
      'price': price,
      if (originalPrice != null) 'originalPrice': originalPrice,
      if (category != null) 'category': category,
      if (imagePaths != null) 'imagePaths': imagePaths,
      if (rating != null) 'rating': rating,
      if (reviewCount != null) 'reviewCount': reviewCount,
      if (brand != null) 'brand': brand,
    };
  }
  
}
