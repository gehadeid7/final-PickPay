import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.id,
    required this.name,
    required this.imagePaths,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.reviewCount,
    this.onTap,
  });

  final String id;
  final String name;
  final List<String> imagePaths;
  final double price;
  final double originalPrice;
  final double rating;
  final int reviewCount;
  final VoidCallback? onTap;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<Alignment>? _alignmentAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _alignmentAnimation = Tween<Alignment>(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final List<Color> gradientColors = isDarkMode
        ? [
            const Color.fromARGB(255, 23, 23, 23),
            const Color.fromARGB(255, 68, 68, 70),
            const Color.fromARGB(255, 51, 51, 52),
          ]
        : [
            const Color(0xFFFFFFFF),
            const Color(0xFFF2F2F7),
            const Color(0xFFE5E5EA),
          ];

    int fullStars = widget.rating.floor();
    bool hasHalfStar = (widget.rating - fullStars) >= 0.5;

    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: gradientColors,
                begin: _alignmentAnimation?.value ?? Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withAlpha((0.12 * 255).toInt()),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
              border: Border.all(
                color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 180,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      color: isDarkMode
                          ? Colors.grey.shade800
                          : Colors.grey.shade200,
                      child: PageView.builder(
                        itemCount: widget.imagePaths.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(12),
                            child: Image.asset(
                              widget.imagePaths[index],
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                Icons.image_not_supported,
                                color: colorScheme.onSurface.withOpacity(0.3),
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

                // Product Name
                Text(
                  widget.name,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? colorScheme.onSurface : Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                // Price and Original Price
                Row(
                  children: [
                    Text(
                      '\$${widget.price.toStringAsFixed(2)}',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                    const SizedBox(width: 12),
                    if (widget.originalPrice > widget.price)
                      Text(
                        '\$${widget.originalPrice.toStringAsFixed(2)}',
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.red.shade600,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),

                // Ratings (stars) and Review Count only
                Row(
                  children: [
                    // Full stars
                    for (int i = 0; i < fullStars; i++)
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                    // Half star
                    if (hasHalfStar)
                      const Icon(Icons.star_half,
                          color: Colors.amber, size: 16),
                    // Empty stars
                    for (int i = 0;
                        i < (5 - fullStars - (hasHalfStar ? 1 : 0));
                        i++)
                      const Icon(Icons.star_border,
                          color: Colors.amber, size: 16),
                    const SizedBox(width: 8),
                    // Review count only, no numeric rating
                    Text(
                      '(${widget.reviewCount})',
                      style: textTheme.bodySmall?.copyWith(
                        color: isDarkMode
                            ? colorScheme.onSurface.withOpacity(0.5)
                            : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
