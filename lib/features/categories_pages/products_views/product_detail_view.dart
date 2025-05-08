import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/core/widgets/custom_button.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/color_option_selector.dart';
import 'package:pickpay/features/categories_pages/widgets/info_icons_row.dart';
import 'package:pickpay/features/categories_pages/widgets/product_rating.dart';
import 'package:pickpay/features/categories_pages/widgets/scent_option.dart';
import 'package:pickpay/features/categories_pages/widgets/size_option.dart';
import 'package:pickpay/features/home/domain/models/cart_item_model.dart';
import 'package:pickpay/features/home/presentation/cubits/cart_cubits/cart_cubit.dart';
import 'package:pickpay/features/home/presentation/views/widgets/wishlist_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailView extends StatefulWidget {
  final ProductsViewsModel product;

  const ProductDetailView({super.key, required this.product});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(product.title, style: TextStyles.bold16),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageSlider(product),
                const SizedBox(height: 24),
                _buildPriceAndRating(product),
                const SizedBox(height: 12),
                InfoSectionWithIcons(),
                const SizedBox(height: 10),
                ColorOptionSelector(
                  colorOptions: product.colorOptions ?? [],
                  colorAvailability: product.colorAvailability,
                  // onColorSelected: (color) => print("Selected color: $color"),
                ),
                ScentOption(
                  scentOption: product.scentOption ?? [],
                  showLabel: true,
                  onScentSelected: (selectedScentName) {
                    debugPrint("Scent: $selectedScentName");
                  },
                ),
                const SizedBox(height: 12),

                SizeOptionSelector(
                  availableSizes: product.availableSizes ?? [],
                  showLabel: true,
                  sizeAvailability: product.sizeAvailability,
                  onSizeSelected: (selectedSize) {
                    debugPrint("Size: $selectedSize");
                  },
                ),
                const SizedBox(height: 20),
                _buildSectionTitle("Product Details"),
                _buildFeatureBox([
                  _ProductFeatureRow(label: "Brand", value: product.brand),
                  _ProductFeatureRow(
                      label: "Category", value: product.category),
                  _ProductFeatureRow(label: "Color", value: product.color),
                  _ProductFeatureRow(
                      label: "Material", value: product.material),
                  _ProductFeatureRow(
                      label: "Dimensions", value: product.dimensions),
                  _ProductFeatureRow(label: "Style", value: product.style),
                  _ProductFeatureRow(
                      label: "Installation Type",
                      value: product.installationType),
                  _ProductFeatureRow(
                      label: "Access Location", value: product.accessLocation),
                  _ProductFeatureRow(
                      label: "Settings Count",
                      value: product.settingsCount?.toString()),
                  _ProductFeatureRow(
                      label: "Power Source", value: product.powerSource),
                  _ProductFeatureRow(
                      label: "Manufacturer", value: product.manufacturer),
                  _ProductFeatureRow(
                      label: "Drawer Type", value: product.drawertype),
                  _ProductFeatureRow(
                      label: "Special Features",
                      value: product.specialfeatures),
                  _ProductFeatureRow(
                      label: "Finish Type", value: product.finishType),
                  _ProductFeatureRow(
                      label: "Model Name", value: product.modelName),
                  _ProductFeatureRow(
                      label: "Form Factor", value: product.formFactor),
                  _ProductFeatureRow(
                      label: "Controls Type", value: product.controlsType),
                  _ProductFeatureRow(
                      label: "Item Weight", value: product.itemWeight),
                  _ProductFeatureRow(
                      label: "Efficiency", value: product.efficiency),
                  _ProductFeatureRow(
                      label: "Mounting Type", value: product.mountingType),
                  _ProductFeatureRow(
                      label: "Capacity", value: product.capacity),
                  _ProductFeatureRow(
                      label: "Technology", value: product.technology),
                  _ProductFeatureRow(
                      label: "Configuration", value: product.configration),
                  _ProductFeatureRow(
                      label: "Energy Efficiency",
                      value: product.energyEfficency),
                  _ProductFeatureRow(
                      label: "Spin Speed", value: product.spinSpeed),
                  _ProductFeatureRow(
                      label: "Model Number", value: product.modelNumber),
                  _ProductFeatureRow(
                      label: "Number of Programs",
                      value: product.numberofprograms),
                  _ProductFeatureRow(
                      label: "Noise Level", value: product.noiselevel),
                  _ProductFeatureRow(
                      label: "Recommended Uses",
                      value: product.recommendedUsesForProduct),
                  _ProductFeatureRow(
                      label: "Output Wattage", value: product.outputWattage),
                  _ProductFeatureRow(label: "Wattage", value: product.wattage),
                  _ProductFeatureRow(
                      label: "Coffee Maker Type",
                      value: product.coffeeMakerType),
                  _ProductFeatureRow(
                      label: "Filter Type", value: product.filtertype),
                  _ProductFeatureRow(
                      label: "Steel Speeds",
                      value: product.stainlessSteelNumberofSpeeds),
                  _ProductFeatureRow(
                      label: "Blade Material", value: product.bladeMaterial),
                  _ProductFeatureRow(
                      label: "Container Type", value: product.containerType),
                  _ProductFeatureRow(label: "Voltage", value: product.voltage),
                  _ProductFeatureRow(
                      label: "Components", value: product.components),
                  _ProductFeatureRow(
                      label: "Power Source", value: product.powersource),
                  _ProductFeatureRow(
                      label: "Pressure", value: product.pressure),
                  _ProductFeatureRow(
                      label: "Max Pressure", value: product.maximumpressure),
                  _ProductFeatureRow(
                      label: "Controller Type", value: product.controllertype),
                  _ProductFeatureRow(
                      label: "Fan Design", value: product.electricFanDesign),
                  _ProductFeatureRow(
                      label: "Room Type", value: product.roomtype),
                  _ProductFeatureRow(label: "Surface", value: product.surface),
                  _ProductFeatureRow(
                      label: "Cordless",
                      value: product.isProductCordless?.toString()),
                  _ProductFeatureRow(
                      label: "Frequency", value: product.frequency),
                  _ProductFeatureRow(
                      label: "Slot Count", value: product.slotcount),
                  _ProductFeatureRow(
                      label: "Product Benefit", value: product.productbenefit),
                  _ProductFeatureRow(
                      label: "Item Form", value: product.itemform),
                  _ProductFeatureRow(
                      label: "Specialty", value: product.specialty),
                  _ProductFeatureRow(
                      label: "Unit Count", value: product.unitcount),
                  _ProductFeatureRow(
                      label: "Number of Items", value: product.numberofitems),
                  _ProductFeatureRow(
                      label: "Skin Type", value: product.skintype),
                  _ProductFeatureRow(
                      label: "Coverage", value: product.coverage),
                  _ProductFeatureRow(
                      label: "Age Range", value: product.ageRangeDescription),
                  _ProductFeatureRow(
                      label: "Special Ingredients",
                      value: product.specialIngredients),
                  _ProductFeatureRow(
                      label: "Active Ingredients",
                      value: product.activeIngredients),
                  _ProductFeatureRow(
                      label: "SPF", value: product.sunProtectionFactor),
                  _ProductFeatureRow(
                      label: "Item Volume", value: product.itemvolume),
                  _ProductFeatureRow(label: "Scent", value: product.scent),
                  _ProductFeatureRow(
                      label: "Target Body Part",
                      value: product.targetUseBodyPart),
                  _ProductFeatureRow(
                      label: "Hair Type", value: product.hairtype),
                  _ProductFeatureRow(
                      label: "Liquid Volume", value: product.liquidVolume),
                  _ProductFeatureRow(
                      label: "Resulting Hair Type",
                      value: product.resultingHairType),
                  _ProductFeatureRow(
                      label: "Material Feature",
                      value: product.materialfeature),
                  _ProductFeatureRow(
                      label: "Fragrance Concentration",
                      value: product.fragranceConcentration),
                  _ProductFeatureRow(
                      label: "Defrost System", value: product.defrostSystem),
                  _ProductFeatureRow(label: "Size", value: product.size),
                  _ProductFeatureRow(
                      label: "Care Instruction",
                      value: product.careInstruction),
                  _ProductFeatureRow(
                      label: "Closure Type", value: product.closureType),
                  _ProductFeatureRow(
                      label: "Sole Material", value: product.soleMaterial),
                  _ProductFeatureRow(
                      label: "Outer Material", value: product.outerMaterial),
                  _ProductFeatureRow(
                      label: "Inner Material", value: product.innerMaterial),
                  _ProductFeatureRow(
                      label: "Water Resistance Level",
                      value: product.waterResistanceLevel),
                  _ProductFeatureRow(
                      label: "Shaft Height", value: product.shaftHeight),
                  _ProductFeatureRow(label: "Lining", value: product.lining),
                  _ProductFeatureRow(
                      label: "Material Composition",
                      value: product.materialcomposition),
                  _ProductFeatureRow(
                      label: "Compatible Devices",
                      value: product.compatibleDevices),
                  _ProductFeatureRow(
                      label: "Controller Type", value: product.controllerType),
                  _ProductFeatureRow(
                      label: "Connectivity Technology",
                      value: product.connectivityTechnology),
                  _ProductFeatureRow(
                      label: "Button Quantity", value: product.buttonQuantity),
                  _ProductFeatureRow(
                      label: "Item Package Quantity",
                      value: product.itemPackageQuantity),
                  _ProductFeatureRow(
                      label: "Hardware Platform",
                      value: product.hardwarePlatform),
                  _ProductFeatureRow(
                      label: "Compatible Phone Models",
                      value: product.compatiblePhoneModels),
                  _ProductFeatureRow(
                      label: "Included Components",
                      value: product.includedComponents),
                  _ProductFeatureRow(
                      label: "Input Voltage", value: product.inputVoltage),
                  _ProductFeatureRow(
                      label: "Digital Storage Capacity",
                      value: product.digitalStorageCapacity),
                  _ProductFeatureRow(
                      label: "Hard Disk Description",
                      value: product.hardDiskDescription),
                  _ProductFeatureRow(
                      label: "Hard Disk Form Factor",
                      value: product.hardDiskFormFactor),
                  _ProductFeatureRow(
                      label: "Connector Type", value: product.connectorType),
                  _ProductFeatureRow(
                      label: "Pattern Name", value: product.patternName),
                  _ProductFeatureRow(
                      label: "Memory Storage Capacity",
                      value: product.memoryStorageCapacity),
                  _ProductFeatureRow(
                      label: "Screen Size", value: product.screenSize),
                  _ProductFeatureRow(
                      label: "Display Resolution",
                      value: product.displayResolution),
                  _ProductFeatureRow(
                      label: "Operating System",
                      value: product.operatingSystem),
                  _ProductFeatureRow(
                      label: "Ram Memory Installed",
                      value: product.ramMemoryInstalled),
                  _ProductFeatureRow(
                      label: "Generation", value: product.generation),
                  _ProductFeatureRow(
                      label: "Display Resolution Maximum",
                      value: product.displayResolutionMaximum),
                  _ProductFeatureRow(
                      label: "Model Year", value: product.modelYear),
                  _ProductFeatureRow(
                      label: "wireless Provider",
                      value: product.wirelessProvider),
                  _ProductFeatureRow(
                      label: "Cellular Technology",
                      value: product.cellularTechnology),
                  _ProductFeatureRow(
                      label: "wireless Network Technology",
                      value: product.wirelessNetworkTechnology),
                  _ProductFeatureRow(label: "Pattern", value: product.pattern),
                  _ProductFeatureRow(
                      label: "Embellishment Feature",
                      value: product.embellishmentFeature),
                  _ProductFeatureRow(label: "Theme", value: product.theme),
                  _ProductFeatureRow(
                      label: "Resolution", value: product.resolution),
                  _ProductFeatureRow(
                      label: "Refresh Rate", value: product.refreshRate),
                  _ProductFeatureRow(
                      label: "Aspect Ratio", value: product.aspectRatio),
                  _ProductFeatureRow(
                      label: "Display Technology",
                      value: product.displayTechnology),
                  _ProductFeatureRow(
                      label: "Supported Internet Services",
                      value: product.supportedInternetServices),
                  _ProductFeatureRow(
                      label: "Graphics Description",
                      value: product.graphicsDescription),
                  _ProductFeatureRow(
                      label: "CPU Model", value: product.cpuModel),
                  _ProductFeatureRow(
                      label: "CPU Speed", value: product.cpuSpeed),
                  _ProductFeatureRow(
                      label: "Hard Disk Size", value: product.hardDiskSize),
                  _ProductFeatureRow(
                      label: "Printer Technology",
                      value: product.printerTechnology),
                  _ProductFeatureRow(
                      label: "Printer Output", value: product.printerOutput),
                  _ProductFeatureRow(
                      label: "maximum Print Speed (Color)",
                      value: product.maximumPrintSpeedColor),
                  _ProductFeatureRow(
                      label: "Cooling Method", value: product.coolingMethod),
                ]),

                const SizedBox(height: 12),
                // QuantityDropdown(),
                const SizedBox(height: 20),
                _buildSectionTitle("About this item"),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (product.aboutThisItem?.split('\n') ??
                          ['No description available'])
                      .map((line) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Text(line, style: TextStyles.regular13),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 16),
                _buildSectionTitle("Delivery"),
                _infoRow(
                  Icons.local_shipping_outlined,
                  RichText(
                    text: TextSpan(
                      style: TextStyles.regular13.copyWith(color: Colors.black),
                      children: [
                        const TextSpan(
                          text: 'FREE Delivery ',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
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
                ),
                const SizedBox(height: 8),
                _infoRow(
                  Icons.location_on_outlined,
                  RichText(
                    text: TextSpan(
                      style: TextStyles.regular13.copyWith(color: Colors.black),
                      children: [
                        const TextSpan(text: 'Deliver to '),
                        TextSpan(
                          text: product.deliveryLocation ?? 'your location',
                          style: const TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _infoRow(
                  (product.inStock ?? false)
                      ? Icons.check_circle
                      : Icons.cancel,
                  Text(
                    (product.inStock ?? false) ? 'In stock' : 'Out of stock',
                    style: TextStyle(
                      color: (product.inStock ?? false)
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  iconColor:
                      (product.inStock ?? false) ? Colors.green : Colors.red,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _InfoCard(
                        icon: Icons.storefront,
                        label: "Ships From",
                        value: product.shipsFrom,
                        backgroundColor: Colors.grey.shade200,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _InfoCard(
                        icon: Icons.shopping_cart,
                        label: "Sold By",
                        value: product.soldBy,
                        backgroundColor: Colors.grey.shade200,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 16,
            right: 16,
            child: Center(
              child: CustomButton(
                onPressed: () {
                  context.read<CartCubit>().addToCart(
                        CartItemModel(
                          product:
                              product, // ✅ This should be an instance, not the class
                          quantity: 1,
                        ),
                      );
                },
                buttonText: "Add to Cart",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSlider(ProductsViewsModel product) {
    return Stack(
      children: [
        Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: 260,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: product.imagePaths?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      product.imagePaths![index],
                      fit: BoxFit.contain,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: product.imagePaths?.length ?? 0,
                effect: const WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: Colors.blueAccent,
                ),
              ),
            ),
          ],
        ),
        // Add the WishlistButton positioned in the top-right corner
        Positioned(
          top: 8,
          right: 8,
          child: WishlistButton(
            product: product,
            // ignore: deprecated_member_use
            backgroundColor: Colors.grey.shade200.withOpacity(0.8),
            iconSize: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceAndRating(ProductsViewsModel product) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      color: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("EGP ${product.price.toStringAsFixed(2)}",
                    style: TextStyles.bold19
                        .copyWith(color: Colors.green.shade700, fontSize: 22)),
                ProductRating(
                  rating: product.rating ?? 0.0,
                  reviewCount: product.reviewCount ?? 0,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              "List price: EGP ${product.originalPrice?.toStringAsFixed(2) ?? '0.00'}",
              style: TextStyles.regular13.copyWith(
                color: Colors.red,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureBox(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(children: children),
    );
  }

  Widget _infoRow(IconData icon, Widget content,
      {Color iconColor = Colors.black54}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(width: 8),
        Expanded(child: content),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(title, style: TextStyles.bold16),
    );
  }

  // BoxDecoration _lightCardBox() {
  //   return BoxDecoration(
  //     color: Colors.grey.shade100,
  //     borderRadius: BorderRadius.circular(12),
  //   );
  // }
}

class _ProductFeatureRow extends StatelessWidget {
  final String label;
  final String? value;

  const _ProductFeatureRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    if (value == null || value!.isEmpty) return SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label: ", style: TextStyles.bold13),
          Expanded(child: Text(value!, style: TextStyles.regular13)),
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

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    if (value == null || value!.isEmpty) return SizedBox.shrink();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(icon, color: Colors.black54),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: TextStyles.bold13),
                  const SizedBox(height: 4),
                  Text(value!, style: TextStyles.regular13),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
