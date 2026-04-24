import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/data/local/isar_database.dart';
import 'package:pay_tempo/data/local/models/payment_transaction.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';
import 'package:pay_tempo/features/dashboard/utils/due_date_resolver.dart';

class MonthlySpendingCardWidget extends StatelessWidget {
  const MonthlySpendingCardWidget({
    required this.baseCurrency,
    super.key,
  });

  final String baseCurrency;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final DateTime now = DateTime.now();
    final DateTime monthStart = DateTime(now.year, now.month, 1);
    final DateTime nextMonthStart = DateTime(now.year, now.month + 1, 1);
    final isar = LocalDatabase.instance.isar;

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
                    return total + item.price;
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
                      'Paid this month',
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Remaining: ${remainingTotal.toStringAsFixed(2)} $baseCurrency from active subscriptions',
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary.withValues(alpha: 0.75),
                      ),
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