import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/app/utils/date_formatter.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';

class PaymentRow extends StatelessWidget {
  const PaymentRow({
    super.key,
    required this.paidAmount,
    required this.paidCurrency,
    required this.snapshotBaseAmount,
    required this.snapshotBaseCurrency,
    required this.paidAt,
    required this.subscription,
  });

  final double paidAmount;
  final String paidCurrency;
  final double snapshotBaseAmount;
  final String snapshotBaseCurrency;
  final DateTime paidAt;
  final SubscriptionRecord subscription;

  Widget _avatar() {
    final Color backgroundColor = subscription.avatarColorValue != null
        ? Color(subscription.avatarColorValue!)
        : AppColors.primary;

    if (subscription.avatarType == 'emoji' &&
        subscription.avatarEmoji != null &&
        subscription.avatarEmoji!.isNotEmpty) {
      return Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppRadii.button),
        ),
        alignment: Alignment.center,
        child: Text(
          subscription.avatarEmoji!,
          style: const TextStyle(fontSize: 20),
        ),
      );
    }

    if (subscription.avatarIconCodePoint != null) {
      return Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppRadii.button),
        ),
        child: Icon(
          IconData(
            subscription.avatarIconCodePoint!,
            fontFamily: subscription.avatarIconFontFamily,
            fontPackage: subscription.avatarIconFontPackage,
          ),
          color: Colors.white,
        ),
      );
    }

    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadii.button),
      ),
      child: const Icon(Icons.subscriptions_outlined, color: Colors.white),
    );
  }



  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final String label = subscription.name.trim().isEmpty
        ? '?'
        : subscription.name.trim()[0].toUpperCase();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppRadii.button),
            ),
            alignment: Alignment.center,
            child: _avatar(),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subscription.name, style: textTheme.bodyMedium),
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
