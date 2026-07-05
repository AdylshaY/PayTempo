import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/app/utils/currency_formatter.dart';
import 'package:pay_tempo/features/subscriptions/data/subscription_categories.dart';
import 'package:pay_tempo/features/subscriptions/data/services/category_service.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';
import 'donut_chart_painter.dart';

class CategorySpendingList extends StatelessWidget {
  final List<DonutChartData> dataList;
  final String baseCurrency;

  const CategorySpendingList({
    super.key,
    required this.dataList,
    required this.baseCurrency,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final double totalAmount = dataList.fold(0.0, (sum, item) => sum + item.amount);

    return Column(
      children: dataList.map((data) {
        final double percentage = totalAmount > 0 ? (data.amount / totalAmount) : 0.0;
        final String localizedName = getCategoryLabel(data.category, l10n);
        final icon = CategoryService.instance.getIconForCategory(data.category);

        
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: data.color.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 16,
                      color: data.color,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      localizedName,
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    CurrencyFormatter.format(data.amount, baseCurrency),
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    '(${(percentage * 100).toStringAsFixed(0)}%)',
                    style: textTheme.bodySmall?.copyWith(
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                    ),
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
                          ? AppColors.inactiveDark.withValues(alpha: 0.3)
                          : AppColors.inactive.withValues(alpha: 0.3),
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
                          color: data.color,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
