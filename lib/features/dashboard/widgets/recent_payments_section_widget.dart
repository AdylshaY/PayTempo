import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/app/utils/date_formatter.dart';
import 'package:pay_tempo/data/local/isar_database.dart';
import 'package:pay_tempo/data/local/models/payment_transaction.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';

class RecentPaymentsSectionWidget extends StatelessWidget {
  const RecentPaymentsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final DateTime now = DateTime.now();
    final DateTime monthStart = DateTime(now.year, now.month);
    final DateTime nextMonthStart = DateTime(now.year, now.month + 1);
    final isar = LocalDatabase.instance.isar;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: StreamBuilder<List<SubscriptionRecord>>(
          stream: isar.subscriptionRecords
              .filter()
              .isDeletedEqualTo(false)
              .watch(fireImmediately: true),
          builder:
              (
                BuildContext context,
                AsyncSnapshot<List<SubscriptionRecord>> subscriptionsSnapshot,
              ) {
                return StreamBuilder<List<PaymentTransaction>>(
                  stream: isar.paymentTransactions
                      .filter()
                      .isDeletedEqualTo(false)
                      .watch(fireImmediately: true),
                  builder:
                      (
                        BuildContext context,
                        AsyncSnapshot<List<PaymentTransaction>>
                        paymentsSnapshot,
                      ) {
                        if (subscriptionsSnapshot.hasError ||
                            paymentsSnapshot.hasError) {
                          return Text(
                            'Payments failed to load.',
                            style: textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          );
                        }

                        final Map<String, SubscriptionRecord>
                        subscriptionByUid = <String, SubscriptionRecord>{
                          for (final SubscriptionRecord subscription
                              in subscriptionsSnapshot.data ??
                                  const <SubscriptionRecord>[])
                            subscription.uid: subscription,
                        };

                        final List<PaymentTransaction> items =
                            (paymentsSnapshot.data ??
                                    const <PaymentTransaction>[])
                                .where((PaymentTransaction item) {
                                  return !item.paidAt.isBefore(monthStart) &&
                                      item.paidAt.isBefore(nextMonthStart);
                                })
                                .toList(growable: false)
                              ..sort((
                                PaymentTransaction left,
                                PaymentTransaction right,
                              ) {
                                return right.paidAt.compareTo(left.paidAt);
                              });

                        if (items.isEmpty) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Payments made',
                                style: textTheme.titleMedium,
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                'No payments were recorded this month yet.',
                                style: textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          );
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Payments made',
                                  style: textTheme.titleMedium,
                                ),
                                Text(
                                  '${items.length} recorded',
                                  style: textTheme.bodySmall?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              'Completed payments for the current month.',
                              style: textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: items.length,
                              separatorBuilder: (_, index) =>
                                  const SizedBox(height: AppSpacing.xs),
                              itemBuilder: (BuildContext context, int index) {
                                final PaymentTransaction item = items[index];
                                final SubscriptionRecord? subscription =
                                    subscriptionByUid[item.subscriptionUid];

                                return _RecentPaymentListItem(
                                  subscriptionName:
                                      subscription?.name ??
                                      'Unknown subscription',
                                  paidAmount: item.paidAmount,
                                  paidCurrency: item.paidCurrency,
                                  snapshotBaseAmount: item.snapshotBaseAmount,
                                  snapshotBaseCurrency:
                                      item.snapshotBaseCurrency,
                                  paidAt: item.paidAt,
                                );
                              },
                            ),
                          ],
                        );
                      },
                );
              },
        ),
      ),
    );
  }
}

class _RecentPaymentListItem extends StatelessWidget {
  const _RecentPaymentListItem({
    required this.subscriptionName,
    required this.paidAmount,
    required this.paidCurrency,
    required this.snapshotBaseAmount,
    required this.snapshotBaseCurrency,
    required this.paidAt,
  });

  final String subscriptionName;
  final double paidAmount;
  final String paidCurrency;
  final double snapshotBaseAmount;
  final String snapshotBaseCurrency;
  final DateTime paidAt;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final String label = subscriptionName.trim().isEmpty
        ? '?'
        : subscriptionName.trim()[0].toUpperCase();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppRadii.button),
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subscriptionName, style: textTheme.bodyMedium),
                const SizedBox(height: 2),
                Text(
                  '${paidAmount.toStringAsFixed(2)} $paidCurrency • ${paidAt.toMonthDayLabel()}',
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${snapshotBaseAmount.toStringAsFixed(2)} $snapshotBaseCurrency',
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Recorded',
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
