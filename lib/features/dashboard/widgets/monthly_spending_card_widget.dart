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
    final DateTime now = DateTime.now();
    final DateTime monthStart = DateTime(now.year, now.month, 1);
    final DateTime nextMonthStart = DateTime(now.year, now.month + 1, 1);
    final isar = LocalDatabase.instance.isar;
    final l10n = AppLocalizations.of(context)!;

    return StreamBuilder<List<SubscriptionRecord>>(
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

            // Paid this month
            final List<PaymentTransaction> thisMonthPayments = payments
                .where((PaymentTransaction item) {
                  return !item.paidAt.isBefore(monthStart) &&
                      item.paidAt.isBefore(nextMonthStart);
                })
                .toList(growable: false);

            final Set<String> paidThisMonthUids = thisMonthPayments
                .map((PaymentTransaction item) => item.subscriptionUid)
                .toSet();

            // Due this month
            final List<SubscriptionRecord> dueSubscriptions = subscriptions
                .where((SubscriptionRecord item) {
                  final bool isPaid = paidThisMonthUids.contains(item.uid);
                  final DateTime effectiveDueDate = resolveEffectiveDueDate(
                    subscription: item,
                    now: now,
                    isPaidThisMonth: isPaid,
                  );
                  return !effectiveDueDate.isBefore(monthStart) &&
                      effectiveDueDate.isBefore(nextMonthStart);
                })
                .toList(growable: false);

            final double paidTotal = thisMonthPayments
                .fold<double>(0, (double total, PaymentTransaction item) {
                  return total + item.snapshotBaseAmount;
                });

            final double remainingTotal = dueSubscriptions
                .where((SubscriptionRecord item) {
                  return !paidThisMonthUids.contains(item.uid);
                })
                .fold<double>(0, (double total, SubscriptionRecord item) {
                  return total + ExchangeRateService.instance.convert(
                    item.price,
                    item.currency,
                    baseCurrency,
                  );
                });

            final double estimatedTotal = paidTotal + remainingTotal;
            final int paidCount = paidThisMonthUids.length;
            final int dueCount = dueSubscriptions.length;
            final int activeCount = subscriptions.length;

            return _HeroCardContent(
              baseCurrency: baseCurrency,
              paidTotal: paidTotal,
              remainingTotal: remainingTotal,
              estimatedTotal: estimatedTotal,
              paidCount: paidCount,
              dueCount: dueCount,
              activeCount: activeCount,
              l10n: l10n,
            );
          },
        );
      },
    );
  }
}

class _HeroCardContent extends StatelessWidget {
  const _HeroCardContent({
    required this.baseCurrency,
    required this.paidTotal,
    required this.remainingTotal,
    required this.estimatedTotal,
    required this.paidCount,
    required this.dueCount,
    required this.activeCount,
    required this.l10n,
  });

  final String baseCurrency;
  final double paidTotal;
  final double remainingTotal;
  final double estimatedTotal;
  final int paidCount;
  final int dueCount;
  final int activeCount;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  AppColors.primary.withValues(alpha: 0.85),
                  AppColors.primaryGradientEndDark,
                ]
              : [
                  AppColors.primary,
                  AppColors.secondaryHighlight,
                ],
        ),
        borderRadius: BorderRadius.circular(AppRadii.hero),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: isDark ? 0.3 : 0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Label
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    l10n.paidThisMonth,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    baseCurrency,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),

            // Main amount
            Text(
              paidTotal.toStringAsFixed(2),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w700,
                height: 1.1,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 4),

            // Remaining subtitle
            Text(
              l10n.remainingFromActive(
                remainingTotal.toStringAsFixed(2),
                baseCurrency,
              ),
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),

            // Divider
            Container(
              height: 1,
              color: Colors.white.withValues(alpha: 0.12),
            ),
            const SizedBox(height: AppSpacing.sm),

            // Mini stats row
            Row(
              children: [
                _MiniStat(
                  icon: Icons.repeat_rounded,
                  label: l10n.heroStatActive,
                  value: activeCount.toString(),
                ),
                _miniDivider(),
                _MiniStat(
                  icon: Icons.check_circle_outline_rounded,
                  label: l10n.heroStatPaid,
                  value: '$paidCount/$dueCount',
                ),
                _miniDivider(),
                _MiniStat(
                  icon: Icons.trending_up_rounded,
                  label: l10n.heroStatEstimated,
                  value: estimatedTotal.toStringAsFixed(0),
                ),
              ],
            ),

            // Budget progress bar
            ValueListenableBuilder<double?>(
              valueListenable: UserSettingsService.budgetLimitNotifier,
              builder: (BuildContext context, double? budgetLimit, Widget? _) {
                if (budgetLimit == null || budgetLimit <= 0) {
                  return const SizedBox.shrink();
                }

                final double ratio = (estimatedTotal / budgetLimit).clamp(0.0, 1.5);

                final Color barColor;
                if (ratio > 1.0) {
                  barColor = AppColors.error;
                } else if (ratio >= 0.8) {
                  barColor = AppColors.warning;
                } else {
                  barColor = AppColors.success;
                }

                final bool isExceeded = ratio > 1.0;

                return Column(
                  children: [
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              isExceeded
                                  ? Icons.warning_amber_rounded
                                  : Icons.account_balance_wallet_outlined,
                              size: 13,
                              color: isExceeded
                                  ? barColor
                                  : Colors.white70,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              l10n.budgetLabel,
                              style: TextStyle(
                                color: isExceeded
                                    ? barColor
                                    : Colors.white70,
                                fontSize: 11,
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
                          style: TextStyle(
                            color: isExceeded
                                ? barColor
                                : Colors.white70,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: SizedBox(
                        height: 5,
                        child: LinearProgressIndicator(
                          value: ratio.clamp(0.0, 1.0),
                          backgroundColor: Colors.white.withValues(alpha: 0.15),
                          valueColor: AlwaysStoppedAnimation<Color>(barColor),
                        ),
                      ),
                    ),
                    if (isExceeded) ...[
                      const SizedBox(height: 4),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          l10n.budgetExceeded,
                          style: TextStyle(
                            color: barColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Container(
        width: 1,
        height: 28,
        color: Colors.white.withValues(alpha: 0.12),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: Colors.white70, size: 16),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}