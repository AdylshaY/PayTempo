import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';
import 'package:pay_tempo/data/local/services/exchange_rate_service.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class InstallmentsCard extends StatelessWidget {
  final List<SubscriptionRecord> subscriptions;
  final String baseCurrency;

  const InstallmentsCard({
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

    // Filter active items with installments (totalInstallments != null, and remainingInstallments > 0)
    final installmentSubs = subscriptions.where((s) {
      if (s.isPaused || s.isDeleted) return false;
      return s.totalInstallments != null &&
             s.remainingInstallments != null &&
             s.remainingInstallments! > 0;
    }).toList();

    if (installmentSubs.isEmpty) {
      return const SizedBox.shrink();
    }

    double monthlyCommitmentSum = 0.0;
    double remainingDebtSum = 0.0;

    for (final sub in installmentSubs) {
      final double monthlyPriceInBase = rateService.convert(sub.price, sub.currency, baseCurrency);
      monthlyCommitmentSum += monthlyPriceInBase;
      remainingDebtSum += monthlyPriceInBase * sub.remainingInstallments!;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.localeName == 'tr' ? 'Kredi Kartı Taksitleri' : 'Credit Card Installments',
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.sm),

            // Summary Info
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.localeName == 'tr' ? 'Aylık Taksit Yükü' : 'Monthly Payment Load',
                        style: textTheme.bodySmall?.copyWith(
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${monthlyCommitmentSum.toStringAsFixed(2)} $baseCurrency',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.error, // Installment load
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
                        l10n.localeName == 'tr' ? 'Toplam Kalan Borç' : 'Total Remaining Debt',
                        style: textTheme.bodySmall?.copyWith(
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${remainingDebtSum.toStringAsFixed(2)} $baseCurrency',
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
            const Divider(),
            const SizedBox(height: AppSpacing.xs),

            // List of Installments
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: installmentSubs.length,
              separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) {
                final sub = installmentSubs[index];
                final double priceInBase = rateService.convert(sub.price, sub.currency, baseCurrency);
                final int currentInstallment = sub.totalInstallments! - sub.remainingInstallments! + 1;

                return Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.xs),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.credit_card_outlined,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sub.name,
                            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            l10n.localeName == 'tr'
                                ? '$currentInstallment. taksit ödendi ({remaining} taksit kaldı)'
                                : 'Paid installment $currentInstallment ({remaining} left)',
                            style: textTheme.bodySmall?.copyWith(
                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${priceInBase.toStringAsFixed(2)} $baseCurrency',
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${sub.price.toStringAsFixed(2)} ${sub.currency}',
                          style: textTheme.bodySmall?.copyWith(
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
