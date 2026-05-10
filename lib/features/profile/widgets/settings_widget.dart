import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/data/local/models/user_settings.dart';
import 'package:pay_tempo/features/onboarding/data/user_settings_service.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  late final Future<UserSettings?> _settingsFuture;

  @override
  void initState() {
    super.initState();
    _settingsFuture = UserSettingsService().getSettings();
  }

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
    final AppLocalizations l10n = AppLocalizations.of(context)!;

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
            Text(l10n.settings, style: textTheme.titleMedium),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.settingsSubtitle,
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Card(
              child: ListTile(
                leading: const Icon(Icons.currency_exchange),
                title: Text(l10n.yourCurrency),
                subtitle: Text(
                  l10n.yourCurrencySubtitle,
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
                return SettingsDropdownTile<ThemeMode>(
                  icon: Icons.palette_outlined,
                  title: l10n.appearance,
                  subtitle: l10n.appearanceSubtitle,
                  value: themeMode,
                  onChanged: (ThemeMode? mode) {
                    if (mode != null) {
                      UserSettingsService().setThemeMode(
                        _flutterModeToAppMode(mode),
                      );
                    }
                  },
                  items: [
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text(
                        l10n.themeSystem,
                        style: textTheme.bodyMedium,
                      ),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text(l10n.themeLight, style: textTheme.bodyMedium),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text(l10n.themeDark, style: textTheme.bodyMedium),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: AppSpacing.xs),
            ValueListenableBuilder<String?>(
              valueListenable: UserSettingsService.appLanguageNotifier,
              builder: (context, languageCode, _) {
                return SettingsDropdownTile<String?>(
                  icon: Icons.language_outlined,
                  title: l10n.language,
                  subtitle: l10n.languageSubtitle,
                  value: languageCode,
                  onChanged: (String? code) {
                    UserSettingsService().setLanguageCode(code);
                  },
                  items: [
                    DropdownMenuItem(
                      value: null,
                      child: Text(
                        l10n.languageSystem,
                        style: textTheme.bodyMedium,
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'en',
                      child: Text('English', style: textTheme.bodyMedium),
                    ),
                    DropdownMenuItem(
                      value: 'tr',
                      child: Text('Türkçe', style: textTheme.bodyMedium),
                    ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class SettingsDropdownTile<T> extends StatelessWidget {
  const SettingsDropdownTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.items,
    required this.onChanged,
    super.key,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final T value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 4,
        ),
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(
          subtitle,
          style: textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
        ),
        trailing: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            value: value,
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            borderRadius: BorderRadius.circular(AppRadii.card),
            alignment: Alignment.centerRight,
            onChanged: onChanged,
            items: items,
          ),
        ),
      ),
    );
  }
}
