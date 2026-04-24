import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';
import 'package:pay_tempo/data/local/services/subscription_service.dart';
import 'package:pay_tempo/features/subscriptions/subscription_template_picker_screen.dart';
import 'package:pay_tempo/features/subscriptions/data/subscription_categories.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({required this.baseCurrency, super.key});

  final String baseCurrency;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final SubscriptionService _subscriptionService = SubscriptionService();

  Future<void> _openAddSubscription() async {
    final bool? created = await showSubscriptionTemplateBottomSheet(context);

    if (created != true || !mounted) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('PayTempo')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.sm),
            Text('Dashboard', style: textTheme.headlineMedium),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Ana para birimi: ${widget.baseCurrency}',
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bu Ayki Toplam Harcama',
                      style: textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '${widget.baseCurrency} 0.00',
                      style: textTheme.displayLarge,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text('Aktif Abonelikler', style: textTheme.titleMedium),
            const SizedBox(height: AppSpacing.xs),
            Expanded(
              child: StreamBuilder<List<SubscriptionRecord>>(
                stream: _subscriptionService.watchActiveSubscriptions(),
                builder:
                    (
                      BuildContext context,
                      AsyncSnapshot<List<SubscriptionRecord>> snapshot,
                    ) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Abonelikler yuklenemedi.',
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
                            'Henuz abonelik yok. + ile ilk kaydi ekleyin.',
                            style: textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        );
                      }

                      String categoryLabel(String categoryValue) {
                        return subscriptionCategories
                            .firstWhere(
                              (SubscriptionCategoryOption item) =>
                                  item.value == categoryValue,
                              orElse: () => subscriptionCategories.first,
                            )
                            .label;
                      }

                      Widget buildAvatar(SubscriptionRecord item) {
                        final Color backgroundColor =
                            item.avatarColorValue != null
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
                              borderRadius: BorderRadius.circular(
                                AppRadii.button,
                              ),
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
                              borderRadius: BorderRadius.circular(
                                AppRadii.button,
                              ),
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
                            borderRadius: BorderRadius.circular(
                              AppRadii.button,
                            ),
                          ),
                          child: const Icon(
                            Icons.subscriptions_outlined,
                            color: Colors.white,
                          ),
                        );
                      }

                      return ListView.separated(
                        itemCount: items.length,
                        separatorBuilder: (_, index) =>
                            const SizedBox(height: AppSpacing.xs),
                        itemBuilder: (BuildContext context, int index) {
                          final SubscriptionRecord item = items[index];
                          return Card(
                            child: ListTile(
                              leading: buildAvatar(item),
                              title: Text(item.name),
                              subtitle: Text(
                                '${categoryLabel(item.category)} • ${item.price.toStringAsFixed(2)} ${item.currency} - ${item.billingCycle}',
                              ),
                            ),
                          );
                        },
                      );
                    },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddSubscription,
        child: const Icon(Icons.add),
      ),
    );
  }
}
