import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/app/utils/date_formatter.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class SubscriptionListItemWidget extends StatelessWidget {
  const SubscriptionListItemWidget({
    required this.item,
    this.dueDateOverride,
    this.statusLabel,
    this.statusColor,
    this.onTap,
    super.key,
  });

  final SubscriptionRecord item;
  final DateTime? dueDateOverride;
  final String? statusLabel;
  final Color? statusColor;
  final VoidCallback? onTap;

  ({String label, Color color}) _status(DateTime nextPaymentDate, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final DateTime now = DateTime.now();
    final DateTime startOfToday = DateTime(now.year, now.month, now.day);
    final DateTime dueDate = DateTime(
      nextPaymentDate.year,
      nextPaymentDate.month,
      nextPaymentDate.day,
    );
    final int daysUntil = dueDate.difference(startOfToday).inDays;

    if (daysUntil < 0) {
      return (label: l10n.overdue, color: AppColors.error);
    }

    if (daysUntil == 0) {
      return (label: l10n.dueToday, color: AppColors.warning);
    }

    if (daysUntil <= 3) {
      return (label: l10n.dueSoon, color: AppColors.warning);
    }

    return (label: l10n.scheduled, color: AppColors.secondaryHighlight);
  }

  Widget _avatar() {
    final Color backgroundColor = item.avatarColorValue != null
        ? Color(item.avatarColorValue!)
        : AppColors.primary;

    if (item.avatarType == 'emoji' &&
        item.avatarEmoji != null &&
        item.avatarEmoji!.isNotEmpty) {
      return Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppRadii.button),
        ),
        alignment: Alignment.center,
        child: Text(
          item.avatarEmoji!,
          style: const TextStyle(fontSize: 20),
        ),
      );
    }

    if (item.avatarIconCodePoint != null) {
      return Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppRadii.button),
        ),
        child: Icon(
          IconData(
            item.avatarIconCodePoint!,
            fontFamily: item.avatarIconFontFamily,
            fontPackage: item.avatarIconFontPackage,
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
      child: const Icon(
        Icons.subscriptions_outlined,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final DateTime dueDate = dueDateOverride ?? item.nextPaymentDate;
    final ({String label, Color color}) status =
        statusLabel == null || statusColor == null
        ? _status(dueDate, context)
        : (label: statusLabel!, color: statusColor!);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final rowColor = isDark ? AppColors.backgroundDark : AppColors.background;

    return Container(
      decoration: BoxDecoration(
        color: rowColor,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadii.card),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                _avatar(),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row 1: Name + Price
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.name,
                              style: textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            '${item.price.toStringAsFixed(2)} ${item.currency}',
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      if (item.note != null && item.note!.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          item.note!,
                          style: textTheme.bodySmall?.copyWith(
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      const SizedBox(height: 4),
                      // Row 2: Due date + Status badge
                      Row(
                        children: [
                          Text(
                            dueDate.toMonthDayLabel(),
                            style: textTheme.bodySmall,
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.xs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: status.color.withValues(alpha: 0.12),
                              borderRadius:
                                  BorderRadius.circular(AppRadii.button),
                            ),
                            child: Text(
                              status.label,
                              style: textTheme.bodySmall?.copyWith(
                                color: status.color,
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                              ),
                            ),
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
      ),
    );
  }
}