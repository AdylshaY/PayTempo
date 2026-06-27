import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/app/utils/date_formatter.dart';
import 'package:pay_tempo/app/widgets/feature_row_widget.dart';
import 'package:pay_tempo/data/local/models/user_settings.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

/// Pro active subscription details card: renewal date, plan, feature checklist,
/// and a manage subscription link.
class ProActiveWidget extends StatelessWidget {
  const ProActiveWidget({
    required this.settings,
    this.onManageSubscription,
    super.key,
  });

  final UserSettings? settings;
  final VoidCallback? onManageSubscription;

  String _planLabel(AppLocalizations l10n) {
    final type = settings?.proPlanType ?? 'yearly';
    final price = settings?.proPriceDisplay ?? '';
    final label = type == 'monthly' ? l10n.monthlyLabel : l10n.yearlyLabel;
    return price.isNotEmpty ? '$label · $price' : label;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: AppColors.proGoldCardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.auto_awesome,
                  color: AppColors.proGold,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.proActiveTitle,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    l10n.proActiveActiveBadge,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.success,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Divider(color: AppColors.proGold.withValues(alpha: 0.2), height: 1),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.proActiveExpires,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.success,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        settings?.proExpiryDate?.toMonthDayYearCommaLabel() ??
                            '—',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      l10n.proActivePlan,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _planLabel(l10n),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Divider(color: AppColors.proGold.withValues(alpha: 0.2), height: 1),
            const SizedBox(height: AppSpacing.sm),
            FeatureRowWidget(
              icon: Icons.check_circle_outline,
              text: l10n.proFeatureCloudSync,
              iconColor: AppColors.success,
            ),
            const SizedBox(height: AppSpacing.xs),
            FeatureRowWidget(
              icon: Icons.check_circle_outline,
              text: l10n.proFeature2,
              iconColor: AppColors.success,
            ),
            const SizedBox(height: AppSpacing.xs),
            FeatureRowWidget(
              icon: Icons.check_circle_outline,
              text: l10n.proFeature3,
              iconColor: AppColors.success,
            ),
            const SizedBox(height: AppSpacing.sm),
            InkWell(
              onTap: onManageSubscription,
              child: Row(
                children: [
                  Icon(
                    Icons.open_in_new,
                    size: 16,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      l10n.manageSubscription,
                      style: theme.textTheme.bodySmall?.copyWith(
                        decoration: TextDecoration.underline,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


