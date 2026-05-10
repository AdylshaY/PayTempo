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
    super.key,
  });

  final SubscriptionRecord item;
  final DateTime? dueDateOverride;
  final String? statusLabel;
  final Color? statusColor;



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
    final l10n = AppLocalizations.of(context)!;
    final DateTime dueDate = dueDateOverride ?? item.nextPaymentDate;
    final ({String label, Color color}) status =
        statusLabel == null || statusColor == null
        ? _status(dueDate, context)
        : (label: statusLabel!, color: statusColor!);
    return Card(
      child: ListTile(
        dense: true,
        visualDensity: VisualDensity.compact,
        leading: _avatar(),
        title: Text(item.name),
        subtitle: Text(
          l10n.dueSubtitle(item.price.toStringAsFixed(2), item.currency, dueDate.toMonthDayLabel()),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xs,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: status.color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppRadii.button),
          ),
          child: Text(
            status.label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: status.color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}