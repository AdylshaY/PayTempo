import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/app/utils/date_formatter.dart';
import 'package:pay_tempo/data/local/isar_database.dart';
import 'package:pay_tempo/data/local/models/payment_transaction.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';
import 'package:pay_tempo/data/local/services/exchange_rate_service.dart';
import 'package:pay_tempo/features/onboarding/data/user_settings_service.dart';

/// A bottom sheet that displays full details for a subscription,
/// including recent payment history and a converted price equivalent.
class SubscriptionDetailSheet extends StatelessWidget {
  const SubscriptionDetailSheet({
    required this.subscription,
    required this.baseCurrency,
    this.isPaidThisMonth = false,
    this.onMarkPaid,
    super.key,
  });

  final SubscriptionRecord subscription;
  final String baseCurrency;
  final bool isPaidThisMonth;
  final VoidCallback? onMarkPaid;

  Widget _buildAvatar() {
    final Color backgroundColor = subscription.avatarColorValue != null
        ? Color(subscription.avatarColorValue!)
        : AppColors.primary;

    if (subscription.avatarType == 'emoji' &&
        subscription.avatarEmoji != null &&
        subscription.avatarEmoji!.isNotEmpty) {
      return Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppRadii.card),
        ),
        alignment: Alignment.center,
        child: Text(
          subscription.avatarEmoji!,
          style: const TextStyle(fontSize: 28),
        ),
      );
    }

    if (subscription.avatarIconCodePoint != null) {
      return Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppRadii.card),
        ),
        child: Icon(
          IconData(
            subscription.avatarIconCodePoint!,
            fontFamily: subscription.avatarIconFontFamily,
            fontPackage: subscription.avatarIconFontPackage,
          ),
          color: Colors.white,
          size: 28,
        ),
      );
    }

    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: const Icon(
        Icons.subscriptions_outlined,
        color: Colors.white,
        size: 28,
      ),
    );
  }

  String _billingCycleLabel(String cycle) {
    switch (cycle.toLowerCase()) {
      case 'monthly':
        return 'Monthly';
      case 'yearly':
        return 'Yearly';
      case 'weekly':
        return 'Weekly';
      case 'quarterly':
        return 'Quarterly';
      default:
        return cycle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool showConversion =
        subscription.currency.toUpperCase() != baseCurrency.toUpperCase();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          0,
          AppSpacing.md,
          AppSpacing.md,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Header ──
            Row(
              children: [
                _buildAvatar(),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subscription.name,
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subscription.category,
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.md),

            // ── Info Grid ──
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: Column(
                  children: [
                    _InfoRow(
                      icon: Icons.payments_outlined,
                      label: 'Price',
                      value:
                          '${subscription.price.toStringAsFixed(2)} ${subscription.currency}',
                    ),
                    if (showConversion) ...[
                      const SizedBox(height: AppSpacing.xs),
                      _InfoRow(
                        icon: Icons.currency_exchange,
                        label: 'Equivalent',
                        value:
                            '≈ ${ExchangeRateService.instance.convert(subscription.price, subscription.currency, baseCurrency).toStringAsFixed(2)} $baseCurrency',
                      ),
                    ],
                    const SizedBox(height: AppSpacing.xs),
                    _InfoRow(
                      icon: Icons.repeat,
                      label: 'Billing cycle',
                      value: _billingCycleLabel(subscription.billingCycle),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    _InfoRow(
                      icon: Icons.calendar_today_outlined,
                      label: 'Next payment',
                      value: subscription.nextPaymentDate
                          .toMonthDayYearCommaLabel(),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    _InfoRow(
                      icon: Icons.pin_outlined,
                      label: 'Anchor day',
                      value: '${subscription.anchorDay}',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.sm),

            // ── Recent Payments ──
            _RecentPaymentsSection(subscriptionUid: subscription.uid),

            const SizedBox(height: AppSpacing.md),

            // ── Actions ──
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: isPaidThisMonth
                    ? null
                    : () {
                        Navigator.of(context).pop();
                        onMarkPaid?.call();
                      },
                icon: Icon(
                  isPaidThisMonth
                      ? Icons.check_circle
                      : Icons.check_circle_outline,
                ),
                label: Text(
                  isPaidThisMonth ? 'Already paid this month' : 'Mark as paid',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Private helper widgets
// ─────────────────────────────────────────────────────────────────────────────

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        const SizedBox(width: AppSpacing.xs),
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _RecentPaymentsSection extends StatelessWidget {
  const _RecentPaymentsSection({required this.subscriptionUid});

  final String subscriptionUid;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final isar = LocalDatabase.instance.isar;
    final String baseCurrency =
        UserSettingsService.baseCurrencyNotifier.value;

    return StreamBuilder<List<PaymentTransaction>>(
      stream: isar.paymentTransactions
          .filter()
          .isDeletedEqualTo(false)
          .subscriptionUidEqualTo(subscriptionUid)
          .sortByPaidAtDesc()
          .limit(5)
          .watch(fireImmediately: true),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<PaymentTransaction>> snapshot,
      ) {
        final List<PaymentTransaction> payments =
            snapshot.data ?? const <PaymentTransaction>[];

        if (payments.isEmpty) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'No payments recorded yet',
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent payments',
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${payments.length} recorded',
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                ...payments.map((PaymentTransaction tx) {
                  final bool showConverted =
                      tx.paidCurrency.toUpperCase() !=
                          baseCurrency.toUpperCase();

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          size: 16,
                          color: AppColors.success,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          tx.paidAt.toMonthDayYearCommaLabel(),
                          style: textTheme.bodySmall,
                        ),
                        const Spacer(),
                        Text(
                          showConverted
                              ? '${tx.snapshotBaseAmount.toStringAsFixed(2)} ${tx.snapshotBaseCurrency}'
                              : '${tx.paidAmount.toStringAsFixed(2)} ${tx.paidCurrency}',
                          style: textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
