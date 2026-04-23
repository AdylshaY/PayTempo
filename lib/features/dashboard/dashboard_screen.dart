import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    required this.baseCurrency,
    super.key,
  });

  final String baseCurrency;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('PayTempo'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.sm),
            Text('Dashboard', style: textTheme.headlineMedium),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Ana para birimi: $baseCurrency',
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bu Ayki Toplam Harcama', style: textTheme.titleMedium),
                    const SizedBox(height: AppSpacing.xs),
                    Text('$baseCurrency 0.00', style: textTheme.displayLarge),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
