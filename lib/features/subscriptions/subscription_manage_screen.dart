import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/data/local/isar_database.dart';
import 'package:pay_tempo/data/local/models/payment_transaction.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';
import 'package:pay_tempo/features/payments/widgets/payment_row.dart';
import 'package:pay_tempo/features/subscriptions/add_subscription_screen.dart';
import 'package:pay_tempo/features/subscriptions/data/services/subscription_service.dart';
import 'package:pay_tempo/features/subscriptions/data/subscription_categories.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class SubscriptionManageScreen extends StatefulWidget {
  const SubscriptionManageScreen({
    required this.subscription,
    required this.baseCurrency,
    super.key,
  });

  final SubscriptionRecord subscription;
  final String baseCurrency;

  @override
  State<SubscriptionManageScreen> createState() => _SubscriptionManageScreenState();
}

class _SubscriptionManageScreenState extends State<SubscriptionManageScreen> {
  final SubscriptionService _subscriptionService = SubscriptionService();

  Future<void> _deleteSubscription(SubscriptionRecord subscription) async {
    final l10n = AppLocalizations.of(context)!;
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(l10n.deleteSubscription),
          content: Text(l10n.deleteSubscriptionConfirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(l10n.cancelButtonLabel),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(l10n.deleteSubscription),
            ),
          ],
        );
      },
    );

    if (confirmed == true && mounted) {
      try {
        await _subscriptionService.deleteSubscription(subscription);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.subscriptionDeletedSuccess)),
        );
        Navigator.of(context).pop(); // Go back to Dashboard
      } catch (_) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to delete subscription.')),
        );
      }
    }
  }

  Future<void> _editSubscription(SubscriptionRecord subscription) async {
    final l10n = AppLocalizations.of(context)!;
    final bool? updated = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => AddSubscriptionScreen(
          subscriptionToEdit: subscription,
        ),
      ),
    );

    if (updated == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.subscriptionUpdatedSuccess)),
      );
    }
  }

  Widget _buildAvatar(SubscriptionRecord subscription) {
    final Color backgroundColor = subscription.avatarColorValue != null
        ? Color(subscription.avatarColorValue!)
        : AppColors.primary;

    if (subscription.avatarType == 'emoji' &&
        subscription.avatarEmoji != null &&
        subscription.avatarEmoji!.isNotEmpty) {
      return Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppRadii.card),
        ),
        alignment: Alignment.center,
        child: Text(
          subscription.avatarEmoji!,
          style: const TextStyle(fontSize: 32),
        ),
      );
    }

    if (subscription.avatarIconCodePoint != null) {
      return Container(
        width: 64,
        height: 64,
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
          size: 32,
        ),
      );
    }

    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: const Icon(
        Icons.subscriptions_outlined,
        color: Colors.white,
        size: 32,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isar = LocalDatabase.instance.isar;
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return StreamBuilder<SubscriptionRecord?>(
      initialData: widget.subscription,
      stream: isar.subscriptionRecords
          .watchObject(widget.subscription.id, fireImmediately: true),
      builder: (context, subSnapshot) {
        final subscription = subSnapshot.data;
        if (subscription == null || subscription.isDeleted) {
          // If deleted, schedule pop on next frame
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.subscriptionManageTitle),
            actions: [
              IconButton(
                onPressed: () => _editSubscription(subscription),
                icon: const Icon(Icons.edit_rounded),
              ),
              IconButton(
                onPressed: () => _deleteSubscription(subscription),
                icon: const Icon(Icons.delete_outline_rounded, color: AppColors.error),
              ),
            ],
          ),
          body: StreamBuilder<List<PaymentTransaction>>(
            stream: isar.paymentTransactions
                .filter()
                .isDeletedEqualTo(false)
                .subscriptionUidEqualTo(subscription.uid)
                .sortByPaidAtDesc()
                .watch(fireImmediately: true),
            builder: (context, paymentsSnapshot) {
              final payments = paymentsSnapshot.data ?? [];

              // Calculate total spent
              double totalSpentBase = 0.0;
              double totalSpentSubscriptionCurrency = 0.0;
              for (final tx in payments) {
                totalSpentBase += tx.snapshotBaseAmount;
                totalSpentSubscriptionCurrency += tx.paidAmount;
              }

              final bool hasConversion =
                  subscription.currency.toUpperCase() != widget.baseCurrency.toUpperCase();

              return ListView(
                padding: const EdgeInsets.all(AppSpacing.sm),
                children: [
                  // ── Hero Header ──
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Row(
                        children: [
                          _buildAvatar(subscription),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  subscription.name,
                                  style: textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(AppRadii.button),
                                      ),
                                      child: Text(
                                        getCategoryLabel(subscription.category, l10n),
                                        style: textTheme.bodySmall?.copyWith(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: AppSpacing.xs),
                                    Text(
                                      subscription.billingCycle == 'monthly'
                                          ? l10n.monthlyLabel
                                          : l10n.yearlyLabel,
                                      style: textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),

                  // ── Stats Cards ──
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(AppSpacing.sm),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.totalSpentLabel,
                                  style: textTheme.bodySmall,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  hasConversion
                                      ? '${totalSpentBase.toStringAsFixed(2)} ${widget.baseCurrency}'
                                      : '${totalSpentSubscriptionCurrency.toStringAsFixed(2)} ${subscription.currency}',
                                  style: textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                                if (hasConversion) ...[
                                  const SizedBox(height: 2),
                                  Text(
                                    '${totalSpentSubscriptionCurrency.toStringAsFixed(2)} ${subscription.currency}',
                                    style: textTheme.bodySmall,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(AppSpacing.sm),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.priceLabel,
                                  style: textTheme.bodySmall,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${subscription.price.toStringAsFixed(2)} ${subscription.currency}',
                                  style: textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  subscription.billingCycle == 'monthly'
                                      ? l10n.monthlyLabel
                                      : l10n.yearlyLabel,
                                  style: textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),

                  if (subscription.note != null && subscription.note!.isNotEmpty) ...[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.noteLabel,
                              style: textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              subscription.note!,
                              style: textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                  ],

                  // ── Payments History ──
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.paymentsMadeTitle,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          if (payments.isEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                              child: Center(
                                  child: Text(
                                    l10n.noPaymentsRecordedYet,
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                              ),
                            )
                          else
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: payments.length,
                              separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.xs),
                              itemBuilder: (context, index) {
                                final tx = payments[index];
                                return PaymentRow(
                                  paidAmount: tx.paidAmount,
                                  paidCurrency: tx.paidCurrency,
                                  snapshotBaseAmount: tx.snapshotBaseAmount,
                                  snapshotBaseCurrency: tx.snapshotBaseCurrency,
                                  paidAt: tx.paidAt,
                                  subscription: subscription,
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
