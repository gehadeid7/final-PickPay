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
      color: json['color'],
      material: json['material'],
      dimensions: json['dimensions'],
      style: json['style'],
      installationType: json['installationType'],
      accessLocation: json['accessLocation'],
      settingsCount: json['settingsCount'],
      powerSource: json['powerSource'],
      manufacturer: json['manufacturer'],
      aboutThisItem: json['description'] ?? json['aboutThisItem'],
      deliveryDate: json['deliveryDate'],
      deliveryTimeLeft: json['deliveryTimeLeft'],
      deliveryLocation: json['deliveryLocation'],
      inStock: json['inStock'],
      shipsFrom: json['shipsFrom'],
      soldBy: json['soldBy'],
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
      finishType: json['finishType'] ?? json['finishtype'],
      containerType: json['containerType'],
      productbenefit: json['productbenefit'],
      itemform: json['itemform'],
      specialty: json['specialty'],
      unitcount: json['unitcount'],
      numberofitems: json['numberofitems'],
      skintype: json['skintype'],
      coverage: json['coverage'],
      ageRangeDescription: json['ageRangeDescription'],
      specialIngredients: json['specialIngredients'],
      activeIngredients: json['activeIngredients'],
      sunProtectionFactor: json['sunProtectionFactor'],
      itemvolume: json['itemvolume'],
      scent: json['scent'],
      targetUseBodyPart: json['targetUseBodyPart'],
      hairtype: json['hairtype'],
      liquidVolume: json['liquidVolume'],
      resultingHairType: json['resultingHairType'],
      materialfeature: json['materialfeature'],
      fragranceConcentration: json['fragranceConcentration'],
      colorOptions: json['colorOptions'] != null
          ? List<String>.from(json['colorOptions'])
          : null,
      scentOption: json['scentOption'] != null
          ? List<String>.from(json['scentOption'])
          : null,
    );
  }

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
      if (color != null) 'color': color,
      if (aboutThisItem != null) 'description': aboutThisItem,
      if (deliveryDate != null) 'deliveryDate': deliveryDate,
      if (deliveryTimeLeft != null) 'deliveryTimeLeft': deliveryTimeLeft,
      if (deliveryLocation != null) 'deliveryLocation': deliveryLocation,
      if (inStock != null) 'inStock': inStock,
      if (shipsFrom != null) 'shipsFrom': shipsFrom,
      if (soldBy != null) 'soldBy': soldBy,
      if (material != null) 'material': material,
      if (dimensions != null) 'dimensions': dimensions,
      if (style != null) 'style': style,
      if (installationType != null) 'installationType': installationType,
      if (accessLocation != null) 'accessLocation': accessLocation,
      if (settingsCount != null) 'settingsCount': settingsCount,
      if (powerSource != null) 'powerSource': powerSource,
      if (modelName != null) 'modelName': modelName,
      if (formFactor != null) 'formFactor': formFactor,
      if (controlsType != null) 'controlsType': controlsType,
      if (itemWeight != null) 'itemWeight': itemWeight,
      if (efficiency != null) 'efficiency': efficiency,
      if (mountingType != null) 'mountingType': mountingType,
      if (capacity != null) 'capacity': capacity,
      if (technology != null) 'technology': technology,
      if (configration != null) 'configration': configration,
      if (energyEfficency != null) 'energyEfficency': energyEfficency,
      if (spinSpeed != null) 'spinSpeed': spinSpeed,
      if (modelNumber != null) 'modelNumber': modelNumber,
      if (numberofprograms != null) 'numberofprograms': numberofprograms,
      if (noiselevel != null) 'noiselevel': noiselevel,
      if (recommendedUsesForProduct != null)
        'recommendedUsesForProduct': recommendedUsesForProduct,
      if (outputWattage != null) 'outputWattage': outputWattage,
      if (wattage != null) 'wattage': wattage,
      if (coffeeMakerType != null) 'coffeeMakerType': coffeeMakerType,
      if (filtertype != null) 'filtertype': filtertype,
      if (stainlessSteelNumberofSpeeds != null)
        'stainlessSteelNumberofSpeeds': stainlessSteelNumberofSpeeds,
      if (bladeMaterial != null) 'bladeMaterial': bladeMaterial,
      if (voltage != null) 'voltage': voltage,
      if (components != null) 'components': components,
      if (powersource != null) 'powersource': powersource,
      if (pressure != null) 'pressure': pressure,
      if (maximumpressure != null) 'maximumpressure': maximumpressure,
      if (controllertype != null) 'controllertype': controllertype,
      if (electricFanDesign != null) 'electricFanDesign': electricFanDesign,
      if (roomtype != null) 'roomtype': roomtype,
      if (surface != null) 'surface': surface,
      if (isProductCordless != null) 'isProductCordless': isProductCordless,
      if (frequency != null) 'frequency': frequency,
      if (slotcount != null) 'slotcount': slotcount,
      if (drawertype != null) 'drawertype': drawertype,
      if (defrostSystem != null) 'defrostSystem': defrostSystem,
      if (size != null) 'size': size,
      if (specialfeatures != null) 'specialfeatures': specialfeatures,
      if (finishType != null) 'finishType': finishType,
      if (containerType != null) 'containerType': containerType,
      if (manufacturer != null) 'manufacturer': manufacturer,
      if (productbenefit != null) 'productbenefit': productbenefit,
      if (itemform != null) 'itemform': itemform,
      if (specialty != null) 'specialty': specialty,
      if (unitcount != null) 'unitcount': unitcount,
      if (numberofitems != null) 'numberofitems': numberofitems,
      if (skintype != null) 'skintype': skintype,
      if (coverage != null) 'coverage': coverage,
      if (ageRangeDescription != null)
        'ageRangeDescription': ageRangeDescription,
      if (specialIngredients != null) 'specialIngredients': specialIngredients,
      if (activeIngredients != null) 'activeIngredients': activeIngredients,
      if (sunProtectionFactor != null)
        'sunProtectionFactor': sunProtectionFactor,
      if (itemvolume != null) 'itemvolume': itemvolume,
      if (scent != null) 'scent': scent,
      if (targetUseBodyPart != null) 'targetUseBodyPart': targetUseBodyPart,
      if (hairtype != null) 'hairtype': hairtype,
      if (liquidVolume != null) 'liquidVolume': liquidVolume,
      if (resultingHairType != null) 'resultingHairType': resultingHairType,
      if (materialfeature != null) 'materialfeature': materialfeature,
      if (fragranceConcentration != null)
        'fragranceConcentration': fragranceConcentration,
      if (colorOptions != null) 'colorOptions': colorOptions,
      if (scentOption != null) 'scentOption': scentOption,
    };
  }
}
