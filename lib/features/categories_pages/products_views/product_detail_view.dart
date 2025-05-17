import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/core/widgets/custom_button.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/color_option_selector.dart';
import 'package:pickpay/features/categories_pages/widgets/info_icons_row.dart';
import 'package:pickpay/features/categories_pages/widgets/product_rating.dart';
import 'package:pickpay/features/categories_pages/widgets/products_view_appbar.dart';
import 'package:pickpay/features/categories_pages/widgets/scent_option.dart';
import 'package:pickpay/features/categories_pages/widgets/size_option.dart';
import 'package:pickpay/features/home/domain/models/cart_item_model.dart';
import 'package:pickpay/features/home/presentation/cubits/cart_cubits/cart_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ProductDetailView extends StatefulWidget {
  final ProductsViewsModel product;

  const ProductDetailView({super.key, required this.product});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  late AnimationController _animationController;
  Animation<double>? _fadeAnimation;
  Animation<Offset>? _slideAnimation;
  final ScrollController _scrollController = ScrollController();
  bool _showAddToCartButton = true;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 50),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    _animationController.forward();

    _scrollController.addListener(() {
      if (_scrollController.offset > 200 && _showAddToCartButton) {
        setState(() => _showAddToCartButton = false);
      } else if (_scrollController.offset <= 200 && !_showAddToCartButton) {
        setState(() => _showAddToCartButton = true);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final product = widget.product;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey.shade900 : Colors.white,
      appBar: ProductDetailAppBar(
        product: product,
        onBackPressed: () => Navigator.of(context).pop(),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            child: AnimationLimiter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 500),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(
                      child: widget,
                    ),
                  ),
                  children: [
                    _buildImageSlider(product, isDarkMode),
                    const SizedBox(height: 16),
                    ScaleTransition(
                      scale: _fadeAnimation ?? AlwaysStoppedAnimation(1.0),
                      child: Text(
                        product.title,
                        style: TextStyles.bold19.copyWith(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildPriceAndRating(product, isDarkMode),
                    const SizedBox(height: 16),
                    InfoSectionWithIcons(),
                    const SizedBox(height: 16),
                    _buildOptionsSection(product, isDarkMode),
                    const SizedBox(height: 24),
                    _buildSectionTitle("Product Details", isDarkMode),
                    _buildFeatureBox(
                        _buildProductDetails(product, isDarkMode), isDarkMode),
                    const SizedBox(height: 24),
                    _buildSectionTitle("About this item", isDarkMode),
                    _buildAboutItem(product, isDarkMode),
                    const SizedBox(height: 24),
                    _buildSectionTitle("Delivery", isDarkMode),
                    _buildDeliveryInfo(product, isDarkMode),
                    const SizedBox(height: 24),
                    _buildSellerInfo(product, isDarkMode),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            bottom: _showAddToCartButton ? 30 : -100,
            left: 16,
            right: 16,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: _animationController,
                curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
              )),
              child: ScaleTransition(
                scale: _fadeAnimation ?? AlwaysStoppedAnimation(1.0),
                child: CustomButton(
                  onPressed: () {
                    Feedback.forTap(context);
                    context.read<CartCubit>().addToCart(
                          CartItemModel(
                            product: product,
                            quantity: 1,
                          ),
                        );
                  },
                  buttonText: "Add to Cart",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSlider(ProductsViewsModel product, bool isDarkMode) {
    return Column(
      children: [
        Hero(
          tag: 'product-${product.id}',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              height: 300,
              child: PageView.builder(
                controller: _pageController,
                itemCount: product.imagePaths?.length ?? 0,
                itemBuilder: (context, index) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Image.asset(
                      product.imagePaths![index],
                      key: ValueKey(product.imagePaths![index]),
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.image_not_supported,
                        color: isDarkMode ? Colors.white54 : Colors.grey,
                        size: 40,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: SmoothPageIndicator(
            key: ValueKey(product.imagePaths?.length ?? 0),
            controller: _pageController,
            count: product.imagePaths?.length ?? 0,
            effect: WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: isDarkMode ? Colors.blueAccent : Colors.blue,
              dotColor: isDarkMode ? Colors.grey : Colors.grey[300]!,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceAndRating(ProductsViewsModel product, bool isDarkMode) {
    return SlideTransition(
      position: _slideAnimation ?? AlwaysStoppedAnimation(Offset.zero),
      child: FadeTransition(
        opacity: _fadeAnimation ?? AlwaysStoppedAnimation(1.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          color: isDarkMode ? Colors.grey[800] : Colors.grey.shade200,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Current price (top-left)
                    Text(
                      "EGP ${product.price.toStringAsFixed(2)}",
                      style: TextStyles.bold19.copyWith(
                        color: Colors.green.shade700,
                      ),
                    ),
                    // Original price (top-right) if exists
                    if (product.originalPrice != null &&
                        product.originalPrice! > product.price)
                      Text(
                        "EGP ${product.originalPrice!.toStringAsFixed(2)}",
                        style: TextStyles.semiBold16.copyWith(
                          color: Colors.red,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                // Second row with 2 items
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Discount percentage (bottom-left)
                    if (product.originalPrice != null &&
                        product.originalPrice! > product.price)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "${((product.originalPrice! - product.price) / product.originalPrice! * 100).toStringAsFixed(0)}% OFF",
                          style: TextStyles.bold13.copyWith(
                            color: Colors.red.shade800,
                          ),
                        ),
                      ),
                    // Rating (bottom-right)
                    ProductRating(
                      rating: product.rating ?? 0.0,
                      reviewCount: product.reviewCount ?? 0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionsSection(ProductsViewsModel product, bool isDarkMode) {
    return SlideTransition(
      position: _slideAnimation ?? AlwaysStoppedAnimation(Offset.zero),
      child: FadeTransition(
        opacity: _fadeAnimation ?? AlwaysStoppedAnimation(1.0),
        child: Column(
          children: [
            if (product.colorOptions?.isNotEmpty ?? false) ...[
              ColorOptionSelector(
                colorOptions: product.colorOptions!,
                colorAvailability: product.colorAvailability,
              ),
              const SizedBox(height: 16),
            ],
            if (product.scentOption?.isNotEmpty ?? false) ...[
              ScentOption(
                scentOption: product.scentOption!,
                showLabel: true,
                onScentSelected: (selectedScentName) {
                  debugPrint("Scent: $selectedScentName");
                },
              ),
              const SizedBox(height: 16),
            ],
            if (product.availableSizes?.isNotEmpty ?? false) ...[
              SizeOptionSelector(
                availableSizes: product.availableSizes!,
                showLabel: true,
                sizeAvailability: product.sizeAvailability,
                onSizeSelected: (selectedSize) {
                  debugPrint("Size: $selectedSize");
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  List<Widget> _buildProductDetails(
      ProductsViewsModel product, bool isDarkMode) {
    final details = [
      _ProductFeatureRow(
          label: "Brand", value: product.brand, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Category", value: product.category, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Color", value: product.color, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Material", value: product.material, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Dimensions",
          value: product.dimensions,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Style", value: product.style, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Installation Type",
          value: product.installationType,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Access Location",
          value: product.accessLocation,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Settings Count",
          value: product.settingsCount?.toString(),
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Power Source",
          value: product.powerSource,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Manufacturer",
          value: product.manufacturer,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Drawer Type",
          value: product.drawertype,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Special Features",
          value: product.specialfeatures,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Finish Type",
          value: product.finishType,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Model Name",
          value: product.modelName,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Form Factor",
          value: product.formFactor,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Controls Type",
          value: product.controlsType,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Item Weight",
          value: product.itemWeight,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Efficiency",
          value: product.efficiency,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Mounting Type",
          value: product.mountingType,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Capacity", value: product.capacity, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Technology",
          value: product.technology,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Configuration",
          value: product.configration,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Energy Efficiency",
          value: product.energyEfficency,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Spin Speed",
          value: product.spinSpeed,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Model Number",
          value: product.modelNumber,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Number of Programs",
          value: product.numberofprograms,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Noise Level",
          value: product.noiselevel,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Recommended Uses",
          value: product.recommendedUsesForProduct,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Output Wattage",
          value: product.outputWattage,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Wattage", value: product.wattage, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Coffee Maker Type",
          value: product.coffeeMakerType,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Filter Type",
          value: product.filtertype,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Steel Speeds",
          value: product.stainlessSteelNumberofSpeeds,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Blade Material",
          value: product.bladeMaterial,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Container Type",
          value: product.containerType,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Voltage", value: product.voltage, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Components",
          value: product.components,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Power Source",
          value: product.powersource,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Pressure", value: product.pressure, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Max Pressure",
          value: product.maximumpressure,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Controller Type",
          value: product.controllertype,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Fan Design",
          value: product.electricFanDesign,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Room Type", value: product.roomtype, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Surface", value: product.surface, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Cordless",
          value: product.isProductCordless?.toString(),
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Frequency", value: product.frequency, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Slot Count",
          value: product.slotcount,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Product Benefit",
          value: product.productbenefit,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Item Form", value: product.itemform, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Specialty", value: product.specialty, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Unit Count",
          value: product.unitcount,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Number of Items",
          value: product.numberofitems,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Skin Type", value: product.skintype, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Coverage", value: product.coverage, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Age Range",
          value: product.ageRangeDescription,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Special Ingredients",
          value: product.specialIngredients,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Active Ingredients",
          value: product.activeIngredients,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "SPF",
          value: product.sunProtectionFactor,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Item Volume",
          value: product.itemvolume,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Scent", value: product.scent, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Target Body Part",
          value: product.targetUseBodyPart,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Hair Type", value: product.hairtype, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Liquid Volume",
          value: product.liquidVolume,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Resulting Hair Type",
          value: product.resultingHairType,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Material Feature",
          value: product.materialfeature,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Fragrance Concentration",
          value: product.fragranceConcentration,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Defrost System",
          value: product.defrostSystem,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Size", value: product.size, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Care Instruction",
          value: product.careInstruction,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Closure Type",
          value: product.closureType,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Sole Material",
          value: product.soleMaterial,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Outer Material",
          value: product.outerMaterial,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Inner Material",
          value: product.innerMaterial,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Water Resistance Level",
          value: product.waterResistanceLevel,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Shaft Height",
          value: product.shaftHeight,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Lining", value: product.lining, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Material Composition",
          value: product.materialcomposition,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Compatible Devices",
          value: product.compatibleDevices,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Controller Type",
          value: product.controllerType,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Connectivity Technology",
          value: product.connectivityTechnology,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Button Quantity",
          value: product.buttonQuantity,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Item Package Quantity",
          value: product.itemPackageQuantity,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Hardware Platform",
          value: product.hardwarePlatform,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Compatible Phone Models",
          value: product.compatiblePhoneModels,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Included Components",
          value: product.includedComponents,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Input Voltage",
          value: product.inputVoltage,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Digital Storage Capacity",
          value: product.digitalStorageCapacity,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Hard Disk Description",
          value: product.hardDiskDescription,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Hard Disk Form Factor",
          value: product.hardDiskFormFactor,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Connector Type",
          value: product.connectorType,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Pattern Name",
          value: product.patternName,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Memory Storage Capacity",
          value: product.memoryStorageCapacity,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Screen Size",
          value: product.screenSize,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Display Resolution",
          value: product.displayResolution,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Operating System",
          value: product.operatingSystem,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Ram Memory Installed",
          value: product.ramMemoryInstalled,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Generation",
          value: product.generation,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Display Resolution Maximum",
          value: product.displayResolutionMaximum,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Model Year",
          value: product.modelYear,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "wireless Provider",
          value: product.wirelessProvider,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Cellular Technology",
          value: product.cellularTechnology,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "wireless Network Technology",
          value: product.wirelessNetworkTechnology,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Pattern", value: product.pattern, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Embellishment Feature",
          value: product.embellishmentFeature,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Theme", value: product.theme, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Resolution",
          value: product.resolution,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Refresh Rate",
          value: product.refreshRate,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Aspect Ratio",
          value: product.aspectRatio,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Display Technology",
          value: product.displayTechnology,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Supported Internet Services",
          value: product.supportedInternetServices,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Graphics Description",
          value: product.graphicsDescription,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "CPU Model", value: product.cpuModel, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "CPU Speed", value: product.cpuSpeed, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Hard Disk Size",
          value: product.hardDiskSize,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Printer Technology",
          value: product.printerTechnology,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Printer Output",
          value: product.printerOutput,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "maximum Print Speed (Color)",
          value: product.maximumPrintSpeedColor,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Cooling Method",
          value: product.coolingMethod,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Required Assembly",
          value: product.requiredAssembly,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Seating Capacity",
          value: product.seatingCapacity,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Sofa Type", value: product.sofaType, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Upholstery Fabric Type",
          value: product.upholsteryFabricType,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Item Shape",
          value: product.itemShape,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Arm Style", value: product.armStyle, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Fill Material",
          value: product.fillMaterial,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Fabric Type",
          value: product.fabricType,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Maximum Weight Recommendation",
          value: product.maximumWeightRecommendation,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Frame Material",
          value: product.frameMaterial,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Top Material Type",
          value: product.topMaterialType,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Product Care Instructions",
          value: product.productCareInstructions,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "back Style",
          value: product.backStyle,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "seat Material",
          value: product.seatMaterial,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "item Firmness Description",
          value: product.itemFirmnessDescription,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Top Style", value: product.topStyle, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Cover Matrial",
          value: product.coverMatrial,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Pile Height",
          value: product.pileheight,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Indoor Outdoor Usage",
          value: product.indoorOutdoorUsage,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "is Stain Resistant",
          value: product.isStainResistant,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Display Type",
          value: product.displayType,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Room Type", value: product.roomType, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Occasion", value: product.occasion, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Subject Character",
          value: product.subjectCharacter,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Handle Material",
          value: product.handleMaterial,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Closure Material",
          value: product.closureMaterial,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Material Type Free",
          value: product.materialTypeFree,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Compatibility Options",
          value: product.compatibilityOptions,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Number Of Pieces",
          value: product.numberOfPieces,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "UPC", value: product.upc, isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Towel Form Type",
          value: product.towelFormType,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Pillow Type",
          value: product.pillowType,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Blanket Form",
          value: product.blanketForm,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Thread Count",
          value: product.threadCount,
          isDarkMode: isDarkMode),
      _ProductFeatureRow(
          label: "Amperage", value: product.amperage, isDarkMode: isDarkMode),
    ];

    return details
        .where((element) => element.value != null && element.value!.isNotEmpty)
        .toList();
  }

  Widget _buildAboutItem(ProductsViewsModel product, bool isDarkMode) {
    return FadeTransition(
      opacity: _fadeAnimation ?? AlwaysStoppedAnimation(1.0),
      child: SlideTransition(
        position: _slideAnimation ?? AlwaysStoppedAnimation(Offset.zero),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey[800] : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: (product.aboutThisItem?.split('\n') ??
                    ['No description available'])
                .map((line) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        line,
                        style: TextStyles.regular13.copyWith(
                          color: isDarkMode ? Colors.white70 : Colors.black87,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildDeliveryInfo(ProductsViewsModel product, bool isDarkMode) {
    return FadeTransition(
      opacity: _fadeAnimation ?? AlwaysStoppedAnimation(1.0),
      child: SlideTransition(
        position: _slideAnimation ?? AlwaysStoppedAnimation(Offset.zero),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey[800] : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _infoRow(
                Icons.local_shipping_outlined,
                RichText(
                  text: TextSpan(
                    style: TextStyles.regular13.copyWith(
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                    children: [
                      const TextSpan(
                        text: 'FREE Delivery ',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                          text:
                              '${product.deliveryDate ?? 'soon'} order\nwithin '),
                      TextSpan(
                        text: product.deliveryTimeLeft ?? '',
                        style: const TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),
                isDarkMode: isDarkMode,
              ),
              const SizedBox(height: 12),
              _infoRow(
                Icons.location_on_outlined,
                RichText(
                  text: TextSpan(
                    style: TextStyles.regular13.copyWith(
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                    children: [
                      const TextSpan(text: 'Deliver to '),
                      TextSpan(
                        text: product.deliveryLocation ?? 'your location',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                isDarkMode: isDarkMode,
              ),
              const SizedBox(height: 12),
              _infoRow(
                (product.inStock ?? false) ? Icons.check_circle : Icons.cancel,
                Text(
                  (product.inStock ?? false) ? 'In stock' : 'Out of stock',
                  style: TextStyle(
                    color: (product.inStock ?? false)
                        ? Colors.green.shade500
                        : Colors.red.shade500,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                iconColor: (product.inStock ?? false)
                    ? Colors.green.shade600
                    : Colors.red.shade600,
                isDarkMode: isDarkMode,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSellerInfo(ProductsViewsModel product, bool isDarkMode) {
    return FadeTransition(
      opacity: _fadeAnimation ?? AlwaysStoppedAnimation(1.0),
      child: SlideTransition(
        position: _slideAnimation ?? AlwaysStoppedAnimation(Offset.zero),
        child: Row(
          children: [
            Expanded(
              child: _InfoCard(
                icon: Icons.storefront,
                label: "Ships From",
                value: product.shipsFrom,
                backgroundColor:
                    isDarkMode ? Colors.grey[800]! : Colors.grey.shade200,
                isDarkMode: isDarkMode,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _InfoCard(
                icon: Icons.shopping_cart,
                label: "Sold By",
                value: product.soldBy,
                backgroundColor:
                    isDarkMode ? Colors.grey[800]! : Colors.grey.shade200,
                isDarkMode: isDarkMode,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureBox(List<Widget> children, bool isDarkMode) {
    return FadeTransition(
      opacity: _fadeAnimation ?? AlwaysStoppedAnimation(1.0),
      child: SlideTransition(
        position: _slideAnimation ?? AlwaysStoppedAnimation(Offset.zero),
        child: Container(
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey[800] : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(children: children),
        ),
      ),
    );
  }

  Widget _infoRow(
    IconData icon,
    Widget content, {
    Color? iconColor,
    required bool isDarkMode,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon,
            color: iconColor ?? (isDarkMode ? Colors.white70 : Colors.black54),
            size: 20),
        const SizedBox(width: 8),
        Expanded(child: content),
      ],
    );
  }

  Widget _buildSectionTitle(String title, bool isDarkMode) {
    return SlideTransition(
      position: _slideAnimation ?? AlwaysStoppedAnimation(Offset.zero),
      child: FadeTransition(
        opacity: _fadeAnimation ?? AlwaysStoppedAnimation(1.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            title,
            style: TextStyles.bold16.copyWith(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductFeatureRow extends StatelessWidget {
  final String label;
  final String? value;
  final bool isDarkMode;

  const _ProductFeatureRow({
    required this.label,
    required this.value,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    if (value == null || value!.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: TextStyles.bold13.copyWith(
              color: isDarkMode ? Colors.white70 : Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value!,
              style: TextStyles.regular13.copyWith(
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final Color backgroundColor;
  final bool isDarkMode;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.backgroundColor,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    if (value == null || value!.isEmpty) return const SizedBox.shrink();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(icon, color: isDarkMode ? Colors.white70 : Colors.black54),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyles.bold13.copyWith(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value!,
                    style: TextStyles.regular13.copyWith(
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
