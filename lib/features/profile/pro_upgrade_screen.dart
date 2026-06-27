import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/app/widgets/feature_row_widget.dart';
import 'package:pay_tempo/features/onboarding/data/user_settings_service.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class ProUpgradeScreen extends StatelessWidget {
  const ProUpgradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.upgradeToProTitle)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(AppRadii.button),
                            ),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.workspace_premium_rounded,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(l10n.proBenefitsTitle, style: textTheme.titleMedium),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      FeatureRowWidget(
                        icon: Icons.cloud_sync_outlined,
                        text: l10n.proBenefit1,
                        iconColor: AppColors.primary,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      FeatureRowWidget(
                        icon: Icons.devices_outlined,
                        text: l10n.proBenefit2,
                        iconColor: AppColors.primary,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      FeatureRowWidget(
                        icon: Icons.shield_outlined,
                        text: l10n.proBenefit3,
                        iconColor: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                l10n.proOfflineDisclaimer,
                style: textTheme.bodySmall,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await UserSettingsService().setProStatus(
                        isPro: true,
                        userId: 'demo_user',
                      );
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l10n.proUnlockedSuccess),
                          ),
                        );
                        Navigator.of(context).pop();
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                          ),
                        );
                      }
                    }
                  },
                  child: Text(l10n.continueToProLabel),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


