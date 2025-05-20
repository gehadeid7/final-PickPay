import 'package:flutter/material.dart';

class SubAppliancesCard extends StatefulWidget {
  final String imagePath;
  final String productName;
  final int index;
  final VoidCallback onTap;

  const SubAppliancesCard({
    super.key,
    required this.imagePath,
    required this.productName,
    required this.index,
    required this.onTap,
  });

  @override
  State<SubAppliancesCard> createState() => _SubAppliancesCard();
}

class _SubAppliancesCard extends State<SubAppliancesCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _alignmentAnimation;

  static const List<List<Color>> _gradientColorsLight = [
    [Color(0xFFA8DADC), Color(0xFF457B9D)], // Soft cyan to muted blue
    [Color(0xFFF1FAEE), Color(0xFFA8DADC)], // Very light mint to soft cyan
    [Color(0xFFD4ECDD), Color(0xFF8FB9A8)], // Pale green to sage green
  ];

  static const List<List<Color>> _gradientColorsDark = [
    [Color(0xFF1D3557), Color(0xFF457B9D)], // Deep navy to muted blue
    [Color(0xFF2A3A40), Color(0xFF5C6B73)], // Dark slate to dusty grey-blue
    [Color(0xFF36454F), Color(0xFF576F72)], // Charcoal to teal-grey
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
