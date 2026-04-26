import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/data/local/models/user_settings.dart';
import 'package:pay_tempo/features/profile/pro_upgrade_screen.dart';
import 'package:pay_tempo/features/onboarding/data/user_settings_service.dart';

class SettingsWidget extends StatelessWidget {
  SettingsWidget({super.key});

  final Future<UserSettings?> _settingsFuture = UserSettingsService()
      .getSettings();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: FutureBuilder<UserSettings?>(
        future: _settingsFuture,
        builder: (BuildContext context, AsyncSnapshot<UserSettings?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final UserSettings? settings = snapshot.data;
          final bool isPro = settings?.isPro ?? false;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your Account', style: textTheme.titleMedium),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'View and manage your account information.',
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              if (!isPro) ...[
                _UpgradeCard(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const ProUpgradeScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
              Text('Settings', style: textTheme.titleMedium),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Manage your profile and app settings.',
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.currency_exchange),
                  title: const Text('Your Currency'),
                  subtitle: Text(
                    'Selected currency used for totals and reports.',
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  trailing: Text(settings?.baseCurrency ?? 'USD'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _UpgradeCard extends StatelessWidget {
  const _UpgradeCard({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadii.card),
          gradient: LinearGradient(
            colors: <Color>[
              AppColors.primary.withValues(alpha: 0.2),
              AppColors.secondaryHighlight.withValues(alpha: 0.4),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: BoxBorder.all(
            color: AppColors.primary.withValues(alpha: 0.5),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(AppRadii.button),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.workspace_premium_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Text('Unlock Pro', style: textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Enable cloud backup, sync across devices, and advanced analytics insights.',
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                const Icon(Icons.cloud_sync_outlined, size: 16),
                const SizedBox(width: 6),
                Text('Cloud backup', style: textTheme.bodySmall),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                const Icon(Icons.devices_outlined, size: 16),
                const SizedBox(width: 6),
                Text('Multi-device sync', style: textTheme.bodySmall),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                const Icon(Icons.insights_outlined, size: 16),
                const SizedBox(width: 6),
                Text('Advanced analytics', style: textTheme.bodySmall),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onPressed,
                icon: const Icon(Icons.arrow_forward_rounded),
                label: const Text('Go Pro'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
