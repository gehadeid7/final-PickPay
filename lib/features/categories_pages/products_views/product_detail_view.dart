import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/core/widgets/custom_button.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/product_rating.dart';

class ProductDetailView extends StatelessWidget {
  final ProductsViewsModel product;

  const ProductDetailView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(product.name, style: TextStyles.regular16),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Carousel
            SizedBox(
              height: 250,
              child: PageView.builder(
                itemCount: product.imagePaths.length,
                itemBuilder: (context, index) {
                  return Image.asset(product.imagePaths[index]);
                },
              ),
            ),
            const SizedBox(height: 12),

            // Price & Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("EGP ${product.price.toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                ProductRating(
                  rating: product.rating,
                  reviewCount: product.reviewCount,
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text("List price: EGP ${product.originalPrice.toStringAsFixed(2)}",
                style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey)),
            const SizedBox(height: 20),

            // Feature Details
            _ProductFeatureRow(label: "Brand", value: product.brand),
            _ProductFeatureRow(label: "Color", value: product.color),
            _ProductFeatureRow(label: "Material", value: product.material),
            _ProductFeatureRow(label: "Dimensions", value: product.dimensions),
            _ProductFeatureRow(label: "Style", value: product.style),
            _ProductFeatureRow(
                label: "Installation Type", value: product.installationType),
            _ProductFeatureRow(
                label: "Access Location", value: product.accessLocation),
            _ProductFeatureRow(
                label: "Number of Settings",
                value: product.settingsCount.toString()),
            _ProductFeatureRow(
                label: "Power Source", value: product.powerSource),
            _ProductFeatureRow(
                label: "Manufacturer", value: product.manufacturer),
            const SizedBox(height: 12),

            // Description
            const Text("About this item",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 6),
            Text(product.description, style: const TextStyle(fontSize: 14)),

            const SizedBox(height: 20),

            // Custom Button
            CustomButton(
              onPressed: () {
                // Handle the button press here
                print("Button Pressed");
              },
              buttonText: "Add to Cart", // Change button text as needed
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
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text("$label: ", style: TextStyles.bold16),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
