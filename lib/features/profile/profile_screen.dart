import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/data/local/models/user_settings.dart';
import 'package:pay_tempo/features/onboarding/data/user_settings_service.dart';
import 'package:pay_tempo/features/profile/widgets/profile_account_section.dart';
import 'package:pay_tempo/features/profile/widgets/settings_widget.dart';
import 'package:pay_tempo/features/profile/pro_upgrade_screen.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final Future<UserSettings?> _settingsFuture;

  @override
  void initState() {
    super.initState();
    _settingsFuture = UserSettingsService().getSettings();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profile),
      ),
      body: SafeArea(
        bottom: false,
        child: FutureBuilder<UserSettings?>(
          future: _settingsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: Column(
                  children: [
                    _buildSkeletonBox(height: 100),
                    const SizedBox(height: AppSpacing.sm),
                    _buildSkeletonBox(height: 160),
                  ],
                ),
              );
            }

            final settings = snapshot.data;

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(AppSpacing.sm, AppSpacing.sm, AppSpacing.sm, 130),
              child: Column(
                children: [
                  ProfileAccountSection(
                    settings: settings,
                    onManageSubscription: () {
                      // TODO: open App Store / Play Store subscription management
                    },
                    onRenewPro: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ProUpgradeScreen(),
                        ),
                      );
                    },
                    onShowPaywall: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ProUpgradeScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  SettingsWidget(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Skeleton placeholder box using Slate 200/300 per DESIGN_SYSTEM.md §5.
Widget _buildSkeletonBox({required double height}) {
  return Container(
    width: double.infinity,
    height: height,
    decoration: BoxDecoration(
      color: AppColors.inactive.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(AppRadii.card),
    ),
  );
}
