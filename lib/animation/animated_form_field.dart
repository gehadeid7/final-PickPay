import 'package:flutter/material.dart';

class AnimatedFormField extends StatelessWidget {
  const AnimatedFormField({
    super.key,
    required this.animation,
    required this.delay,
    required this.child,
  });

  final AnimationController animation;
  final double delay;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animation,
        curve: Interval(delay, 1.0, curve: Curves.easeOut),
      ),
    );

    final translateAnimation = Tween<double>(begin: 20, end: 0).animate(
      CurvedAnimation(
        parent: animation,
        curve: Interval(delay, 1.0, curve: Curves.easeOut),
      ),
    );

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Opacity(
          opacity: opacityAnimation.value,
          child: Transform.translate(
            offset: Offset(0, translateAnimation.value),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
