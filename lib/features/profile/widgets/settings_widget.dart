import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/app/utils/currency_formatter.dart';
import 'package:pay_tempo/data/local/models/user_settings.dart';
import 'package:pay_tempo/data/local/services/backup_restore_service.dart';
import 'package:pay_tempo/features/onboarding/data/onboarding_currencies.dart';
import 'package:pay_tempo/features/onboarding/data/user_settings_service.dart';
import 'package:pay_tempo/features/subscriptions/manage_categories_screen.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  late Future<UserSettings?> _settingsFuture;
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

  // ─── Bottom Sheet Helper ────────────────────────────────────────────────────

  /// Generic bottom-sheet picker. Returns the selected [T] wrapped in PickerResult or null if dismissed.
  Future<PickerResult<T>?> _showPickerSheet<T>({
    required String title,
    required List<_PickerOption<T>> options,
    required T currentValue,
  }) {
    return showModalBottomSheet<PickerResult<T>>(
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                  child: Text(
                    title,
                    style: Theme.of(sheetContext).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                ...options.map((opt) {
                  final bool isSelected = opt.value == currentValue;
                  return ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadii.card),
                    ),
                    leading: isSelected
                        ? Icon(Icons.check_circle_rounded,
                            color: AppColors.primary)
                        : Icon(Icons.circle_outlined,
                            color: Theme.of(sheetContext)
                                .colorScheme
                                .outlineVariant),
                    title: Text(
                      opt.label,
                      style: Theme.of(sheetContext).textTheme.bodyLarge?.copyWith(
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                            color: isSelected
                                ? AppColors.primary
                                : null,
                          ),
                    ),
                    subtitle: opt.sublabel != null
                        ? Text(
                            opt.sublabel!,
                            style:
                                Theme.of(sheetContext).textTheme.bodySmall,
                          )
                        : null,
                    onTap: () =>
                        Navigator.of(sheetContext).pop(PickerResult<T>(opt.value)),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  // ─── Currency ───────────────────────────────────────────────────────────────

  Future<void> _showCurrencyPicker() async {
    final l10n = AppLocalizations.of(context)!;
    final String currentCurrency =
        UserSettingsService.baseCurrencyNotifier.value;

    final options = onboardingCurrencies
        .map(
          (c) => _PickerOption<String>(
            value: c.code.toUpperCase(),
            label: getCurrencyLabel(c.code, l10n),
            sublabel: c.code.toUpperCase(),
          ),
        )
        .toList();

    final result = await _showPickerSheet<String>(
      title: l10n.changeCurrencyTitle,
      options: options,
      currentValue: currentCurrency,
    );

    if (result == null || !mounted || result.value == currentCurrency) return;
    await _confirmAndChangeCurrency(result.value);
  }

  Future<void> _confirmAndChangeCurrency(String newCurrency) async {
    final l10n = AppLocalizations.of(context)!;
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(l10n.changeDisplayCurrencyTitle),
          content: Text(l10n.confirmChangeCurrencyContent(newCurrency)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(l10n.cancelButtonLabel),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(l10n.changeButtonLabel),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !mounted) return;

    setState(() => _changingCurrency = true);

    try {
      final int count =
          await UserSettingsService().changeBaseCurrency(newCurrency);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.currencyChangedSuccess(newCurrency, count))),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.failedToChangeCurrency)),
      );
    } finally {
      if (mounted) setState(() => _changingCurrency = false);
    }
  }

  // ─── Theme ──────────────────────────────────────────────────────────────────

  Future<void> _showThemePicker() async {
    final l10n = AppLocalizations.of(context)!;
    final ThemeMode current = UserSettingsService.appThemeNotifier.value;

    final result = await _showPickerSheet<ThemeMode>(
      title: l10n.appearance,
      options: [
        _PickerOption(
          value: ThemeMode.system,
          label: l10n.themeSystem,
        ),
        _PickerOption(
          value: ThemeMode.light,
          label: l10n.themeLight,
        ),
        _PickerOption(
          value: ThemeMode.dark,
          label: l10n.themeDark,
        ),
      ],
      currentValue: current,
    );

    if (result == null || !mounted || result.value == current) return;
    HapticFeedback.lightImpact();
    UserSettingsService().setThemeMode(_flutterModeToAppMode(result.value));
  }

  // ─── Language ───────────────────────────────────────────────────────────────

  Future<void> _showLanguagePicker() async {
    final l10n = AppLocalizations.of(context)!;
    final String? current = UserSettingsService.appLanguageNotifier.value;

    final result = await _showPickerSheet<String?>(
      title: l10n.language,
      options: [
        _PickerOption<String?>(value: null, label: l10n.languageSystem),
        const _PickerOption<String?>(value: 'en', label: 'English'),
        const _PickerOption<String?>(value: 'tr', label: 'Türkçe'),
      ],
      currentValue: current,
    );

    if (result == null || !mounted) return;
    HapticFeedback.lightImpact();
    UserSettingsService().setLanguageCode(result.value);
  }

  // ─── Budget ─────────────────────────────────────────────────────────────────

  Future<void> _showBudgetDialog(double? currentBudget) async {
    final l10n = AppLocalizations.of(context)!;
    final TextEditingController controller = TextEditingController(
      text: currentBudget != null ? currentBudget.toStringAsFixed(2) : '',
    );

    final double? result = await showDialog<double?>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(l10n.budgetLabel),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.budgetSettingDesc,
                style: Theme.of(dialogContext).textTheme.bodySmall,
              ),
              const SizedBox(height: AppSpacing.sm),
              TextField(
                controller: controller,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
                ],
                autofocus: true,
                decoration: InputDecoration(
                  hintText: l10n.budgetAmountHint,
                  suffixText:
                      UserSettingsService.baseCurrencyNotifier.value,
                ),
              ),
            ],
          ),
          actions: [
            if (currentBudget != null)
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(-1.0),
                child: Text(
                  l10n.removeBudget,
                  style: TextStyle(
                    color: Theme.of(dialogContext).colorScheme.error,
                  ),
                ),
              ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(l10n.cancelButtonLabel),
            ),
            ElevatedButton(
              onPressed: () {
                final double? value =
                    double.tryParse(controller.text.trim());
                if (value != null && value > 0) {
                  Navigator.of(dialogContext).pop(value);
                }
              },
              child: Text(l10n.setBudget),
            ),
          ],
        );
      },
    );

    if (!mounted || result == null) return;

    if (result == -1.0) {
      await UserSettingsService().setBudgetLimit(null);
    } else {
      await UserSettingsService().setBudgetLimit(result);
    }
    HapticFeedback.lightImpact();
  }

  // ─── Backup ─────────────────────────────────────────────────────────────────

  Future<void> _exportBackup() async {
    HapticFeedback.lightImpact();
    final l10n = AppLocalizations.of(context)!;
    final bool success = await BackupRestoreService().exportBackup();
    if (!mounted) return;

    if (success) {
      HapticFeedback.mediumImpact();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.exportSuccess)));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.exportFailed)));
    }
  }

  Future<void> _importBackup() async {
    HapticFeedback.lightImpact();
    final l10n = AppLocalizations.of(context)!;

    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(l10n.confirmRestoreTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.confirmRestoreMessage),
              const SizedBox(height: AppSpacing.sm),
              Text(
                l10n.restoreWarning,
                style: Theme.of(dialogContext).textTheme.bodySmall?.copyWith(
                      color: Theme.of(dialogContext).colorScheme.error,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(l10n.cancelButtonLabel),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(dialogContext).colorScheme.errorContainer,
                foregroundColor:
                    Theme.of(dialogContext).colorScheme.onErrorContainer,
              ),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(l10n.importData),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !mounted) return;

    final bool success = await BackupRestoreService().importBackup();
    if (!mounted) return;

    if (success) {
      HapticFeedback.mediumImpact();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.importSuccess)));
      setState(() {
        _settingsFuture = UserSettingsService().getSettings();
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.importFailed)));
    }
  }

  // ─── Build ──────────────────────────────────────────────────────────────────

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
            // ── Section: Preferences ────────────────────────────────────────
            Text(l10n.settings, style: textTheme.titleMedium),
            const SizedBox(height: AppSpacing.xs),
            Text(l10n.settingsSubtitle, style: textTheme.bodySmall),
            const SizedBox(height: AppSpacing.sm),

            // Currency
            ValueListenableBuilder<String>(
              valueListenable: UserSettingsService.baseCurrencyNotifier,
              builder: (context, baseCurrency, _) {
                return _SettingsActionTile(
                  icon: Icons.currency_exchange_rounded,
                  title: l10n.yourCurrency,
                  subtitle: l10n.yourCurrencySubtitle,
                  valueLabel: baseCurrency,
                  isLoading: _changingCurrency,
                  onTap: _changingCurrency ? null : _showCurrencyPicker,
                );
              },
            ),
            const SizedBox(height: AppSpacing.xs),

            // Theme
            ValueListenableBuilder<ThemeMode>(
              valueListenable: UserSettingsService.appThemeNotifier,
              builder: (context, themeMode, _) {
                final String label = themeMode == ThemeMode.light
                    ? l10n.themeLight
                    : themeMode == ThemeMode.dark
                        ? l10n.themeDark
                        : l10n.themeSystem;
                return _SettingsActionTile(
                  icon: Icons.palette_outlined,
                  title: l10n.appearance,
                  subtitle: l10n.appearanceSubtitle,
                  valueLabel: label,
                  onTap: _showThemePicker,
                );
              },
            ),
            const SizedBox(height: AppSpacing.xs),

            // Language
            ValueListenableBuilder<String?>(
              valueListenable: UserSettingsService.appLanguageNotifier,
              builder: (context, languageCode, _) {
                final String label = languageCode == 'en'
                    ? 'English'
                    : languageCode == 'tr'
                        ? 'Türkçe'
                        : l10n.languageSystem;
                return _SettingsActionTile(
                  icon: Icons.language_outlined,
                  title: l10n.language,
                  subtitle: l10n.languageSubtitle,
                  valueLabel: label,
                  onTap: _showLanguagePicker,
                );
              },
            ),
            const SizedBox(height: AppSpacing.xs),

            ValueListenableBuilder<double?>(
              valueListenable: UserSettingsService.budgetLimitNotifier,
              builder: (context, budgetLimit, _) {
                final String displayValue = budgetLimit != null
                    ? CurrencyFormatter.format(budgetLimit, UserSettingsService.baseCurrencyNotifier.value)
                    : l10n.budgetNotSet;
                return _SettingsActionTile(
                  icon: Icons.account_balance_wallet_outlined,
                  title: l10n.budgetLabel,
                  subtitle: l10n.budgetSettingDesc,
                  valueLabel: displayValue,
                  onTap: () => _showBudgetDialog(budgetLimit),
                );
              },
            ),
            const SizedBox(height: AppSpacing.xs),

            // Notifications toggle
            ValueListenableBuilder<bool>(
              valueListenable: UserSettingsService.notificationsEnabledNotifier,
              builder: (context, notificationsEnabled, _) {
                return Column(
                  children: [
                    _SettingsToggleTile(
                      icon: notificationsEnabled
                          ? Icons.notifications_active_outlined
                          : Icons.notifications_off_outlined,
                      title: l10n.notificationsLabel,
                      subtitle: l10n.notificationsSubtitle,
                      value: notificationsEnabled,
                      onChanged: (bool value) {
                        HapticFeedback.lightImpact();
                        UserSettingsService().setNotificationsEnabled(value);
                      },
                    ),
                    if (notificationsEnabled) ...[
                      const SizedBox(height: AppSpacing.xs),
                      ValueListenableBuilder<int>(
                        valueListenable:
                            UserSettingsService.notificationHourNotifier,
                        builder: (context, hour, _) {
                          return ValueListenableBuilder<int>(
                            valueListenable:
                                UserSettingsService.notificationMinuteNotifier,
                            builder: (context, minute, _) {
                              final String displayTime =
                                  '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
                              return _SettingsActionTile(
                                icon: Icons.access_time_outlined,
                                title: l10n.notificationTimeLabel,
                                subtitle: l10n.notificationTimeDesc,
                                valueLabel: displayTime,
                                onTap: () async {
                                  HapticFeedback.lightImpact();
                                  final TimeOfDay? picked =
                                      await showTimePicker(
                                    context: context,
                                    initialTime:
                                        TimeOfDay(hour: hour, minute: minute),
                                  );
                                  if (picked != null) {
                                    await UserSettingsService()
                                        .setNotificationTime(
                                            picked.hour, picked.minute);
                                  }
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ],
                );
              },
            ),
            const SizedBox(height: AppSpacing.xs),

            // Manage categories
            _SettingsNavTile(
              icon: Icons.category_outlined,
              title: l10n.manageCategories,
              subtitle: l10n.manageCategoriesSubtitle,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ManageCategoriesScreen(),
                  ),
                );
              },
            ),

            // ── Section: Backup ─────────────────────────────────────────────
            const SizedBox(height: AppSpacing.md),
            Text(l10n.backupAndRecovery, style: textTheme.titleMedium),
            const SizedBox(height: AppSpacing.xs),
            Text(l10n.backupAndRecoverySubtitle, style: textTheme.bodySmall),
            const SizedBox(height: AppSpacing.sm),

            Card(
              child: Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: 4,
                    ),
                    leading: const Icon(Icons.upload_rounded),
                    title: Text(l10n.exportData),
                    subtitle: Text(
                      l10n.exportDataSubtitle,
                      style: textTheme.bodySmall,
                    ),
                    trailing: const Icon(
                      Icons.chevron_right_rounded,
                      size: 20,
                    ),
                    onTap: _exportBackup,
                  ),
                  const Divider(
                    height: 1,
                    indent: AppSpacing.md,
                    endIndent: AppSpacing.md,
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: 4,
                    ),
                    leading: const Icon(Icons.download_rounded),
                    title: Text(l10n.importData),
                    subtitle: Text(
                      l10n.importDataSubtitle,
                      style: textTheme.bodySmall,
                    ),
                    trailing: const Icon(
                      Icons.chevron_right_rounded,
                      size: 20,
                    ),
                    onTap: _importBackup,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

// ─── Shared Tile Widgets ───────────────────────────────────────────────────────

/// A settings row that shows the current value as a pill/chip and opens a
/// picker (bottom sheet / dialog / time picker) on tap.
class _SettingsActionTile extends StatelessWidget {
  const _SettingsActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.valueLabel,
    this.onTap,
    this.isLoading = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String valueLabel;
  final VoidCallback? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 4,
        ),
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle, style: textTheme.bodySmall),
        trailing: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      valueLabel,
                      style: textTheme.labelMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 18,
                    color: colorScheme.outlineVariant,
                  ),
                ],
              ),
        onTap: onTap,
      ),
    );
  }
}

/// A settings row with a switch/toggle on the right.
class _SettingsToggleTile extends StatelessWidget {
  const _SettingsToggleTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: SwitchListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 4,
        ),
        secondary: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle, style: textTheme.bodySmall),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

/// A settings row that navigates to a new screen on tap (chevron only, no value).
class _SettingsNavTile extends StatelessWidget {
  const _SettingsNavTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 4,
        ),
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle, style: textTheme.bodySmall),
        trailing: Icon(
          Icons.chevron_right_rounded,
          size: 18,
          color: colorScheme.outlineVariant,
        ),
        onTap: onTap,
      ),
    );
  }
}

// ─── Internal Models ──────────────────────────────────────────────────────────

class _PickerOption<T> {
  const _PickerOption({
    required this.value,
    required this.label,
    this.sublabel,
  });

  final T value;
  final String label;
  final String? sublabel;
}

class PickerResult<T> {
  const PickerResult(this.value);
  final T value;
}
