import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';

class PaymentRow extends StatelessWidget {
  const PaymentRow({super.key, 
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

  String _dateLabel(DateTime date) {
    const List<String> months = <String>[
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}';
  }

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
            width: 40,
            height: 40,
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
                  '${paidAmount.toStringAsFixed(2)} $paidCurrency • ${_dateLabel(paidAt)}',
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
