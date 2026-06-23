import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/data/local/models/user_settings.dart';
import 'package:pay_tempo/features/onboarding/data/onboarding_currencies.dart';
import 'package:pay_tempo/features/onboarding/data/user_settings_service.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  late final Future<UserSettings?> _settingsFuture;
  bool _changingCurrency = false;

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

  Future<void> _showCurrencyPicker() async {
    final String currentCurrency =
        UserSettingsService.baseCurrencyNotifier.value;

    final String? selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.sm,
              0,
              AppSpacing.sm,
              AppSpacing.md,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Change currency',
                  style: Theme.of(sheetContext).textTheme.headlineMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                ...onboardingCurrencies.map((OnboardingCurrency currency) {
                  final bool isSelected =
                      currency.code.toUpperCase() == currentCurrency;
                  return ListTile(
                    title: Text(currency.label),
                    trailing: Text(
                      currency.code,
                      style:
                          Theme.of(sheetContext).textTheme.bodyMedium?.copyWith(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                              ),
                    ),
                    leading: isSelected
                        ? const Icon(Icons.check_circle, color: AppColors.primary)
                        : const Icon(Icons.circle_outlined,
                            color: AppColors.inactive),
                    onTap: () => Navigator.of(sheetContext).pop(currency.code),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );

    if (selected == null ||
        !mounted ||
        selected.toUpperCase() == currentCurrency) {
      return;
    }

    await _confirmAndChangeCurrency(selected);
  }

  Future<void> _confirmAndChangeCurrency(String newCurrency) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Change display currency?'),
          content: Text(
            'Your base currency will change to $newCurrency. '
            'All past payments will be recalculated using the '
            'historical exchange rate from the date they were recorded.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Change'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !mounted) {
      return;
    }

    setState(() {
      _changingCurrency = true;
    });

    try {
      final int count =
          await UserSettingsService().changeBaseCurrency(newCurrency);

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Currency changed to $newCurrency. '
            '$count payment${count == 1 ? '' : 's'} recalculated.',
          ),
        ),
      );
    } catch (_) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to change currency. Please try again.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _changingCurrency = false;
        });
      }
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
            ValueListenableBuilder<String>(
              valueListenable: UserSettingsService.baseCurrencyNotifier,
              builder: (context, baseCurrency, _) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.currency_exchange),
                    title: Text(l10n.yourCurrency),
                    subtitle: Text(
                      l10n.yourCurrencySubtitle,
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    trailing: _changingCurrency
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(baseCurrency),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 20,
                              ),
                            ],
                          ),
                    onTap: _changingCurrency ? null : _showCurrencyPicker,
                  ),
                );
              },
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
