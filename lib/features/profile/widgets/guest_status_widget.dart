import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

/// Guest user section: local-data info banner + Pro upsell card.
///
/// Auth is triggered automatically as part of the Pro purchase flow
/// (RevenueCat), so there is no separate "Sign In" button.
class GuestStatusWidget extends StatelessWidget {
  const GuestStatusWidget({this.onShowPaywall, super.key});

  final VoidCallback? onShowPaywall;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        // Info banner
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  size: 20,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    l10n.guestStatusTitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        // Pro upsell card
        Card(
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
              border: Border.all(
                color: AppColors.proGold.withValues(alpha: 0.3),
              ),
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
                      l10n.tryPro,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                _ProFeatureRow(
                  icon: Icons.cloud_outlined,
                  text: l10n.proFeature1,
                ),
                const SizedBox(height: AppSpacing.xs),
                _ProFeatureRow(
                  icon: Icons.auto_awesome,
                  text: l10n.proFeature2,
                ),
                const SizedBox(height: AppSpacing.xs),
                _ProFeatureRow(
                  icon: Icons.attach_money,
                  text: l10n.proFeature3,
                ),
                const SizedBox(height: AppSpacing.sm),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: onShowPaywall,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.proGold,
                      foregroundColor: Colors.black87,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadii.button),
                      ),
                    ),
                    icon: const Icon(Icons.workspace_premium_outlined),
                    label: Text(
                      l10n.viewProPlans,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ProFeatureRow extends StatelessWidget {
  const _ProFeatureRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: theme.textTheme.bodySmall)),
      ],
    );
  }
}
