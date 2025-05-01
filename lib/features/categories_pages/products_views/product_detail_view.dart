import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/core/widgets/custom_button.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/product_rating.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(product.name, style: TextStyles.bold16),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Carousel
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: 250,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: product.imagePaths.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      product.imagePaths[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),

            Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: product.imagePaths.length,
                effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: Colors.blueAccent,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Price & Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "EGP ${product.price.toStringAsFixed(2)}",
                  style: TextStyles.bold19
                      .copyWith(color: Colors.green, fontSize: 22),
                ),
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
                decoration: TextDecoration.lineThrough,
              ),
            ),
            const SizedBox(height: 20),

            // Features Section
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _ProductFeatureRow(label: "Brand", value: product.brand),
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
                      label: "Number of Settings",
                      value: product.settingsCount.toString()),
                  _ProductFeatureRow(
                      label: "Power Source", value: product.powerSource),
                  _ProductFeatureRow(
                      label: "Manufacturer", value: product.manufacturer),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Description
            Text("About this item", style: TextStyles.bold16),
            const SizedBox(height: 6),
            Text(product.description, style: TextStyles.regular13),

            const SizedBox(height: 30),

            // Add to Cart Button
            Center(
              child: CustomButton(
                onPressed: () {
                  // Handle add to cart
                  print("Add to Cart Pressed");
                },
                buttonText: "🛒 Add to Cart",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductFeatureRow extends StatelessWidget {
  final String label;
  final String value;

  const _ProductFeatureRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label: ", style: TextStyles.bold13),
          Expanded(
            child: Text(value, style: TextStyles.regular13),
          ),
        ],
      ),
    );
  }
}
