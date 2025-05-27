import 'dart:developer' as dev;

class ProductsViewsModel {
  // General product information
  final String id;
  final String title;
  final double price;
  final double? originalPrice;
  final String? category;
  final String? subcategory;
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
    this.subcategory,
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
    try {
      if (json == null) {
        throw Exception('Product data is null');
      }

      // Handle both product and cart item formats
      final productData = json['product'] ?? json;
      if (productData == null) {
        throw Exception('Product data is null');
      }

      // Get required fields with type checking
      final id = productData['_id']?.toString() ?? productData['id']?.toString();
      if (id == null) {
        throw Exception('Product ID is missing');
      }

      final title = productData['title']?.toString();
      if (title == null) {
        throw Exception('Product title is missing');
      }

      // Handle price which could be int or double
      final price = productData['price'];
      if (price == null) {
        throw Exception('Product price is missing');
      }
      final priceValue = price is int ? price.toDouble() : (price is double ? price : double.parse(price.toString()));

      // Handle optional fields with null safety
      final originalPrice = productData['originalPrice'];
      final originalPriceValue = originalPrice == null ? null : 
        (originalPrice is int ? originalPrice.toDouble() : 
         (originalPrice is double ? originalPrice : double.parse(originalPrice.toString())));

      // Handle image paths
      List<String>? imagePaths;
      if (productData['images'] != null) {
        if (productData['images'] is List) {
          imagePaths = (productData['images'] as List)
              .map((img) => img.toString())
              .toList();
        } else if (productData['images'] is String) {
          imagePaths = [productData['images']];
        }
      } else if (productData['imageCover'] != null) {
        imagePaths = [productData['imageCover'].toString()];
      }

      return ProductsViewsModel(
        id: id,
        title: title,
        price: priceValue,
        originalPrice: originalPriceValue,
        category: productData['category']?.toString(),
        subcategory: productData['subcategory']?.toString(),
        imagePaths: imagePaths,
        rating: productData['ratingsAverage']?.toDouble(),
        reviewCount: productData['ratingsQuantity']?.toInt(),
        brand: productData['brand']?.toString(),
        color: productData['color']?.toString(),
        aboutThisItem: productData['aboutThisItem']?.toString(),
        deliveryDate: productData['deliveryDate']?.toString(),
        deliveryTimeLeft: productData['deliveryTimeLeft']?.toString(),
        deliveryLocation: productData['deliveryLocation']?.toString(),
        inStock: productData['inStock']?.toBool(),
        shipsFrom: productData['shipsFrom']?.toString(),
        soldBy: productData['soldBy']?.toString(),
        // Add other fields as needed
      );
    } catch (e, stackTrace) {
      dev.log('Error creating ProductsViewsModel: $e\n$stackTrace', name: 'ProductsViewsModel', error: e);
      rethrow;
    }
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
