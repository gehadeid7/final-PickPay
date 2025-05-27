import 'package:flutter/material.dart';

class SubvideoCard extends StatefulWidget {
  final String imagePath;
  final String productName;
  final int index;
  final VoidCallback onTap;

  const SubvideoCard({
    super.key,
    required this.imagePath,
    required this.productName,
    required this.index,
    required this.onTap,
  });

  @override
  State<SubvideoCard> createState() => _SubvideoCard();
}

class _SubvideoCard extends State<SubvideoCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _alignmentAnimation;

  static const List<List<Color>> _gradientColorsLight = [
    [Color(0xFFE1BEE7), Color(0xFFBA68C8)], // Soft lavender to light purple
    [Color(0xFFD05CEE), Color(0xFF9C27B0)], // Bright violet to deep purple
    [Color(0xFFB39DDB), Color(0xFF7E57C2)], // Muted periwinkle to medium purple
  ];

  static const List<List<Color>> _gradientColorsDark = [
    [Color(0xFF4A148C), Color(0xFF7B1FA2)], // Deep purple to rich purple
    [Color(0xFF311B92), Color(0xFF512DA8)], // Dark indigo to muted violet
    [
      Color(0xFFAA00FF),
      Color(0xFF6200EA)
    ], // Vibrant purple to deep electric purple
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
      onTap: widget.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  return Container(
                    height: 120,
                    width: 120,
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
                        ),
                      ],
                    ),
                  );
                },
              ),
              Positioned(
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 130,
                  width: 140,
                  child: Image.asset(
                    widget.imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            toTitleCase(widget.productName),
            textAlign: TextAlign.center,
            style: theme.textTheme.labelLarge?.copyWith(
              color: isDark ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 15,
              letterSpacing: .9,
            ),
          ),
        ],
      ),
    );
  }
}
