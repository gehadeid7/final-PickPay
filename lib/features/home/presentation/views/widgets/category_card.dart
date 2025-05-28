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
    [Color(0xFFE1F0FF), Color(0xFFB3DAF1)], // Gentle blue sky
    [Color(0xFFB3DAF1), Color(0xFF8EC5E8)], // Calm lake blue
    [Color(0xFF8EC5E8), Color(0xFF6FB1E1)], // Refreshing blue
    [Color(0xFF6FB1E1), Color(0xFF56A0DA)], // Soft aqua
    [Color(0xFF56A0DA), Color(0xFF3F90D3)], // Light steel blue
    [Color(0xFF3F90D3), Color(0xFF2F7FC2)], // Balanced sky blue
  ];

  static const List<List<Color>> _gradientColorsDark = [
    [Color(0xFF1C2C3D), Color(0xFF24405C)], // Calm dusk
    [Color(0xFF24405C), Color(0xFF2E5679)], // Deeper blue focus
    [Color(0xFF2E5679), Color(0xFF3A6E99)], // Subtle steel
    [Color(0xFF3A6E99), Color(0xFF4A80AC)], // Deep sky tone
    [Color(0xFF4A80AC), Color(0xFF5C92BE)], // Ocean clarity
    [Color(0xFF5C92BE), Color(0xFF6CA5D1)], // Evening calm
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
