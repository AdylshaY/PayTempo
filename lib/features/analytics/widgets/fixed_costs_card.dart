import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';
import 'package:pay_tempo/data/local/models/payment_transaction.dart';
import 'package:pay_tempo/data/local/services/exchange_rate_service.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class FixedCostsCard extends StatelessWidget {
  final List<SubscriptionRecord> subscriptions;
  final List<PaymentTransaction> payments;
  final String baseCurrency;

  const FixedCostsCard({
    super.key,
    required this.subscriptions,
    required this.payments,
    required this.baseCurrency,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final rateService = ExchangeRateService.instance;

    // Filter active housing/rent and utilities/bills subscriptions
    final fixedSubs = subscriptions.where((s) {
      if (s.isPaused) return false;
      final cat = s.category.trim().toLowerCase();
      return cat == 'housing' || cat == 'housing/rent' ||
             cat == 'utilities' || cat == 'bills/utilities';
    }).toList();

    // If there are no active fixed cost items, don't show the card
    if (fixedSubs.isEmpty) {
      return const SizedBox.shrink();
    }

    // Calculate projected annual and monthly cost
    double annualProjection = 0.0;
    double monthlyProjection = 0.0;

    for (final sub in fixedSubs) {
      final double priceInBase = rateService.convert(sub.price, sub.currency, baseCurrency);
      if (sub.billingCycle.toLowerCase() == 'yearly') {
        annualProjection += priceInBase;
        monthlyProjection += priceInBase / 12.0;
      } else {
        annualProjection += priceInBase * 12.0;
        monthlyProjection += priceInBase;
      }
    }

    // Calculate actual historical payments in the last 12 months (365 days)
    final DateTime now = DateTime.now();
    final DateTime twelveMonthsAgo = now.subtract(const Duration(days: 365));

    final Map<String, SubscriptionRecord> fixedSubMap = {
      for (final sub in subscriptions)
        if (sub.category.trim().toLowerCase() == 'housing' ||
            sub.category.trim().toLowerCase() == 'housing/rent' ||
            sub.category.trim().toLowerCase() == 'utilities' ||
            sub.category.trim().toLowerCase() == 'bills/utilities')
          sub.uid: sub
    };

    double actualSpent12Months = 0.0;
    for (final tx in payments) {
      if (tx.paidAt.isAfter(twelveMonthsAgo) && fixedSubMap.containsKey(tx.subscriptionUid)) {
        actualSpent12Months += tx.snapshotBaseAmount;
      }
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.localeName == 'tr' ? 'Sabit Gider Analizi (Kira & Faturalar)' : 'Fixed Costs Analysis (Rent & Bills)',
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.sm),
            
            // Projections
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.localeName == 'tr' ? 'Aylık Öngörü' : 'Monthly Projection',
                        style: textTheme.bodySmall?.copyWith(
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${monthlyProjection.toStringAsFixed(2)} $baseCurrency',
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
                        l10n.localeName == 'tr' ? 'Yıllık Toplam Öngörü' : 'Annual Total Projection',
                        style: textTheme.bodySmall?.copyWith(
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${annualProjection.toStringAsFixed(2)} $baseCurrency',
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
            
            // Actual Spent Last 12 Months
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadii.card / 2),
                border: Border.all(
                  color: isDark
                      ? AppColors.inactiveDark.withValues(alpha: 0.1)
                      : AppColors.inactive.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.history_toggle_off_rounded,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.localeName == 'tr'
                              ? 'Son 12 Ayda Ödenen Fiili Tutar'
                              : 'Actual Spent (Last 12 Months)',
                          style: textTheme.bodySmall?.copyWith(
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${actualSpent12Months.toStringAsFixed(2)} $baseCurrency',
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
