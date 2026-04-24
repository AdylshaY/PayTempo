import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/data/local/isar_database.dart';
import 'package:pay_tempo/data/local/models/payment_transaction.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';
import 'package:pay_tempo/features/dashboard/utils/due_date_resolver.dart';
import 'package:pay_tempo/features/dashboard/widgets/subscription_list_item_widget.dart';
import 'package:pay_tempo/features/dashboard/sheets/mark_subscription_paid_sheet.dart';
import 'package:pay_tempo/features/subscriptions/data/services/subscription_service.dart';

class SubscriptionListSectionWidget extends StatelessWidget {
  const SubscriptionListSectionWidget({
    required this.baseCurrency,
    super.key,
  });

  final String baseCurrency;

  Future<void> _openPaidSheet(
    BuildContext context,
    SubscriptionRecord subscription,
  ) async {
    await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext context) {
        return MarkSubscriptionPaidSheet(
          subscription: subscription,
          baseCurrency: baseCurrency,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final SubscriptionService subscriptionService = SubscriptionService();
    final isar = LocalDatabase.instance.isar;
    final DateTime now = DateTime.now();
    final DateTime monthStart = DateTime(now.year, now.month);
    final DateTime nextMonthStart = DateTime(now.year, now.month + 1);

    return StreamBuilder<List<SubscriptionRecord>>(
      stream: subscriptionService.watchActiveSubscriptions(),
      builder:
          (
            BuildContext context,
            AsyncSnapshot<List<SubscriptionRecord>> snapshot,
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
                if (snapshot.hasError || paymentsSnapshot.hasError) {
                  return Text(
                    'Active subscriptions failed to load.',
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  );
                }

                final Map<String, PaymentTransaction> paidThisMonthBySubscription =
                    <String, PaymentTransaction>{
                  for (final PaymentTransaction payment
                      in paymentsSnapshot.data ?? const <PaymentTransaction>[])
                    if (!payment.paidAt.isBefore(monthStart) &&
                        payment.paidAt.isBefore(nextMonthStart))
                      payment.subscriptionUid: payment,
                };

                final List<SubscriptionRecord> items =
                    List<SubscriptionRecord>.from(snapshot.data ?? <SubscriptionRecord>[])
                      ..sort((SubscriptionRecord left, SubscriptionRecord right) {
                        final DateTime leftDueDate = resolveEffectiveDueDate(
                          subscription: left,
                          now: now,
                          isPaidThisMonth:
                              paidThisMonthBySubscription.containsKey(left.uid),
                        );
                        final DateTime rightDueDate = resolveEffectiveDueDate(
                          subscription: right,
                          now: now,
                          isPaidThisMonth:
                              paidThisMonthBySubscription.containsKey(right.uid),
                        );
                        return leftDueDate.compareTo(rightDueDate);
                      });

                if (items.isEmpty) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Active subscriptions', style: textTheme.titleMedium),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            'No active subscriptions yet.',
                            style: textTheme.bodyMedium?.copyWith(
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
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Active subscriptions', style: textTheme.titleMedium),
                            Text(
                              '${items.length} total',
                              style: textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          separatorBuilder: (_, index) =>
                              const SizedBox(height: AppSpacing.xs),
                          itemBuilder: (BuildContext context, int index) {
                            final SubscriptionRecord item = items[index];
                            final PaymentTransaction? payment =
                                paidThisMonthBySubscription[item.uid];
                            final DateTime effectiveDueDate = resolveEffectiveDueDate(
                              subscription: item,
                              now: now,
                              isPaidThisMonth: payment != null,
                            );

                            final Widget card = SubscriptionListItemWidget(
                              item: item,
                              dueDateOverride: effectiveDueDate,
                              statusLabel: payment == null ? null : 'Paid',
                              statusColor: payment == null ? null : AppColors.success,
                            );

                            return Dismissible(
                              key: ValueKey<String>(item.uid),
                              direction: DismissDirection.endToStart,
                              confirmDismiss: (_) async {
                                if (payment != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('You already recorded a payment for this month.'),
                                    ),
                                  );
                                  return false;
                                }

                                await _openPaidSheet(context, item);
                                return false;
                              },
                              background: const SizedBox.shrink(),
                              secondaryBackground: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.md,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.success.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(AppRadii.card),
                                ),
                                child: const Icon(
                                  Icons.check_circle_outline,
                                  color: AppColors.success,
                                ),
                              ),
                              child: card,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
    );
  }
}