import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/features/dashboard/widgets/subscription_list_section_widget.dart';
import 'package:pay_tempo/features/onboarding/data/user_settings_service.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

/// Full-screen view of all active subscriptions.
/// Pushed from the dashboard's "See All" button.
class SubscriptionListScreen extends StatelessWidget {
  const SubscriptionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.activeSubscriptions),
      ),
      body: ValueListenableBuilder<String>(
        valueListenable: UserSettingsService.baseCurrencyNotifier,
        builder: (BuildContext context, String baseCurrency, Widget? _) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.sm,
              AppSpacing.sm,
              AppSpacing.sm,
              AppSpacing.md,
            ),
            children: [
              SubscriptionListSectionWidget(baseCurrency: baseCurrency),
            ],
          );
        },
      ),
    );
  }
}
