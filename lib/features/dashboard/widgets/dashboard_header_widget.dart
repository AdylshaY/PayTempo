import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';

class DashboardHeaderWidget extends StatelessWidget {
  const DashboardHeaderWidget({
    required this.baseCurrency,
    super.key,
  });

  final String baseCurrency;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Dashboard', style: textTheme.headlineMedium),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Base currency: $baseCurrency',
          style: textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}