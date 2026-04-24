import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';
import 'package:pay_tempo/features/dashboard/widgets/subscription_list_item_widget.dart';
import 'package:pay_tempo/features/subscriptions/data/services/subscription_service.dart';

class SubscriptionListSectionWidget extends StatelessWidget {
  const SubscriptionListSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final SubscriptionService subscriptionService = SubscriptionService();

    return Expanded(
      child: StreamBuilder<List<SubscriptionRecord>>(
        stream: subscriptionService.watchActiveSubscriptions(),
        builder:
            (
              BuildContext context,
              AsyncSnapshot<List<SubscriptionRecord>> snapshot,
            ) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Subscriptions failed to load.',
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                );
              }

              final List<SubscriptionRecord> items =
                  snapshot.data ?? <SubscriptionRecord>[];
              if (items.isEmpty) {
                return Center(
                  child: Text(
                    'No subscriptions yet. Tap + to add your first one.',
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                );
              }

              return ListView.separated(
                itemCount: items.length,
                separatorBuilder: (_, index) =>
                    const SizedBox(height: AppSpacing.xs),
                itemBuilder: (BuildContext context, int index) {
                  return SubscriptionListItemWidget(item: items[index]);
                },
              );
            },
      ),
    );
  }
}