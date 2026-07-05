import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/app/utils/currency_formatter.dart';
import 'package:pay_tempo/data/local/models/payment_transaction.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class SpendingTrendsCard extends StatelessWidget {
  final List<PaymentTransaction> payments;
  final String baseCurrency;

  const SpendingTrendsCard({
    super.key,
    required this.payments,
    required this.baseCurrency,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final now = DateTime.now();
    final currentMonthStart = DateTime(now.year, now.month, 1);
    final currentMonthEnd = DateTime(now.year, now.month + 1, 1);
    
    // Previous month bounds
    final prevMonthStart = DateTime(now.year, now.month - 1, 1);
    final prevMonthEnd = currentMonthStart;

    final currentMonthPayments = payments.where((tx) =>
        !tx.paidAt.isBefore(currentMonthStart) && tx.paidAt.isBefore(currentMonthEnd)).toList();
    final prevMonthPayments = payments.where((tx) =>
        !tx.paidAt.isBefore(prevMonthStart) && tx.paidAt.isBefore(prevMonthEnd)).toList();

    double currentTotal = 0.0;
    for (final tx in currentMonthPayments) {
      currentTotal += tx.snapshotBaseAmount;
    }

    double prevTotal = 0.0;
    for (final tx in prevMonthPayments) {
      prevTotal += tx.snapshotBaseAmount;
    }

    double percentageChange = 0.0;
    bool hasPreviousData = prevTotal > 0;
    if (hasPreviousData) {
      percentageChange = ((currentTotal - prevTotal) / prevTotal) * 100;
    }

    final bool isIncrease = percentageChange > 0;
    final bool isZero = percentageChange == 0.0;

    final Color trendColor = isZero
        ? (isDark ? AppColors.textSecondaryDark : AppColors.textSecondary)
        : (isIncrease ? AppColors.error : AppColors.success);

    final IconData trendIcon = isZero
        ? Icons.trending_flat
        : (isIncrease ? Icons.trending_up : Icons.trending_down);

    // Dynamic message in Turkish/English fallback
    String momMessage = '';
    if (l10n.localeName == 'tr') {
      if (!hasPreviousData) {
        momMessage = 'Geçen aya ait harcama verisi bulunamadı.';
      } else if (isZero) {
        momMessage = 'Harcamalarınız geçen ayla aynı seviyede.';
      } else if (isIncrease) {
        momMessage = 'Harcamalarınız geçen aya göre %${percentageChange.toStringAsFixed(1)} arttı.';
      } else {
        momMessage = 'Tebrikler! Harcamalarınız geçen aya göre %${percentageChange.abs().toStringAsFixed(1)} azaldı.';
      }
    } else {
      if (!hasPreviousData) {
        momMessage = 'No spending data available for the previous month.';
      } else if (isZero) {
        momMessage = 'Your spending is identical to last month.';
      } else if (isIncrease) {
        momMessage = 'Your spending increased by %${percentageChange.toStringAsFixed(1)} compared to last month.';
      } else {
        momMessage = 'Great! Your spending decreased by %${percentageChange.abs().toStringAsFixed(1)} compared to last month.';
      }
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.localeName == 'tr' ? 'Aylık Harcama Değişimi' : 'Monthly Spending Trend',
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.xs),
                  decoration: BoxDecoration(
                    color: trendColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    trendIcon,
                    color: trendColor,
                    size: 32,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        textBaseline: TextBaseline.alphabetic,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          Text(
                            CurrencyFormatter.format(currentTotal, baseCurrency),
                            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            l10n.localeName == 'tr' ? '(Bu Ay)' : '(This Month)',
                            style: textTheme.bodySmall?.copyWith(
                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      if (hasPreviousData) ...[
                        const SizedBox(height: 2),
                        Text(
                          l10n.localeName == 'tr'
                              ? 'Geçen Ay: ${CurrencyFormatter.format(prevTotal, baseCurrency)}'
                              : 'Last Month: ${CurrencyFormatter.format(prevTotal, baseCurrency)}',
                          style: textTheme.bodySmall?.copyWith(
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: isDark ? AppColors.backgroundDark : AppColors.background,
                borderRadius: BorderRadius.circular(AppRadii.card / 2),
                border: Border.all(
                  color: isDark
                      ? AppColors.inactiveDark.withValues(alpha: 0.1)
                      : AppColors.inactive.withValues(alpha: 0.2),
                ),
              ),
              child: Text(
                momMessage,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
