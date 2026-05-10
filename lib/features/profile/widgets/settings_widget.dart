import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/data/local/models/user_settings.dart';
import 'package:pay_tempo/features/onboarding/data/user_settings_service.dart';

class SettingsWidget extends StatelessWidget {
  SettingsWidget({super.key});

  final Future<UserSettings?> _settingsFuture = UserSettingsService()
      .getSettings();

  AppThemeMode _flutterModeToAppMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return AppThemeMode.light;
      case ThemeMode.dark:
        return AppThemeMode.dark;
      case ThemeMode.system:
        return AppThemeMode.system;
    }
  }

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
            const SizedBox(height: AppSpacing.xs),
            ValueListenableBuilder<ThemeMode>(
              valueListenable: UserSettingsService.appThemeNotifier,
              builder: (context, themeMode, _) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.palette_outlined),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Appearance',
                                    style: textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Customize your app theme.',
                                    style: textTheme.bodySmall?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        _ThemeSelector(
                          currentMode: _flutterModeToAppMode(themeMode),
                          onChanged: (AppThemeMode mode) {
                            UserSettingsService().setThemeMode(mode);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _ThemeSelector extends StatelessWidget {
  const _ThemeSelector({required this.currentMode, required this.onChanged});

  final AppThemeMode currentMode;
  final ValueChanged<AppThemeMode> onChanged;

  Widget _buildOption(
    BuildContext context,
    String label,
    IconData icon,
    AppThemeMode mode,
  ) {
    final theme = Theme.of(context);
    final isSelected = currentMode == mode;
    final color = isSelected
        ? AppColors.primary
        : theme.colorScheme.onSurface.withValues(alpha: 0.5);
    final bgColor = isSelected
        ? AppColors.primary.withValues(alpha: 0.1)
        : Colors.transparent;

    return Expanded(
      child: InkWell(
        onTap: () => onChanged(mode),
        borderRadius: BorderRadius.circular(AppRadii.button),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(AppRadii.button),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary.withValues(alpha: 0.3)
                  : Colors.transparent,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 22, color: color),
              const SizedBox(height: 6),
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: color,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final containerColor = isDark
        ? AppColors.inactiveDark.withValues(alpha: 0.3)
        : AppColors.inactive.withValues(alpha: 0.3);

    return Container(
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(AppRadii.button),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          _buildOption(
            context,
            'System',
            Icons.brightness_auto_outlined,
            AppThemeMode.system,
          ),
          _buildOption(
            context,
            'Light',
            Icons.light_mode_outlined,
            AppThemeMode.light,
          ),
          _buildOption(
            context,
            'Dark',
            Icons.dark_mode_outlined,
            AppThemeMode.dark,
          ),
        ],
      ),
    );
  }
}
