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
    this.category,
    this.onTap,
  });

  final String id;
  final String name;
  final List<String> imagePaths;
  final double price;
  final double originalPrice;
  final double rating;
  final int reviewCount;
  final String? category;
  final VoidCallback? onTap;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late final PageController _pageController;
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnimation;
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    int fullStars = widget.rating.floor();
    bool hasHalfStar = (widget.rating - fullStars) >= 0.5;
    double discountPercentage = widget.originalPrice > 0
        ? ((widget.originalPrice - widget.price) / widget.originalPrice * 100)
            .round()
            .toDouble()
        : 0;

    return MouseRegion(
      onEnter: (_) => setState(() {
        _isHovered = true;
        _scaleController.forward();
      }),
      onExit: (_) => setState(() {
        _isHovered = false;
        _scaleController.reverse();
      }),
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => _scaleController.forward(),
        onTapUp: (_) => _scaleController.reverse(),
        onTapCancel: () => _scaleController.reverse(),
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey.shade900 : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode
                          ? Colors.black.withOpacity(_isHovered ? 0.3 : 0.2)
                          : Color(0xFFE0E0E0)
                              .withOpacity(_isHovered ? 0.4 : 0.2),
                      blurRadius: _isHovered ? 15 : 10,
                      offset: Offset(0, _isHovered ? 5 : 3),
                      spreadRadius: _isHovered ? 1 : 0,
                    ),
                    if (!isDarkMode && _isHovered)
                      BoxShadow(
                        color: colorScheme.primary.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                        spreadRadius: 2,
                      ),
                  ],
                  border: Border.all(
                    color: isDarkMode
                        ? Colors.grey.shade800
                        : _isHovered
                            ? Color(0xFFEEEEEE)
                            : Color(0xFFF5F5F5),
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image and Discount Badge
                    AspectRatio(
                      aspectRatio: 1,
                      child: Stack(
                        children: [
                          // Image Container
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16)),
                            child: Container(
                              color: isDarkMode
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade50,
                              child: PageView.builder(
                                controller: _pageController,
                                onPageChanged: (index) =>
                                    setState(() => _currentImageIndex = index),
                                itemCount: widget.imagePaths.length,
                                itemBuilder: (context, index) {
                                  return AnimatedOpacity(
                                    duration: const Duration(milliseconds: 200),
                                    opacity: _isHovered ? 1.0 : 0.95,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Hero(
                                        tag: '${widget.id}_image_$index',
                                        child: Image.asset(
                                          widget.imagePaths[index],
                                          fit: BoxFit.contain,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Icon(
                                            Icons.image_not_supported,
                                            color: colorScheme.onSurface
                                                .withOpacity(0.3),
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          // Discount Badge
                          if (discountPercentage > 0)
                            Positioned(
                              top: 12,
                              right: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade500,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.red.shade400.withOpacity(0.15),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  '-${discountPercentage.toInt()}%',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          // Page Indicator
                          if (widget.imagePaths.length > 1)
                            Positioned(
                              bottom: 8,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  widget.imagePaths.length,
                                  (index) => Container(
                                    width: 6,
                                    height: 6,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _currentImageIndex == index
                                          ? isDarkMode
                                              ? Colors.white
                                              : colorScheme.primary
                                          : (isDarkMode
                                                  ? Colors.white
                                                  : Color(0xFFBDBDBD))
                                              .withOpacity(0.3),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Product Details
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Name
                          Text(
                            widget.name,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: isDarkMode
                                  ? Colors.white
                                  : Colors.grey.shade800,
                              fontSize: 13,
                              height: 1.2,
                              letterSpacing: -0.1,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),

                          // Price Row
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '\$${widget.price.toStringAsFixed(2)}',
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode
                                      ? Colors.blue
                                      : Color(0xFF1E88E5),
                                  fontSize: 15,
                                  height: 1.1,
                                  letterSpacing: -0.2,
                                ),
                              ),
                              const SizedBox(width: 4),
                              if (widget.originalPrice > widget.price)
                                Expanded(
                                  child: Text(
                                    '\$${widget.originalPrice.toStringAsFixed(2)}',
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: isDarkMode
                                          ? Colors.grey
                                          : Color(0xFF9E9E9E),
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 11,
                                      height: 1.1,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 2),

                          // Rating Row with Animation
                          TweenAnimationBuilder<double>(
                            duration: const Duration(milliseconds: 300),
                            tween: Tween<double>(
                              begin: 0,
                              end: widget.rating,
                            ),
                            builder: (context, value, child) {
                              return Row(
                                children: [
                                  Row(
                                    children: [
                                      for (int i = 0; i < 5; i++)
                                        Icon(
                                          i < value
                                              ? Icons.star_rounded
                                              : i < value + 0.5 && i >= value
                                                  ? Icons.star_half_rounded
                                                  : Icons.star_border_rounded,
                                          color: Colors.amber.shade500,
                                          size: 13,
                                        ),
                                    ],
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    '(${widget.reviewCount})',
                                    style: textTheme.bodySmall?.copyWith(
                                      color: isDarkMode
                                          ? Colors.grey
                                          : Color(0xFF757575),
                                      fontSize: 10,
                                      height: 1.1,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
