import 'package:flutter/material.dart';

class IconCircleWidget extends StatelessWidget {
  const IconCircleWidget({
    required this.icon,
    required this.size,
    this.color,
    super.key,
  });

  final IconData icon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final Color effectiveColor = color ?? Theme.of(context).colorScheme.primary;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: effectiveColor.withValues(alpha: 0.08),
        shape: BoxShape.circle,
        border: Border.all(
          color: effectiveColor.withValues(alpha: 0.16),
          width: 2,
        ),
      ),
      child: Icon(
        icon,
        color: effectiveColor,
        size: size * 0.45,
      ),
    );
  }
}
