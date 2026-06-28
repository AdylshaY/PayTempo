import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/app/widgets/feature_row_widget.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

/// Guest user section: local-data info banner + Pro upsell card.
///
/// Auth is triggered automatically as part of the Pro purchase flow
/// (RevenueCat), so there is no separate "Sign In" button.
class GuestStatusWidget extends StatelessWidget {
  const GuestStatusWidget({super.key});

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
                    l10n.localeName == 'tr'
                        ? 'Tüm verileriniz güvenli bir şekilde yalnızca bu cihazda depolanmaktadır.'
                        : 'All your data is stored securely and only on this device.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
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


