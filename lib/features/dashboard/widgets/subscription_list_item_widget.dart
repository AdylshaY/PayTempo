import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';
import 'package:pay_tempo/features/subscriptions/data/subscription_categories.dart';

class SubscriptionListItemWidget extends StatelessWidget {
  const SubscriptionListItemWidget({
    required this.item,
    super.key,
  });

  final SubscriptionRecord item;

  String _categoryLabel(String categoryValue) {
    return subscriptionCategories
        .firstWhere(
          (SubscriptionCategoryOption option) => option.value == categoryValue,
          orElse: () => subscriptionCategories.first,
        )
        .label;
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
    return Card(
      child: ListTile(
        leading: _avatar(),
        title: Text(item.name),
        subtitle: Text(
          '${_categoryLabel(item.category)} • ${item.price.toStringAsFixed(2)} ${item.currency} - ${item.billingCycle}',
        ),
      ),
    );
  }
}