import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/data/local/isar_database.dart';
import 'package:pay_tempo/data/local/models/payment_transaction.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';
import 'package:pay_tempo/data/local/services/exchange_rate_service.dart';
import 'package:pay_tempo/features/dashboard/utils/due_date_resolver.dart';
import 'package:pay_tempo/features/onboarding/data/user_settings_service.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class MonthlySpendingCardWidget extends StatelessWidget {
  const MonthlySpendingCardWidget({
    required this.baseCurrency,
    super.key,
  });

  final String baseCurrency;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final DateTime now = DateTime.now();
    final DateTime monthStart = DateTime(now.year, now.month, 1);
    final DateTime nextMonthStart = DateTime(now.year, now.month + 1, 1);
    final isar = LocalDatabase.instance.isar;
    final l10n = AppLocalizations.of(context)!;

    return Card(
      child: StreamBuilder<List<SubscriptionRecord>>(
        stream: isar.subscriptionRecords
            .filter()
            .isDeletedEqualTo(false)
            .watch(fireImmediately: true),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<SubscriptionRecord>> subscriptionsSnapshot,
        ) {
          return StreamBuilder<List<PaymentTransaction>>(
            stream: isar.paymentTransactions
                .filter()
                .isDeletedEqualTo(false)
                .watch(fireImmediately: true),
            builder: (
              BuildContext context,
              AsyncSnapshot<List<PaymentTransaction>> paymentsSnapshot,
            ) {
              final List<SubscriptionRecord> subscriptions =
                  subscriptionsSnapshot.data ?? const <SubscriptionRecord>[];
              final List<PaymentTransaction> payments =
                  paymentsSnapshot.data ?? const <PaymentTransaction>[];

              final Set<String> paidThisMonthSubscriptionUids = payments
                  .where((PaymentTransaction item) {
                    return !item.paidAt.isBefore(monthStart) &&
                        item.paidAt.isBefore(nextMonthStart);
                  })
                  .map((PaymentTransaction item) => item.subscriptionUid)
                  .toSet();

              final List<SubscriptionRecord> dueSubscriptions = subscriptions
                  .where((SubscriptionRecord item) {
                    final bool isPaidThisMonth =
                        paidThisMonthSubscriptionUids.contains(item.uid);
                    final DateTime effectiveDueDate = resolveEffectiveDueDate(
                      subscription: item,
                      now: now,
                      isPaidThisMonth: isPaidThisMonth,
                    );

                    return !effectiveDueDate.isBefore(monthStart) &&
                        effectiveDueDate.isBefore(nextMonthStart);
                  })
                  .toList(growable: false);

              final double paidTotal = payments
                  .where((PaymentTransaction item) {
                    return !item.paidAt.isBefore(monthStart) &&
                        item.paidAt.isBefore(nextMonthStart);
                  })
                  .fold<double>(0, (double total, PaymentTransaction item) {
                    return total + item.snapshotBaseAmount;
                  });
              final double remainingTotal = dueSubscriptions
                  .where((SubscriptionRecord item) {
                    return !paidThisMonthSubscriptionUids.contains(item.uid);
                  })
                  .fold<double>(0, (double total, SubscriptionRecord item) {
                    return total + ExchangeRateService.instance.convert(
                      item.price,
                      item.currency,
                      baseCurrency,
                    );
                  });

              return Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${paidTotal.toStringAsFixed(2)} $baseCurrency',
                      style: textTheme.displayLarge?.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      l10n.paidThisMonth,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      l10n.remainingFromActive(remainingTotal.toStringAsFixed(2), baseCurrency),
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant.withValues(alpha: 0.75),
                      ),
                    ),
                    // Budget progress bar (reactive via ValueListenableBuilder)
                    ValueListenableBuilder<double?>(
                      valueListenable: UserSettingsService.budgetLimitNotifier,
                      builder: (BuildContext context, double? budgetLimit, Widget? _) {
                        if (budgetLimit == null || budgetLimit <= 0) {
                          return const SizedBox.shrink();
                        }

                        final double estimatedTotal = paidTotal + remainingTotal;
                        final double ratio = (estimatedTotal / budgetLimit).clamp(0.0, 1.5);

                        // Color logic: green < 80%, warning 80-100%, error > 100%
                        final Color progressColor;
                        if (ratio > 1.0) {
                          progressColor = AppColors.error;
                        } else if (ratio >= 0.8) {
                          progressColor = AppColors.warning;
                        } else {
                          progressColor = AppColors.success;
                        }

                        final bool isExceeded = ratio > 1.0;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: AppSpacing.sm),
                            // Budget label row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      isExceeded
                                          ? Icons.warning_amber_rounded
                                          : Icons.account_balance_wallet_outlined,
                                      size: 14,
                                      color: progressColor,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      l10n.budgetLabel,
                                      style: textTheme.bodySmall?.copyWith(
                                        color: progressColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  l10n.budgetOf(
                                    estimatedTotal.toStringAsFixed(0),
                                    budgetLimit.toStringAsFixed(0),
                                    baseCurrency,
                                  ),
                                  style: textTheme.bodySmall?.copyWith(
                                    color: progressColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            // Progress bar
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: SizedBox(
                                height: 6,
                                child: LinearProgressIndicator(
                                  value: ratio.clamp(0.0, 1.0),
                                  backgroundColor: colorScheme.onSurface.withValues(alpha: 0.08),
                                  valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                                ),
                              ),
                            ),
                            // Exceeded warning text
                            if (isExceeded) ...[
                              const SizedBox(height: 4),
                              Text(
                                l10n.budgetExceeded,
                                style: textTheme.bodySmall?.copyWith(
                                  color: AppColors.error,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}