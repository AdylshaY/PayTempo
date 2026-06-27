import 'package:flutter/material.dart';

class FeatureRowWidget extends StatelessWidget {
  const FeatureRowWidget({
    required this.icon,
    required this.text,
    this.iconColor,
    super.key,
  });

  final IconData icon;
  final String text;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveIconColor = iconColor ?? theme.colorScheme.onSurface.withValues(alpha: 0.5);

    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: effectiveIconColor,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
