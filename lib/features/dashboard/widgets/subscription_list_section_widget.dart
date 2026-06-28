import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/app/widgets/empty_state_widget.dart';
import 'package:pay_tempo/app/widgets/app_segmented_control.dart';
import 'package:pay_tempo/data/local/isar_database.dart';
import 'package:pay_tempo/data/local/models/payment_transaction.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';
import 'package:pay_tempo/data/local/services/exchange_rate_service.dart';
import 'package:pay_tempo/features/dashboard/utils/due_date_resolver.dart';
import 'package:pay_tempo/features/dashboard/widgets/subscription_list_item_widget.dart';
import 'package:pay_tempo/features/dashboard/sheets/mark_subscription_paid_sheet.dart';
import 'package:pay_tempo/features/dashboard/sheets/subscription_detail_sheet.dart';
import 'package:pay_tempo/features/subscriptions/subscription_manage_screen.dart';
import 'package:pay_tempo/features/subscriptions/data/services/subscription_service.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

enum SubscriptionSortOption {
  dueDate,
  name,
  priceHighToLow,
  priceLowToHigh,
}

class SubscriptionListSectionWidget extends StatefulWidget {
  const SubscriptionListSectionWidget({
    required this.baseCurrency,
    super.key,
  });

  final String baseCurrency;

  @override
  State<SubscriptionListSectionWidget> createState() =>
      _SubscriptionListSectionWidgetState();
}

class _SubscriptionListSectionWidgetState
    extends State<SubscriptionListSectionWidget> {
  String _searchQuery = '';
  SubscriptionSortOption _sortOption = SubscriptionSortOption.dueDate;
  bool _showPaused = false;

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
          baseCurrency: widget.baseCurrency,
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
          baseCurrency: widget.baseCurrency,
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
            baseCurrency: widget.baseCurrency,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final SubscriptionService subscriptionService = SubscriptionService();
    final isar = LocalDatabase.instance.isar;
    final DateTime now = DateTime.now();
    final DateTime monthStart = DateTime(now.year, now.month);
    final DateTime nextMonthStart = DateTime(now.year, now.month + 1);
    final l10n = AppLocalizations.of(context)!;

    return StreamBuilder<List<SubscriptionRecord>>(
      stream: subscriptionService.watchAllSubscriptions(),
      builder:
          (
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
                if (snapshot.hasError || paymentsSnapshot.hasError) {
                  return Text(
                    l10n.activeSubscriptionsFailed,
                    style: textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  );
                }

                final List<SubscriptionRecord> allItems =
                    List<SubscriptionRecord>.from(snapshot.data ?? <SubscriptionRecord>[]);

                if (allItems.isEmpty) {
                  return Card(
                    child: EmptyStateWidget(
                      icon: Icons.card_membership_rounded,
                      title: l10n.activeSubscriptions,
                      message: l10n.noActiveSubscriptions,
                    ),
                  );
                }

                final Map<String, PaymentTransaction> paidThisMonthBySubscription =
                    <String, PaymentTransaction>{
                  for (final PaymentTransaction payment
                      in paymentsSnapshot.data ?? const <PaymentTransaction>[])
                    if (!payment.paidAt.isBefore(monthStart) &&
                        payment.paidAt.isBefore(nextMonthStart))
                      payment.subscriptionUid: payment,
                };

                // 1. Filter by pause state and search query
                final String query = _searchQuery.trim().toLowerCase();
                final List<SubscriptionRecord> filteredItems = allItems.where((sub) {
                  if (sub.isPaused != _showPaused) return false;
                  return query.isEmpty || sub.name.toLowerCase().contains(query);
                }).toList();

                // 2. Sort filtered items based on sort option
                filteredItems.sort((SubscriptionRecord left, SubscriptionRecord right) {
                  switch (_sortOption) {
                    case SubscriptionSortOption.dueDate:
                      final DateTime leftDueDate = resolveEffectiveDueDate(
                        subscription: left,
                        now: now,
                        isPaidThisMonth:
                            paidThisMonthBySubscription.containsKey(left.uid),
                      );
                      final DateTime rightDueDate = resolveEffectiveDueDate(
                        subscription: right,
                        now: now,
                        isPaidThisMonth:
                            paidThisMonthBySubscription.containsKey(right.uid),
                      );
                      return leftDueDate.compareTo(rightDueDate);
                    case SubscriptionSortOption.name:
                      return left.name.toLowerCase().compareTo(right.name.toLowerCase());
                    case SubscriptionSortOption.priceHighToLow:
                      final double leftBase = ExchangeRateService.instance.convert(
                        left.price,
                        left.currency,
                        widget.baseCurrency,
                      );
                      final double rightBase = ExchangeRateService.instance.convert(
                        right.price,
                        right.currency,
                        widget.baseCurrency,
                      );
                      return rightBase.compareTo(leftBase);
                    case SubscriptionSortOption.priceLowToHigh:
                      final double leftBase = ExchangeRateService.instance.convert(
                        left.price,
                        left.currency,
                        widget.baseCurrency,
                      );
                      final double rightBase = ExchangeRateService.instance.convert(
                        right.price,
                        right.currency,
                        widget.baseCurrency,
                      );
                      return leftBase.compareTo(rightBase);
                  }
                });

                final int activeCount = allItems.where((s) => !s.isPaused).length;
                final int pausedCount = allItems.where((s) => s.isPaused).length;

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _showPaused ? l10n.pausedSubscriptions : l10n.activeSubscriptions,
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              l10n.totalItems(filteredItems.length),
                              style: textTheme.bodySmall,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        AppSegmentedControl<bool>(
                          width: double.infinity,
                          tabs: [
                            AppSegmentedTab<bool>(
                              value: false,
                              label: '${l10n.activeStatus} ($activeCount)',
                              icon: Icons.check_circle_outline_rounded,
                            ),
                            AppSegmentedTab<bool>(
                              value: true,
                              label: '${l10n.pausedStatus} ($pausedCount)',
                              icon: Icons.pause_circle_outline_rounded,
                            ),
                          ],
                          selectedValue: _showPaused,
                          onValueChanged: (bool val) {
                            setState(() {
                              _showPaused = val;
                            });
                          },
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                style: textTheme.bodyMedium,
                                onChanged: (String value) {
                                  setState(() {
                                    _searchQuery = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: l10n.searchActiveSubscriptions,
                                  prefixIcon: const Icon(Icons.search, size: 20),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.sm,
                                    vertical: 8,
                                  ),
                                  suffixIcon: _searchQuery.isEmpty
                                      ? null
                                      : IconButton(
                                          icon: const Icon(Icons.clear, size: 18),
                                          onPressed: () {
                                            HapticFeedback.lightImpact();
                                            setState(() {
                                              _searchQuery = '';
                                            });
                                          },
                                        ),
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            PopupMenuButton<SubscriptionSortOption>(
                              icon: const Icon(Icons.swap_vert_rounded),
                              tooltip: l10n.sortBy,
                              onSelected: (SubscriptionSortOption option) {
                                HapticFeedback.lightImpact();
                                setState(() {
                                  _sortOption = option;
                                });
                              },
                              itemBuilder: (BuildContext context) => [
                                PopupMenuItem(
                                  value: SubscriptionSortOption.dueDate,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today_rounded,
                                        size: 18,
                                        color: _sortOption == SubscriptionSortOption.dueDate
                                            ? AppColors.primary
                                            : null,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        l10n.sortByDueDate,
                                        style: TextStyle(
                                          color: _sortOption == SubscriptionSortOption.dueDate
                                              ? AppColors.primary
                                              : null,
                                          fontWeight: _sortOption == SubscriptionSortOption.dueDate
                                              ? FontWeight.bold
                                              : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: SubscriptionSortOption.name,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.sort_by_alpha_rounded,
                                        size: 18,
                                        color: _sortOption == SubscriptionSortOption.name
                                            ? AppColors.primary
                                            : null,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        l10n.sortByName,
                                        style: TextStyle(
                                          color: _sortOption == SubscriptionSortOption.name
                                              ? AppColors.primary
                                              : null,
                                          fontWeight: _sortOption == SubscriptionSortOption.name
                                              ? FontWeight.bold
                                              : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: SubscriptionSortOption.priceHighToLow,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.trending_down_rounded,
                                        size: 18,
                                        color: _sortOption == SubscriptionSortOption.priceHighToLow
                                            ? AppColors.primary
                                            : null,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        l10n.sortByPriceHigh,
                                        style: TextStyle(
                                          color: _sortOption == SubscriptionSortOption.priceHighToLow
                                              ? AppColors.primary
                                              : null,
                                          fontWeight: _sortOption == SubscriptionSortOption.priceHighToLow
                                              ? FontWeight.bold
                                              : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: SubscriptionSortOption.priceLowToHigh,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.trending_up_rounded,
                                        size: 18,
                                        color: _sortOption == SubscriptionSortOption.priceLowToHigh
                                            ? AppColors.primary
                                            : null,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        l10n.sortByPriceLow,
                                        style: TextStyle(
                                          color: _sortOption == SubscriptionSortOption.priceLowToHigh
                                              ? AppColors.primary
                                              : null,
                                          fontWeight: _sortOption == SubscriptionSortOption.priceLowToHigh
                                              ? FontWeight.bold
                                              : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        if (filteredItems.isEmpty)
                          EmptyStateWidget(
                            icon: _showPaused
                                ? Icons.pause_circle_outline_rounded
                                : Icons.search_off_rounded,
                            title: _showPaused
                                ? l10n.pausedSubscriptions
                                : l10n.activeSubscriptions,
                            message: _showPaused
                                ? (l10n.localeName == 'tr'
                                    ? 'Duraklatılmış aboneliğiniz bulunmuyor.'
                                    : 'No paused subscriptions found.')
                                : l10n.noSubscriptionsMatchSearch,
                          )
                        else
                          ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredItems.length,
                            separatorBuilder: (_, index) =>
                                const SizedBox(height: AppSpacing.xs),
                            itemBuilder: (BuildContext context, int index) {
                              final SubscriptionRecord item = filteredItems[index];
                              final PaymentTransaction? payment =
                                  paidThisMonthBySubscription[item.uid];
                              final DateTime effectiveDueDate = resolveEffectiveDueDate(
                                subscription: item,
                                now: now,
                                isPaidThisMonth: payment != null,
                              );

                              final Widget card = SubscriptionListItemWidget(
                                item: item,
                                dueDateOverride: effectiveDueDate,
                                statusLabel: payment == null ? null : l10n.paidLabel,
                                statusColor: payment == null ? null : AppColors.success,
                                onTap: () => _openDetailSheet(
                                  context,
                                  item,
                                  isPaidThisMonth: payment != null,
                                ),
                              );

                              return Dismissible(
                                key: ValueKey<String>(item.uid),
                                direction: DismissDirection.endToStart,
                                confirmDismiss: (_) async {
                                  if (payment != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(l10n.alreadyRecordedThisMonth),
                                      ),
                                    );
                                    return false;
                                  }

                                  await _openPaidSheet(context, item);
                                  return false;
                                },
                                background: const SizedBox.shrink(),
                                secondaryBackground: Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.md,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.success.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(AppRadii.card),
                                  ),
                                  child: const Icon(
                                    Icons.check_circle_outline,
                                    color: AppColors.success,
                                  ),
                                ),
                                child: card,
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
}