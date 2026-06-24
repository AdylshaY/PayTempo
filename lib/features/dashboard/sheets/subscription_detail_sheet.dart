import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/app/utils/date_formatter.dart';
import 'package:pay_tempo/data/local/isar_database.dart';
import 'package:pay_tempo/data/local/models/payment_transaction.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';
import 'package:pay_tempo/data/local/services/exchange_rate_service.dart';
import 'package:pay_tempo/features/onboarding/data/user_settings_service.dart';
import 'package:pay_tempo/features/subscriptions/data/subscription_categories.dart';
import 'package:pay_tempo/data/local/services/notification_service.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

/// A bottom sheet that displays full details for a subscription,
/// including recent payment history and a converted price equivalent.
class SubscriptionDetailSheet extends StatefulWidget {
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

  @override
  State<SubscriptionDetailSheet> createState() => _SubscriptionDetailSheetState();
}

class _SubscriptionDetailSheetState extends State<SubscriptionDetailSheet> {
  late bool _notificationsEnabled;

  @override
  void initState() {
    super.initState();
    _notificationsEnabled = widget.subscription.enableNotifications;
  }

  Future<void> _toggleNotifications(bool value) async {
    setState(() {
      _notificationsEnabled = value;
    });

    final isar = LocalDatabase.instance.isar;
    await isar.writeTxn(() async {
      widget.subscription.enableNotifications = value;
      widget.subscription.updatedAt = DateTime.now();
      await isar.subscriptionRecords.put(widget.subscription);
    });

    if (value) {
      await NotificationService.instance.scheduleSubscriptionNotifications(widget.subscription);
    } else {
      await NotificationService.instance.cancelSubscriptionNotifications(widget.subscription);
    }
  }

  Widget _buildAvatar() {
    final subscription = widget.subscription;
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

  String _billingCycleLabel(String cycle, AppLocalizations l10n) {
    switch (cycle.toLowerCase()) {
      case 'monthly':
        return l10n.monthlyLabel;
      case 'yearly':
        return l10n.yearlyLabel;
      case 'weekly':
        return l10n.weeklyLabel;
      case 'quarterly':
        return l10n.quarterlyLabel;
      default:
        return cycle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final subscription = widget.subscription;
    final baseCurrency = widget.baseCurrency;
    final isPaidThisMonth = widget.isPaidThisMonth;
    final onMarkPaid = widget.onMarkPaid;

    final TextTheme textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;
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
                      Row(
                        children: [
                          Text(
                            getCategoryLabel(subscription.category, l10n),
                            style: textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          if (subscription.note != null &&
                              subscription.note!.isNotEmpty) ...[
                            Text(
                              ' • ',
                              style: textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                subscription.note!,
                                style: textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                  fontStyle: FontStyle.italic,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ],
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
                      label: l10n.priceLabel,
                      value:
                          '${subscription.price.toStringAsFixed(2)} ${subscription.currency}',
                    ),
                    if (showConversion) ...[
                      const SizedBox(height: AppSpacing.xs),
                      _InfoRow(
                        icon: Icons.currency_exchange,
                        label: l10n.equivalentLabel,
                        value:
                            '≈ ${ExchangeRateService.instance.convert(subscription.price, subscription.currency, baseCurrency).toStringAsFixed(2)} $baseCurrency',
                      ),
                    ],
                    const SizedBox(height: AppSpacing.xs),
                    _InfoRow(
                      icon: Icons.repeat,
                      label: l10n.billingCycleLabel,
                      value: _billingCycleLabel(subscription.billingCycle, l10n),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    _InfoRow(
                      icon: Icons.calendar_today_outlined,
                      label: l10n.nextPaymentLabel,
                      value: subscription.nextPaymentDate
                          .toMonthDayYearCommaLabel(l10n.localeName),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    _InfoRow(
                      icon: Icons.pin_outlined,
                      label: l10n.anchorDayLabel,
                      value: '${subscription.anchorDay}',
                    ),
                    const Divider(height: AppSpacing.md),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      secondary: Icon(
                        _notificationsEnabled
                            ? Icons.notifications_active_outlined
                            : Icons.notifications_off_outlined,
                        color: AppColors.textSecondary,
                      ),
                      title: Text(
                        l10n.notificationsLabel,
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        _notificationsEnabled
                            ? l10n.notificationsEnabledSubtitle
                            : l10n.notificationsDisabledSubtitle,
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      value: _notificationsEnabled,
                      onChanged: _toggleNotifications,
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
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                icon: const Icon(Icons.settings_outlined),
                label: Text(l10n.manageSubscriptionDetailLabel),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
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
                  isPaidThisMonth ? l10n.alreadyPaidThisMonth : l10n.markAsPaid,
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
    final l10n = AppLocalizations.of(context)!;
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
                    l10n.noPaymentsRecordedYet,
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
                      l10n.recentPaymentsTitle,
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      l10n.countRecorded(payments.length),
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
                          tx.paidAt.toMonthDayYearCommaLabel(l10n.localeName),
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
