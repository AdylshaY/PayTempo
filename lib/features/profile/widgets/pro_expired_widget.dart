import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/app/utils/date_formatter.dart';
import 'package:pay_tempo/data/local/models/user_settings.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

/// Pro expired warning card with expiry date and a renew CTA button.
class ProExpiredWidget extends StatelessWidget {
  const ProExpiredWidget({required this.settings, this.onRenewPro, super.key});

  final UserSettings? settings;
  final VoidCallback? onRenewPro;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final price = settings?.proPriceDisplay ?? '\$29.99';
    final String rawPlanType = settings?.proPlanType ?? 'year';
    final String planType = rawPlanType.toLowerCase() == 'monthly' || rawPlanType.toLowerCase() == 'month'
        ? (l10n.localeName == 'tr' ? 'ay' : 'month')
        : (l10n.localeName == 'tr' ? 'yıl' : 'year');

    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadii.card),
          gradient: LinearGradient(
            colors: [
              AppColors.error.withValues(alpha: 0.12),
              AppColors.error.withValues(alpha: 0.04),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppRadii.button),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.warning_rounded,
                    color: AppColors.error,
                    size: 22,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.proExpiredTitle,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: AppColors.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.proExpiredSubtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.6,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      RichText(
                        text: TextSpan(
                          style: theme.textTheme.bodySmall,
                          children: [
                            TextSpan(
                              text: l10n.expiredLabel,
                              style: TextStyle(
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.6,
                                ),
                              ),
                            ),
                            TextSpan(
                              text:
                                  settings?.proExpiryDate
                                      ?.toMonthDayYearCommaLabel(l10n.localeName) ??
                                  '—',
                              style: const TextStyle(
                                color: AppColors.error,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onRenewPro,
                style: AppColors.proGoldButtonStyle(),
                icon: const Icon(Icons.refresh),
                label: Text(
                  '${l10n.renewPro} — $price/$planType',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
