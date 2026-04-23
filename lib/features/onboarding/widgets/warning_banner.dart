import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';

class WarningBanner extends StatelessWidget {
  const WarningBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadii.button),
        color: AppColors.warning.withValues(alpha: 0.12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.sm,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: AppColors.warning,
            size: 32,
          ),
          Expanded(
            child: Text(
              'Warning: This selection cannot be changed later. Please choose carefully.',
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}
