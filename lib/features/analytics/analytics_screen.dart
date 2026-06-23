import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/data/local/isar_database.dart';
import 'package:pay_tempo/data/local/models/payment_transaction.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';
import 'package:pay_tempo/data/local/models/user_settings.dart';
import 'package:pay_tempo/features/profile/pro_upgrade_screen.dart';
import 'package:pay_tempo/features/analytics/widgets/donut_chart_painter.dart';
import 'package:pay_tempo/features/analytics/widgets/category_spending_list.dart';
import 'package:pay_tempo/features/analytics/widgets/billing_cycle_breakdown.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;
    final isar = LocalDatabase.instance.isar;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.analytics),
      ),
      body: StreamBuilder<UserSettings?>(
        stream: isar.userSettings.watchObject(1, fireImmediately: true),
        builder: (context, settingsSnapshot) {
          final settings = settingsSnapshot.data;
          final bool isPro = settings?.isPro ?? false;
          final String baseCurrency = (settings?.baseCurrency.trim().isNotEmpty ?? false)
              ? settings!.baseCurrency.trim().toUpperCase()
              : 'USD';

          if (!isPro) {
            return Stack(
              children: [
                ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Opacity(
                    opacity: 0.3,
                    child: AbsorbPointer(
                      child: _buildMockChartsPreview(context),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      decoration: BoxDecoration(
                        color: (isDark ? AppColors.surfaceDark : AppColors.surface).withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(AppRadii.card),
                        border: Border.all(color: AppColors.proGold.withValues(alpha: 0.3)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.workspace_premium_rounded,
                            color: AppColors.proGold,
                            size: 48,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            l10n.proActiveTitle,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.proGold,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            l10n.proUnlockMessage,
                            textAlign: TextAlign.center,
                            style: textTheme.bodyMedium?.copyWith(
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const ProUpgradeScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.proGold,
                                foregroundColor: Colors.black87,
                              ),
                              child: Text(
                                l10n.viewProPlans,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          // Fetch subscriptions and payments reactively
          return StreamBuilder<List<SubscriptionRecord>>(
            stream: isar.subscriptionRecords
                .filter()
                .isDeletedEqualTo(false)
                .watch(fireImmediately: true),
            builder: (context, subscriptionsSnapshot) {
              return StreamBuilder<List<PaymentTransaction>>(
                stream: isar.paymentTransactions
                    .filter()
                    .isDeletedEqualTo(false)
                    .watch(fireImmediately: true),
                builder: (context, paymentsSnapshot) {
                  if (subscriptionsSnapshot.connectionState == ConnectionState.waiting ||
                      paymentsSnapshot.connectionState == ConnectionState.waiting) {
                    return _buildLoadingSkeleton();
                  }

                  final subscriptions = subscriptionsSnapshot.data ?? [];
                  final payments = paymentsSnapshot.data ?? [];

                  final now = DateTime.now();
                  final monthStart = DateTime(now.year, now.month, 1);
                  final nextMonthStart = DateTime(now.year, now.month + 1, 1);

                  // Map subscription uid to object for fast category lookup
                  final Map<String, SubscriptionRecord> subMap = {
                    for (final sub in subscriptions) sub.uid: sub
                  };

                  // Filter payments for this month
                  final currentMonthPayments = payments.where((tx) {
                    return !tx.paidAt.isBefore(monthStart) && tx.paidAt.isBefore(nextMonthStart);
                  }).toList();

                  // 1. Group current month spending by category
                  final Map<String, double> categorySums = {};
                  double totalAmount = 0.0;

                  for (final tx in currentMonthPayments) {
                    final sub = subMap[tx.subscriptionUid];
                    final String category = sub?.category ?? 'Other';
                    categorySums[category] = (categorySums[category] ?? 0.0) + tx.snapshotBaseAmount;
                    totalAmount += tx.snapshotBaseAmount;
                  }

                  // Resolve category colors
                  Color getCategoryColor(String category) {
                    switch (category.toLowerCase()) {
                      case 'streaming':
                        return const Color(0xFFEF4444);
                      case 'music':
                        return const Color(0xFF10B981);
                      case 'video':
                        return const Color(0xFFF59E0B);
                      case 'cloud':
                        return const Color(0xFF3B82F6);
                      case 'ai':
                        return const Color(0xFF8B5CF6);
                      case 'productivity':
                        return const Color(0xFFEC4899);
                      case 'gaming':
                        return const Color(0xFF06B6D4);
                      case 'news':
                        return const Color(0xFF64748B);
                      default:
                        return const Color(0xFF94A3B8);
                    }
                  }

                  final List<DonutChartData> donutDataList = categorySums.entries.map((entry) {
                    return DonutChartData(
                      category: entry.key,
                      amount: entry.value,
                      color: getCategoryColor(entry.key),
                    );
                  }).toList();

                  // Sort by amount descending
                  donutDataList.sort((a, b) => b.amount.compareTo(a.amount));



                  return SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(AppSpacing.sm, AppSpacing.sm, AppSpacing.sm, 130),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category distribution section
                        Text(
                          l10n.spendingByCategory,
                          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        if (donutDataList.isEmpty)
                          _buildEmptyState(context, l10n.noDataForAnalytics)
                        else
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(AppSpacing.sm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CustomPaint(
                                            size: const Size(110, 110),
                                            painter: DonutChartPainter(
                                              dataList: donutDataList,
                                              strokeWidth: 16.0,
                                            ),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                totalAmount.toStringAsFixed(0),
                                                style: textTheme.titleMedium?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                baseCurrency,
                                                style: textTheme.bodySmall?.copyWith(
                                                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: AppSpacing.sm),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              l10n.totalSpending,
                                              style: textTheme.bodySmall?.copyWith(
                                                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              '${totalAmount.toStringAsFixed(2)} $baseCurrency',
                                              style: textTheme.titleMedium?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: AppSpacing.md),
                                  CategorySpendingList(
                                    dataList: donutDataList,
                                    baseCurrency: baseCurrency,
                                  ),
                                ],
                              ),
                            ),
                          ),

                        const SizedBox(height: AppSpacing.md),
                        BillingCycleBreakdown(
                          subscriptions: subscriptions,
                          baseCurrency: baseCurrency,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildMockChartsPreview(BuildContext context) {
    final mockDonutData = [
      const DonutChartData(category: 'Streaming', amount: 50, color: Color(0xFFEF4444)),
      const DonutChartData(category: 'Music', amount: 25, color: Color(0xFF10B981)),
      const DonutChartData(category: 'Cloud', amount: 15, color: Color(0xFF3B82F6)),
    ];
    final mockSubscriptions = [
      SubscriptionRecord(
        uid: 'mock-1',
        name: 'Netflix',
        category: 'Streaming',
        price: 15.49,
        currency: 'USD',
        billingCycle: 'monthly',
        anchorDay: 15,
        nextPaymentDate: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      SubscriptionRecord(
        uid: 'mock-2',
        name: 'Amazon Prime',
        category: 'Streaming',
        price: 139.00,
        currency: 'USD',
        billingCycle: 'yearly',
        anchorDay: 1,
        nextPaymentDate: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Spending by Category', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: AppSpacing.sm),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomPaint(
                        size: const Size(100, 100),
                        painter: DonutChartPainter(dataList: mockDonutData, strokeWidth: 14.0),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Spending'),
                          Text('90.00 USD', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          BillingCycleBreakdown(
            subscriptions: mockSubscriptions,
            baseCurrency: 'USD',
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, String message) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md, horizontal: AppSpacing.sm),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(
          color: isDark
              ? AppColors.inactiveDark.withValues(alpha: 0.2)
              : AppColors.inactive.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.analytics_outlined,
            size: 48,
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            message,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingSkeleton() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}