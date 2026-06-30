import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/data/local/isar_database.dart';
import 'package:pay_tempo/data/local/models/payment_transaction.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';
import 'package:pay_tempo/data/local/models/user_settings.dart';
import 'package:pay_tempo/features/analytics/widgets/donut_chart_painter.dart';
import 'package:pay_tempo/features/analytics/widgets/category_spending_list.dart';
import 'package:pay_tempo/features/analytics/widgets/billing_cycle_breakdown.dart';
import 'package:pay_tempo/features/subscriptions/data/subscription_categories.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';
import 'package:pay_tempo/features/analytics/widgets/spending_trends_card.dart';
import 'package:pay_tempo/features/analytics/widgets/fixed_costs_card.dart';
import 'package:pay_tempo/features/analytics/widgets/installments_card.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String? _selectedSuperCategory;

  bool isFixedCategory(String category) {
    final cat = category.trim().toLowerCase();
    return cat == 'housing' || cat == 'housing/rent' ||
           cat == 'utilities' || cat == 'bills/utilities' ||
           cat == 'finance' || cat == 'finance/installment';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;
    final isar = LocalDatabase.instance.isar;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: StreamBuilder<UserSettings?>(
        stream: isar.userSettings.watchObject(1, fireImmediately: true),
        builder: (context, settingsSnapshot) {
          final settings = settingsSnapshot.data;
          final String baseCurrency = (settings?.baseCurrency.trim().isNotEmpty ?? false)
              ? settings!.baseCurrency.trim().toUpperCase()
              : 'USD';

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
                  double totalAmount = 0.0;
                  double fixedTotal = 0.0;
                  double subscriptionsTotal = 0.0;

                  final Map<String, double> categorySums = {};

                  for (final tx in currentMonthPayments) {
                    final sub = subMap[tx.subscriptionUid];
                    final String category = sub?.category ?? 'Other';
                    final double amount = tx.snapshotBaseAmount;

                    totalAmount += amount;

                    final bool fixed = isFixedCategory(category);
                    if (fixed) {
                      fixedTotal += amount;
                    } else {
                      subscriptionsTotal += amount;
                    }

                    // If drill-down is active, only sum the matching categories
                    if (_selectedSuperCategory == 'fixed' && fixed) {
                      categorySums[category] = (categorySums[category] ?? 0.0) + amount;
                    } else if (_selectedSuperCategory == 'subscriptions' && !fixed) {
                      categorySums[category] = (categorySums[category] ?? 0.0) + amount;
                    }
                  }

                  final List<DonutChartData> donutDataList = [];

                  if (_selectedSuperCategory == null) {
                    if (fixedTotal > 0) {
                      donutDataList.add(
                        DonutChartData(
                          category: 'fixed_overhead',
                          amount: fixedTotal,
                          color: const Color(0xFFEF4444), // Red for fixed
                        ),
                      );
                    }
                    if (subscriptionsTotal > 0) {
                      donutDataList.add(
                        DonutChartData(
                          category: 'digital_subscriptions',
                          amount: subscriptionsTotal,
                          color: const Color(0xFF3B82F6), // Blue for subscriptions
                        ),
                      );
                    }
                  } else {
                    categorySums.forEach((category, sum) {
                      donutDataList.add(
                        DonutChartData(
                          category: category,
                          amount: sum,
                          color: getCategoryColor(category),
                        ),
                      );
                    });
                    donutDataList.sort((a, b) => b.amount.compareTo(a.amount));
                  }

                  final double activeDisplayTotal = _selectedSuperCategory == 'fixed'
                      ? fixedTotal
                      : (_selectedSuperCategory == 'subscriptions' ? subscriptionsTotal : totalAmount);

                  return SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(AppSpacing.sm, AppSpacing.sm, AppSpacing.sm, 130),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category distribution section
                        Row(
                          children: [
                            if (_selectedSuperCategory != null)
                              IconButton(
                                icon: const Icon(Icons.arrow_back_rounded),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                style: const ButtonStyle(
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _selectedSuperCategory = null;
                                  });
                                },
                              ),
                            if (_selectedSuperCategory != null)
                              const SizedBox(width: AppSpacing.xs),
                            Text(
                              _selectedSuperCategory == 'fixed'
                                  ? (l10n.localeName == 'tr' ? 'Sabit Giderler Kırılımı' : 'Fixed Overhead Breakdown')
                                  : (_selectedSuperCategory == 'subscriptions'
                                      ? (l10n.localeName == 'tr' ? 'Abonelikler Kırılımı' : 'Subscriptions Breakdown')
                                      : l10n.spendingByCategory),
                              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        if (_selectedSuperCategory != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            _selectedSuperCategory == 'fixed'
                                ? (l10n.localeName == 'tr'
                                    ? 'Kira, fatura ve taksitler gibi sabit maliyetlerinizin dağılımı.'
                                    : 'Breakdown of your fixed costs, bills, and installments.')
                                : (l10n.localeName == 'tr'
                                    ? 'Yazılım, dijital servis ve eğlence üyeliklerinizin dağılımı.'
                                    : 'Distribution of software, digital services, and entertainment subscriptions.'),
                            style: textTheme.bodySmall?.copyWith(
                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                            ),
                          ),
                        ],
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
                                                activeDisplayTotal.toStringAsFixed(0),
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
                                              '${activeDisplayTotal.toStringAsFixed(2)} $baseCurrency',
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
                                   AnimatedSwitcher(
                                     duration: const Duration(milliseconds: 300),
                                     child: _selectedSuperCategory == null
                                         ? Column(
                                             key: const ValueKey('super_category_view'),
                                             children: [
                                               if (fixedTotal > 0)
                                                 _buildSuperCategoryRow(
                                                   context: context,
                                                   title: l10n.localeName == 'tr' ? 'Sabit Giderler' : 'Fixed Expenses',
                                                   amount: fixedTotal,
                                                   total: totalAmount,
                                                   color: const Color(0xFFEF4444),
                                                   icon: Icons.home_work_outlined,
                                                   onTap: () {
                                                     setState(() {
                                                       _selectedSuperCategory = 'fixed';
                                                     });
                                                   },
                                                   baseCurrency: baseCurrency,
                                                 ),
                                               if (fixedTotal > 0 && subscriptionsTotal > 0)
                                                 const SizedBox(height: AppSpacing.sm),
                                               if (subscriptionsTotal > 0)
                                                 _buildSuperCategoryRow(
                                                   context: context,
                                                   title: l10n.localeName == 'tr' ? 'Abonelikler' : 'Subscriptions',
                                                   amount: subscriptionsTotal,
                                                   total: totalAmount,
                                                   color: const Color(0xFF3B82F6),
                                                   icon: Icons.subscriptions_outlined,
                                                   onTap: () {
                                                     setState(() {
                                                       _selectedSuperCategory = 'subscriptions';
                                                     });
                                                   },
                                                   baseCurrency: baseCurrency,
                                                 ),
                                             ],
                                           )
                                         : CategorySpendingList(
                                             key: const ValueKey('detail_category_view'),
                                             dataList: donutDataList,
                                             baseCurrency: baseCurrency,
                                           ),
                                   ),
                                ],
                              ),
                            ),
                          ),

                        if (_selectedSuperCategory == null || _selectedSuperCategory == 'subscriptions') ...[
                          const SizedBox(height: AppSpacing.md),
                          SpendingTrendsCard(
                            payments: payments.where((tx) {
                              if (_selectedSuperCategory == null) return true;
                              final sub = subMap[tx.subscriptionUid];
                              if (sub == null) return false;
                              final bool fixed = isFixedCategory(sub.category);
                              return _selectedSuperCategory == 'fixed' ? fixed : !fixed;
                            }).toList(),
                            baseCurrency: baseCurrency,
                          ),
                        ],
                        if (_selectedSuperCategory == null || _selectedSuperCategory == 'fixed') ...[
                          const SizedBox(height: AppSpacing.md),
                          FixedCostsCard(
                            subscriptions: subscriptions,
                            payments: payments,
                            baseCurrency: baseCurrency,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          InstallmentsCard(
                            subscriptions: subscriptions,
                            baseCurrency: baseCurrency,
                          ),
                        ],
                        if (_selectedSuperCategory == null || _selectedSuperCategory == 'subscriptions') ...[
                          const SizedBox(height: AppSpacing.md),
                           BillingCycleBreakdown(
                             subscriptions: subscriptions.where((s) {
                               if (s.isPaused) return false;
                               if (_selectedSuperCategory == 'subscriptions') {
                                 return !isFixedCategory(s.category);
                               }
                               return true;
                             }).toList(),
                             baseCurrency: baseCurrency,
                           ),
                        ],
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      ),
    );
  }

  Widget _buildMockChartsPreview(BuildContext context) {
    final mockDonutData = [
      DonutChartData(category: 'Streaming', amount: 50, color: getCategoryColor('streaming')),
      DonutChartData(category: 'Music', amount: 25, color: getCategoryColor('music')),
      DonutChartData(category: 'Cloud', amount: 15, color: getCategoryColor('cloud')),
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
        firstPaymentDate: DateTime.now(),
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
        firstPaymentDate: DateTime.now(),
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
        ],
      ),
    );
  }

  Widget _buildSuperCategoryRow({
    required BuildContext context,
    required String title,
    required double amount,
    required double total,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
    required String baseCurrency,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final double percentage = total > 0 ? (amount / total) : 0.0;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.card / 2),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm, horizontal: AppSpacing.xs),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 18,
                    color: color,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.localeName == 'tr' ? 'Detayları görmek için dokunun' : 'Tap to see details',
                        style: textTheme.bodySmall?.copyWith(
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${amount.toStringAsFixed(2)} $baseCurrency',
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '(${(percentage * 100).toStringAsFixed(0)}%)',
                      style: textTheme.bodySmall?.copyWith(
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: AppSpacing.xs),
                Icon(
                  Icons.chevron_right_rounded,
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Stack(
              children: [
                Container(
                  height: 6,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.inactiveDark.withValues(alpha: 0.2)
                        : AppColors.inactive.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final double filledWidth = constraints.maxWidth * percentage;
                    return Container(
                      height: 6,
                      width: filledWidth,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
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