import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';

class InfoBannerWidget extends StatelessWidget {
  const InfoBannerWidget({
    required this.icon,
    required this.accentColor,
    this.message,
    this.child,
    super.key,
  }) : assert(message != null || child != null, 'Either message or child must be provided');

  final IconData icon;
  final Color accentColor;
  final String? message;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.16),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.sm,
        children: [
          Icon(
            icon,
            color: accentColor,
            size: 24,
          ),
          Expanded(
            child: child ??
                Text(
                  message!,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface,
                    height: 1.4,
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
