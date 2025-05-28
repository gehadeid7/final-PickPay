import 'package:flutter/material.dart';

class AnimatedSubcategoryCard extends StatefulWidget {
  final String name;
  final String imagePath;
  final VoidCallback onTap;
  final int index;

  const AnimatedSubcategoryCard({
    super.key,
    required this.name,
    required this.imagePath,
    required this.onTap,
    required this.index,
  });

  @override
  State<AnimatedSubcategoryCard> createState() =>
      _AnimatedSubcategoryCardState();
}

class _AnimatedSubcategoryCardState extends State<AnimatedSubcategoryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _alignmentAnimation;
  bool _isHovered = false;
  static const List<List<Color>> _gradientColorsLight = [
    [
      Color(0xFF9EC1D9),
      Color(0xFF7A9BCB)
    ], // Soft sky blue to muted cornflower blue (mobile)
    [
      Color(0xFFB3CAED),
      Color(0xFF8DB4F3)
    ], // Light powder blue to pastel blue (tvs)
    [
      Color(0xFF9EC1D9),
      Color(0xFF7A9BCB)
    ], // Soft sky blue to muted cornflower blue (laptop)
    [
      Color(0xFF90B6B6),
      Color(0xFF78A5A5)
    ], // Pale teal to seafoam green (large appliances)
    [
      Color(0xFF90B6B6),
      Color(0xFF78A5A5)
    ], // Pale teal to seafoam green (small appliances)
    [
      Color(0xFFBDBDBD),
      Color(0xFFA0A0A0)
    ], // Light gray to medium gray (furniture)
    [
      Color(0xFF7A8B8E),
      Color(0xFF5B6B6E)
    ], // Slate gray to steel blue (home decor)
    [
      Color(0xFF6E7582),
      Color(0xFF55606C)
    ], // Light indigo-gray to charcoal steel (bath)
    [
      Color(0xFF6B6B6B),
      Color(0xFF4E4E4E)
    ], // Medium gray to dark slate gray (kitchen)

    [
      Color(0xFFD7B89E),
      Color(0xFFB88C72)
    ], // Warm caramel to light mocha (women's fashion)
    [
      Color(0xFFB58873),
      Color(0xFF9A6E57)
    ], // Soft brown to chocolate tan (men's fashion)
    [
      Color(0xFFA47B65),
      Color(0xFF86624B)
    ], // Light espresso to warm cocoa (kids' fashion)

    [
      Color(0xFFFFF0F3),
      Color(0xFFF5C6D1)
    ], // Very light pink to soft blush (makeup)
    [
      Color(0xFFFFF5F9),
      Color(0xFFF5C6D1)
    ], // Pale pink mist to gentle blush (skincare)
    [
      Color(0xFFF9C5D3),
      Color(0xFFF59BB3)
    ], // Soft blush to warm pink (haircare)
    [
      Color(0xFFFADFE1),
      Color(0xFFF7C5C9)
    ], // Pale pink to cotton rose (fragrance)

    [
      Color(0xFF8C6FCA),
      Color(0xFFA78AD7)
    ], // Light eggplant purple to soft violet (consoles)
    [
      Color(0xFFA183D0),
      Color(0xFFC38FDB)
    ], // Medium violet to gentle purple (controllers)
    [
      Color(0xFF9B7BCF),
      Color(0xFFBEA2DD)
    ], // Soft strong purple to light violet (accessories)
  ];

  static const List<List<Color>> _gradientColorsDark = [
    [Color(0xFF254E7A), Color(0xFF3A639A)], // Royal navy to soft denim (mobile)
    [Color(0xFF2E5D9F), Color(0xFF4B7ACD)], // Medium blue to pastel blue (tvs)
    [Color(0xFF254E7A), Color(0xFF3A639A)], // Royal navy to soft denim (laptop)
    [
      Color(0xFF2E4F4F),
      Color(0xFF416D6D)
    ], // Deep teal to soft sea green (large appliances)
    [
      Color(0xFF3B6060),
      Color(0xFF557E7E)
    ], // Dark slate teal to muted turquoise (small appliances)
    [
      Color(0xFF424242),
      Color(0xFF757575)
    ], // Cool dark grey to medium grey (furniture)
    [
      Color(0xFF263238),
      Color(0xFF455A64)
    ], // Blue-grey dark to steel (original reused) (home decor)
    [
      Color(0xFF1C1C2D),
      Color(0xFF36454F)
    ], // Indigo-graphite to charcoal steel (bath)
    [
      Color(0xFF121212),
      Color(0xFF3D3D3D)
    ], // Pitch black to slate grey (kitchen)

    [
      Color(0xFF6D4C41),
      Color(0xFF8D6E63)
    ], // Cocoa brown to soft mocha (women's fashion)
    [
      Color(0xFF5D4037),
      Color(0xFF795548)
    ], // Dark chocolate to medium brown (men's fashion)
    [
      Color(0xFF4E342E),
      Color(0xFF6D4C41)
    ], // Espresso brown to cocoa (kids'fashion)

    [
      Color(0xFFFFEBEE),
      Color(0xFFF8BBD0)
    ], // Very light pink to soft blush (makeup)
    [
      Color(0xFFFCE4EC),
      Color(0xFFF8BBD0)
    ], // Lightest pink mist to gentle blush  (skincare)
    [
      Color(0xFFF8BBD0),
      Color(0xFFF48FB1)
    ], // Soft blush to warm pink (haircare)
    [
      Color(0xFFFADADD),
      Color(0xFFF5C2C7)
    ], // Pale pink to cotton rose (fragrance)

    [
      Color(0xFF4527A0),
      Color(0xFF7E57C2)
    ], // Eggplant purple to soft violet (consoles)
    [Color(0xFF5E35B1), Color(0xFF9C27B0)], // Violet blend (controllers)
    [
      Color(0xFF4A148C),
      Color(0xFF9575CD)
    ], // Strong purple to light violet (accesories)
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

  List<Color> _getGradientColors(bool isDark, int index) {
    final colors = isDark ? _gradientColorsDark : _gradientColorsLight;
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final gradientColors = _getGradientColors(isDark, widget.index);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: _alignmentAnimation.value,
                  end: Alignment.center,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withOpacity(0.6)
                        : Colors.grey.withOpacity(0.2),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: widget.imagePath,
                      child: Image.asset(
                        widget.imagePath,
                        fit: BoxFit.contain,
                      ),
                    ),
                    // Subtle gradient overlay for depth
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.4),
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black.withOpacity(0.1),
                          ],
                          stops: const [0.0, 0.3, 0.7, 1.0],
                        ),
                      ),
                    ),
                    // Subtle vignette effect
                    Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment.center,
                          radius: 1.2,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.15),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 8,
                        ),
                        constraints: const BoxConstraints(
                          minHeight:
                              36, // Set a minimum height that fits one line well
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              gradientColors[1].withOpacity(0.95),
                              gradientColors[0].withOpacity(0.8),
                            ],
                          ),
                        ),
                        child: Text(
                          widget.name.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                            shadows: [
                              Shadow(
                                blurRadius: 4,
                                color: Colors.black.withOpacity(0.5),
                                offset: const Offset(1, 1),
                              ),
                            ],
                          ),
                        ),
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
