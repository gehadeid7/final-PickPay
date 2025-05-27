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
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Hero(
                        tag: widget.imagePath,
                        child: Image.asset(
                          widget.imagePath,
                          fit: BoxFit.contain,
                        ),
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
                          vertical: 12,
                          horizontal: 12,
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
