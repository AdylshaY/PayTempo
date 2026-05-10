import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/app/utils/date_formatter.dart';
import 'package:pay_tempo/data/local/models/user_settings.dart';

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

  String _planLabel() {
    final type = settings?.proPlanType ?? 'yearly';
    final price = settings?.proPriceDisplay ?? '';
    final label = type == 'monthly' ? 'Monthly' : 'Yearly';
    return price.isNotEmpty ? '$label · $price' : label;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadii.card),
          gradient: LinearGradient(
            colors: [
              AppColors.proGold.withValues(alpha: 0.12),
              AppColors.proGold.withValues(alpha: 0.04),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: AppColors.proGold.withValues(alpha: 0.3)),
        ),
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
                  'PayTempo Pro',
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
                  child: const Text(
                    'Active',
                    style: TextStyle(
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
                        'Next renewal',
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
                      'Plan',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _planLabel(),
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
            const _ProFeatureCheck(text: 'Cloud synchronization'),
            const SizedBox(height: AppSpacing.xs),
            const _ProFeatureCheck(text: 'Advanced analytics & charts'),
            const SizedBox(height: AppSpacing.xs),
            const _ProFeatureCheck(text: 'Custom categories'),
            const SizedBox(height: AppSpacing.xs),
            const _ProFeatureCheck(text: 'Priority support'),
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
                  Text(
                    'Manage Subscription (App Store / Play Store)',
                    style: theme.textTheme.bodySmall?.copyWith(
                      decoration: TextDecoration.underline,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
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

class _ProFeatureCheck extends StatelessWidget {
  const _ProFeatureCheck({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.check_circle_outline,
          size: 18,
          color: AppColors.success,
        ),
        const SizedBox(width: 8),
        Text(text, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
