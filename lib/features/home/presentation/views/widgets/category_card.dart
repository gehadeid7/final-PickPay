import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  final String imagePath;
  final String categoryName;
  final int index;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.imagePath,
    required this.categoryName,
    required this.index,
    required this.onTap,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _alignmentAnimation;
  bool _isPressed = false;

  static const List<List<Color>> _gradientColorsLight = [
    [Color(0xFFA8DADC), Color(0xFF457B9D)], // Soft cyan to muted blue
    [Color(0xFFF1FAEE), Color(0xFFA8DADC)], // Very light mint to soft cyan
    [Color(0xFFEAEAEA), Color(0xFFB0BEC5)], // Light grey to cool steel blue
    [Color(0xFFD4ECDD), Color(0xFF8FB9A8)], // Pale green to sage green
    [Color(0xFFF9F7F7), Color(0xFFD3C0CD)], // Soft off-white to muted mauve
    [Color(0xFFF4E1D2), Color(0xFFBC9CA3)], // Light peach to dusty rose
  ];

  static const List<List<Color>> _gradientColorsDark = [
    [Color(0xFF1D3557), Color(0xFF457B9D)], // Deep navy to muted blue
    [Color(0xFF2A3A40), Color(0xFF5C6B73)], // Dark slate to dusty grey-blue
    [Color(0xFF36454F), Color(0xFF576F72)], // Charcoal to teal-grey
    [Color(0xFF3B3A40), Color(0xFF6D7B8D)], // Dark charcoal to muted blue-grey
    [Color(0xFF5C4D7D), Color(0xFF7E6A9E)], // Dusty purple to lavender-grey
    [Color(0xFF4B474A), Color(0xFF7E7A82)], // Dark grey to soft lavender-grey
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);

    _alignmentAnimation = Tween<Alignment>(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Color> _getGradientColors(bool isDarkMode, int index) {
    final colors = isDarkMode ? _gradientColorsDark : _gradientColorsLight;
    return colors[index % colors.length];
  }

  String toTitleCase(String text) {
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final gradientColors = _getGradientColors(isDark, widget.index);

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: SizedBox(
            height: 125,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, _) {
                        return Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: gradientColors,
                              begin: _alignmentAnimation.value,
                              end: Alignment.center,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isDark
                                    ? Colors.black.withAlpha(102)
                                    : Colors.grey.withAlpha(38),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      child: Hero(
                        tag: 'category_${widget.categoryName}',
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          height: 95,
                          width: 95,
                          transform: Matrix4.identity()
                            ..translate(
                              0.0,
                              _isPressed ? 2.0 : 0.0,
                              0.0,
                            ),
                          child: Image.asset(
                            widget.imagePath,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  toTitleCase(widget.categoryName),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: isDark ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    letterSpacing: 0.3,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
