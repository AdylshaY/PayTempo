import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';

class MonthlySpendingCardWidget extends StatelessWidget {
  const MonthlySpendingCardWidget({
    required this.baseCurrency,
    super.key,
  });

  final String baseCurrency;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Spending This Month',
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '$baseCurrency 0.00',
              style: textTheme.displayLarge,
            ),
          ],
        ),
      ),
    );
  }
}