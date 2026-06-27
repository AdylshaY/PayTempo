import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/app/widgets/empty_state_widget.dart';
import 'package:pay_tempo/data/local/isar_database.dart';
import 'package:pay_tempo/data/local/models/payment_transaction.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';
import 'package:pay_tempo/features/dashboard/sheets/mark_subscription_paid_sheet.dart';
import 'package:pay_tempo/features/dashboard/sheets/subscription_detail_sheet.dart';
import 'package:pay_tempo/features/dashboard/utils/due_date_resolver.dart';
import 'package:pay_tempo/features/dashboard/widgets/subscription_list_item_widget.dart';
import 'package:pay_tempo/features/subscriptions/data/services/subscription_service.dart';
import 'package:pay_tempo/features/subscriptions/subscription_manage_screen.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

/// Maximum number of upcoming items shown on dashboard.
const int _maxUpcomingItems = 5;

class UpcomingPaymentsWidget extends StatelessWidget {
  const UpcomingPaymentsWidget({
    required this.baseCurrency,
    required this.onSeeAll,
    super.key,
  });

  final String baseCurrency;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final SubscriptionService subscriptionService = SubscriptionService();
    final isar = LocalDatabase.instance.isar;
    final DateTime now = DateTime.now();
    final l10n = AppLocalizations.of(context)!;

    return StreamBuilder<List<SubscriptionRecord>>(
      stream: subscriptionService.watchActiveSubscriptions(),
      builder: (
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
            final List<SubscriptionRecord> allItems =
                List<SubscriptionRecord>.from(
                    snapshot.data ?? <SubscriptionRecord>[]);

            final DateTime monthStart = DateTime(now.year, now.month);
            final DateTime nextMonthStart =
                DateTime(now.year, now.month + 1);

            final Map<String, PaymentTransaction>
                paidThisMonthBySubscription = <String, PaymentTransaction>{
              for (final PaymentTransaction payment
                  in paymentsSnapshot.data ?? const <PaymentTransaction>[])
                if (!payment.paidAt.isBefore(monthStart) &&
                    payment.paidAt.isBefore(nextMonthStart))
                  payment.subscriptionUid: payment,
            };

            // Filter unpaid subscriptions sorted by due date
            final List<_UpcomingItem> upcomingItems = allItems
                .map((SubscriptionRecord sub) {
                  final bool isPaid =
                      paidThisMonthBySubscription.containsKey(sub.uid);
                  final DateTime dueDate = resolveEffectiveDueDate(
                    subscription: sub,
                    now: now,
                    isPaidThisMonth: isPaid,
                  );
                  return _UpcomingItem(
                    subscription: sub,
                    dueDate: dueDate,
                    isPaid: isPaid,
                    payment: paidThisMonthBySubscription[sub.uid],
                  );
                })
                .where((_UpcomingItem item) => !item.isPaid)
                .toList()
              ..sort((_UpcomingItem a, _UpcomingItem b) =>
                  a.dueDate.compareTo(b.dueDate));

            final int totalCount = allItems.length;
            final List<_UpcomingItem> displayItems =
                upcomingItems.take(_maxUpcomingItems).toList();

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.upcomingPayments,
                          style: textTheme.titleMedium,
                        ),
                        if (totalCount > 0)
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              onSeeAll();
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  l10n.seeAllCount(totalCount),
                                  style: textTheme.bodySmall?.copyWith(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 12,
                                  color: colorScheme.primary,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    if (displayItems.isEmpty)
                      EmptyStateWidget(
                        icon: Icons.celebration_rounded,
                        title: l10n.upcomingPayments,
                        message: l10n.noUpcomingPayments,
                      )
                    else
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: displayItems.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(height: AppSpacing.xs),
                        itemBuilder: (BuildContext context, int index) {
                          final _UpcomingItem item = displayItems[index];

                          return SubscriptionListItemWidget(
                            item: item.subscription,
                            dueDateOverride: item.dueDate,
                            onTap: () => _openDetailSheet(
                              context,
                              item.subscription,
                              isPaidThisMonth: item.isPaid,
                            ),
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

  Future<void> _openDetailSheet(
    BuildContext context,
    SubscriptionRecord subscription, {
    required bool isPaidThisMonth,
  }) async {
    final bool? shouldManage = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext sheetContext) {
        return SubscriptionDetailSheet(
          subscription: subscription,
          baseCurrency: baseCurrency,
          isPaidThisMonth: isPaidThisMonth,
          onMarkPaid: () => _openPaidSheet(context, subscription),
        );
      },
    );

    if (shouldManage == true && context.mounted) {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => SubscriptionManageScreen(
            subscription: subscription,
            baseCurrency: baseCurrency,
          ),
        ),
      );
    }
  }
}

class _UpcomingItem {
  const _UpcomingItem({
    required this.subscription,
    required this.dueDate,
    required this.isPaid,
    this.payment,
  });

  final SubscriptionRecord subscription;
  final DateTime dueDate;
  final bool isPaid;
  final PaymentTransaction? payment;
}
