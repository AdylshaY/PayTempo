import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/data/local/models/user_settings.dart';
import 'package:pay_tempo/features/onboarding/data/user_settings_service.dart';

class SettingsWidget extends StatelessWidget {
  SettingsWidget({super.key});

  final Future<UserSettings?> _settingsFuture = UserSettingsService()
      .getSettings();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return FutureBuilder<UserSettings?>(
      future: _settingsFuture,
      builder: (BuildContext context, AsyncSnapshot<UserSettings?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final UserSettings? settings = snapshot.data;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
    );
  }
}
