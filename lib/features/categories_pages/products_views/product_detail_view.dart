import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/core/widgets/custom_button.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/product_rating.dart';
import 'package:pickpay/features/home/domain/models/cart_item_model.dart';
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
          // Main content wrapped in SingleChildScrollView
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 📷 Image Carousel
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox(
                    height: 260,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: product.imagePaths.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          product.imagePaths[index],
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
                    count: product.imagePaths.length,
                    effect: const WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: Colors.blueAccent,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Price & Rating Card with gray background
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                  color: Colors.grey.shade200, // Gray background for price
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("EGP ${product.price.toStringAsFixed(2)}",
                                style: TextStyles.bold19.copyWith(
                                    color: Colors.green.shade700,
                                    fontSize: 22)),
                            ProductRating(
                              rating: product.rating,
                              reviewCount: product.reviewCount,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "List price: EGP ${product.originalPrice.toStringAsFixed(2)}",
                          style: TextStyles.regular13.copyWith(
                              color: Colors.red,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 🧾 Product Features
                _buildSectionTitle("Product Details"),
                Container(
                  decoration: _lightCardBox(),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
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
                          label: "Access Location",
                          value: product.accessLocation),
                      _ProductFeatureRow(
                          label: "Settings Count",
                          value: product.settingsCount.toString()),
                      _ProductFeatureRow(
                          label: "Power Source", value: product.powerSource),
                      _ProductFeatureRow(
                          label: "Manufacturer", value: product.manufacturer),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // 📋 About This Item
                _buildSectionTitle("About this item"),
                Text(product.description, style: TextStyles.regular13),

                const SizedBox(height: 20),

                // 🚚 Delivery Info
                _buildSectionTitle("Delivery"),
                _infoRow(
                    Icons.local_shipping_outlined,
                    RichText(
                      text: TextSpan(
                        style:
                            TextStyles.regular13.copyWith(color: Colors.black),
                        children: [
                          const TextSpan(
                              text: 'FREE Delivery ',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: '${product.deliveryDate} order\nwithin '),
                          TextSpan(
                            text: product.deliveryTimeLeft,
                            style: const TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                    )),

                const SizedBox(height: 8),

                // 📍 Deliver To
                _infoRow(
                    Icons.location_on_outlined,
                    RichText(
                      text: TextSpan(
                        style:
                            TextStyles.regular13.copyWith(color: Colors.black),
                        children: [
                          const TextSpan(text: 'Deliver to '),
                          TextSpan(
                            text: product.deliveryLocation,
                            style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),

                const SizedBox(height: 8),

                // 🟢 Stock Status
                _infoRow(
                  product.inStock ? Icons.check_circle : Icons.cancel,
                  Text(
                    product.inStock ? 'In stock' : 'Out of stock',
                    style: TextStyle(
                      color: product.inStock ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  iconColor: product.inStock ? Colors.green : Colors.red,
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 95, // Set max height for consistency
                        ),
                        child: _InfoCard(
                          icon: Icons.storefront,
                          label: "Ships From",
                          value: product.shipsFrom,
                          backgroundColor: Colors.grey.shade200,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight:
                              95, // Ensure same max height for both cards
                        ),
                        child: _InfoCard(
                          icon: Icons.shopping_cart,
                          label: "Sold By",
                          value: product.soldBy,
                          backgroundColor: Colors.grey.shade200,
                        ),
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
              onPressed: () {},
              buttonText: "Add to Cart",
            )),
          ),
        ],
      ),
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

  BoxDecoration _lightCardBox() {
    return BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
    );
  }
}

class _ProductFeatureRow extends StatelessWidget {
  final String label;
  final String value;

  const _ProductFeatureRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label: ", style: TextStyles.bold13),
          Expanded(child: Text(value, style: TextStyles.regular13)),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color backgroundColor; // New parameter for background color

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
    this.backgroundColor = Colors.white, // Default background color
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      color: backgroundColor, // Use the passed background color
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
                  Text(value, style: TextStyles.regular13),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

CartItemModel _convertToCartItemModel(ProductsViewsModel product) {
  return CartItemModel(
    id: product.id,
    title: product.title,
    price: product.price,
    imagePath: product.imagePaths.isNotEmpty
        ? product.imagePaths.first
        : '', // Take the first image path
    quantity: 1, // Default quantity to 1
  );
}
