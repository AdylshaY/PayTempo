import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/data/local/services/exchange_rate_service.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class OfflineStatusBanner extends StatelessWidget {
  const OfflineStatusBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return ListenableBuilder(
      listenable: Listenable.merge([
        ExchangeRateService.isOfflineNotifier,
        ExchangeRateService.lastUpdateNotifier,
      ]),
      builder: (context, _) {
        final bool isOffline = ExchangeRateService.isOfflineNotifier.value;
        final DateTime? lastUpdate = ExchangeRateService.lastUpdateNotifier.value;

        if (!isOffline) {
          return const SizedBox.shrink();
        }

        final bool hasCache = lastUpdate != null;
        final String message = hasCache
            ? l10n.offlineRatesWarning(
                DateFormat.yMMMd(l10n.localeName).add_Hm().format(lastUpdate),
              )
            : l10n.offlineRatesWarningNoCache;

        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: colorScheme.error.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(AppRadii.card),
              border: Border.all(
                color: colorScheme.error.withValues(alpha: 0.16),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.sm,
              children: [
                Icon(
                  Icons.wifi_off_rounded,
                  color: colorScheme.error,
                  size: 24,
                ),
                Expanded(
                  child: Text(
                    message,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
