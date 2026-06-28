import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/app/widgets/info_banner_widget.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';
import 'package:pay_tempo/data/local/services/exchange_rate_service.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class BillingCycleBreakdown extends StatelessWidget {
  final List<SubscriptionRecord> subscriptions;
  final String baseCurrency;

  const BillingCycleBreakdown({
    super.key,
    required this.subscriptions,
    required this.baseCurrency,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final rateService = ExchangeRateService.instance;

    int monthlyCount = 0;
    int yearlyCount = 0;
    double monthlyBaseSum = 0.0; // sum of monthly equivalent costs
    double yearlyBaseSum = 0.0; // sum of yearly equivalent costs

    double discountableMonthlyBaseSum = 0.0;

    for (final sub in subscriptions) {
      final double priceInBase = rateService.convert(sub.price, sub.currency, baseCurrency);

      if (sub.billingCycle.toLowerCase() == 'yearly') {
        yearlyCount++;
        yearlyBaseSum += priceInBase / 12.0; // normalized to monthly
      } else {
        monthlyCount++;
        monthlyBaseSum += priceInBase;

        final String categoryLower = sub.category.trim().toLowerCase();
        if (categoryLower != 'housing' &&
            categoryLower != 'housing/rent' &&
            categoryLower != 'utilities' &&
            categoryLower != 'bills/utilities' &&
            categoryLower != 'finance' &&
            categoryLower != 'finance/installment') {
          discountableMonthlyBaseSum += priceInBase;
        }
      }
    }

    final double totalMonthlyEquivalent = monthlyBaseSum + yearlyBaseSum;
    final double totalYearlyEquivalent = totalMonthlyEquivalent * 12.0;

    final double monthlyRatio = totalMonthlyEquivalent > 0
        ? (monthlyBaseSum / totalMonthlyEquivalent)
        : 0.0;
    final double yearlyRatio = totalMonthlyEquivalent > 0
        ? (yearlyBaseSum / totalMonthlyEquivalent)
        : 0.0;

    // Calculate potential 20% savings if monthly subscriptions are paid yearly
    // (Only applied to typical discountable digital subscriptions, excluding housing/utilities/finance)
    final double potentialSavings = discountableMonthlyBaseSum * 12.0 * 0.20;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.billingCycleBreakdown,
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.sm),
            
            // Total Equivalent Display
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.equivalentMonthlyTotal,
                        style: textTheme.bodySmall?.copyWith(
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${totalMonthlyEquivalent.toStringAsFixed(2)} $baseCurrency',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.equivalentYearlyTotal,
                        style: textTheme.bodySmall?.copyWith(
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${totalYearlyEquivalent.toStringAsFixed(2)} $baseCurrency',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            // Horizontal Stacked Segmented Progress Bar
            if (totalMonthlyEquivalent > 0) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SizedBox(
                  height: 12,
                  child: Row(
                    children: [
                      if (monthlyRatio > 0)
                        Expanded(
                          flex: (monthlyRatio * 100).round(),
                          child: Container(
                            color: AppColors.primary,
                          ),
                        ),
                      if (yearlyRatio > 0)
                        Expanded(
                          flex: (yearlyRatio * 100).round(),
                          child: Container(
                            color: AppColors.proGold,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],

            // Legends and Detailed Subtitle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Monthly Legend
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${l10n.monthlyCycleLabel} ($monthlyCount)',
                      style: textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '(${(monthlyRatio * 100).toStringAsFixed(0)}%)',
                      style: textTheme.bodySmall?.copyWith(
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                // Yearly Legend
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: AppColors.proGold,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${l10n.yearlyCycleLabel} ($yearlyCount)',
                      style: textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '(${(yearlyRatio * 100).toStringAsFixed(0)}%)',
                      style: textTheme.bodySmall?.copyWith(
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Savings Recommendation Card (Only if they have monthly subscriptions)
            if (potentialSavings > 0) ...[
              const SizedBox(height: AppSpacing.md),
              InfoBannerWidget(
                icon: Icons.tips_and_updates_outlined,
                accentColor: AppColors.success,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.potentialSavingsTitle,
                      style: textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.success,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.potentialSavingsDesc,
                      style: textTheme.bodySmall?.copyWith(
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        style: textTheme.bodySmall,
                        children: [
                          TextSpan(
                            text: l10n.localeName == 'tr'
                                ? 'Tahmini Tasarruf: '
                                : 'Estimated Savings: ',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: '${potentialSavings.toStringAsFixed(2)} $baseCurrency',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.success,
                            ),
                          ),
                          TextSpan(
                            text: l10n.localeName == 'tr' ? ' / yıl' : ' / year',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
