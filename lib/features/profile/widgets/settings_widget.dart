import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/data/local/models/user_settings.dart';
import 'package:pay_tempo/data/local/services/backup_restore_service.dart';
import 'package:pay_tempo/features/onboarding/data/onboarding_currencies.dart';
import 'package:pay_tempo/features/onboarding/data/user_settings_service.dart';
import 'package:pay_tempo/features/profile/pro_upgrade_screen.dart';
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
                  AppLocalizations.of(sheetContext)!.changeCurrencyTitle,
                  style: Theme.of(sheetContext).textTheme.headlineMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                ...onboardingCurrencies.map((OnboardingCurrency currency) {
                  final l10n = AppLocalizations.of(sheetContext)!;
                  final bool isSelected =
                      currency.code.toUpperCase() == currentCurrency;
                  return ListTile(
                    title: Text(getCurrencyLabel(currency.code, l10n)),
                    trailing: Text(
                      currency.code,
                      style:
                          Theme.of(sheetContext).textTheme.bodyMedium?.copyWith(
                                color: isSelected
                                    ? AppColors.primary
                                    : Theme.of(sheetContext).colorScheme.onSurfaceVariant,
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
    final l10n = AppLocalizations.of(context)!;
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(l10n.changeDisplayCurrencyTitle),
          content: Text(
            l10n.confirmChangeCurrencyContent(newCurrency),
          ),
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
            l10n.currencyChangedSuccess(newCurrency, count),
          ),
        ),
      );
    } catch (_) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.failedToChangeCurrency),
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

  Future<void> _exportBackup() async {
    HapticFeedback.lightImpact();
    final l10n = AppLocalizations.of(context)!;
    final BackupRestoreService backupService = BackupRestoreService();

    final bool success = await backupService.exportBackup();
    if (!mounted) return;

    if (success) {
      HapticFeedback.mediumImpact();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.exportSuccess)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.exportFailed)),
      );
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
                backgroundColor: Theme.of(dialogContext).colorScheme.errorContainer,
                foregroundColor: Theme.of(dialogContext).colorScheme.onErrorContainer,
              ),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(l10n.importData),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !mounted) {
      return;
    }

    final BackupRestoreService backupService = BackupRestoreService();
    final bool success = await backupService.importBackup();
    if (!mounted) return;

    if (success) {
      HapticFeedback.mediumImpact();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.importSuccess)),
      );
      setState(() {
        _settingsFuture = UserSettingsService().getSettings();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.importFailed)),
      );
    }
  }

  Future<void> _showBudgetDialog(double? currentBudget) async {
    final l10n = AppLocalizations.of(context)!;
    final TextEditingController controller = TextEditingController(
      text: currentBudget != null ? currentBudget.toStringAsFixed(0) : '',
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
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
                ],
                autofocus: true,
                decoration: InputDecoration(
                  hintText: l10n.budgetAmountHint,
                  suffixText: UserSettingsService.baseCurrencyNotifier.value,
                ),
              ),
            ],
          ),
          actions: [
            if (currentBudget != null)
              TextButton(
                onPressed: () {
                  // Return -1 to signal "remove budget"
                  Navigator.of(dialogContext).pop(-1.0);
                },
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
                final double? value = double.tryParse(controller.text.trim());
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
      // Remove budget
      await UserSettingsService().setBudgetLimit(null);
    } else {
      await UserSettingsService().setBudgetLimit(result);
    }

    HapticFeedback.lightImpact();
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
              style: textTheme.bodySmall,
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
                      style: textTheme.bodySmall,
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
                      HapticFeedback.lightImpact();
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
                    HapticFeedback.lightImpact();
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
            const SizedBox(height: AppSpacing.xs),
            ValueListenableBuilder<bool>(
              valueListenable: UserSettingsService.notificationsEnabledNotifier,
              builder: (context, notificationsEnabled, _) {
                return Card(
                  child: SwitchListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: 4,
                    ),
                    secondary: Icon(notificationsEnabled
                        ? Icons.notifications_active_outlined
                        : Icons.notifications_off_outlined),
                    title: Text(l10n.notificationsLabel),
                    subtitle: Text(
                      l10n.notificationsSubtitle,
                      style: textTheme.bodySmall,
                    ),
                    value: notificationsEnabled,
                    onChanged: (bool value) {
                      HapticFeedback.lightImpact();
                      UserSettingsService().setNotificationsEnabled(value);
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: AppSpacing.xs),
            ValueListenableBuilder<double?>(
              valueListenable: UserSettingsService.budgetLimitNotifier,
              builder: (context, budgetLimit, _) {
                final String displayValue = budgetLimit != null
                    ? '${budgetLimit.toStringAsFixed(0)} ${UserSettingsService.baseCurrencyNotifier.value}'
                    : l10n.budgetNotSet;

                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: 4,
                    ),
                    leading: const Icon(Icons.account_balance_wallet_outlined),
                    title: Text(l10n.budgetLabel),
                    subtitle: Text(
                      l10n.budgetSettingDesc,
                      style: textTheme.bodySmall,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          displayValue,
                          style: textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.chevron_right_rounded, size: 20),
                      ],
                    ),
                    onTap: () => _showBudgetDialog(budgetLimit),
                  ),
                );
              },
            ),
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: 4,
                ),
                leading: const Icon(Icons.category_outlined),
                title: Text(l10n.manageCategories),
                subtitle: Text(
                  l10n.manageCategoriesSubtitle,
                  style: textTheme.bodySmall,
                ),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {
                  final bool isPro = snapshot.data?.isPro ?? false;
                  if (!isPro) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ProUpgradeScreen(),
                      ),
                    );
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ManageCategoriesScreen(),
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(l10n.backupAndRecovery, style: textTheme.titleMedium),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.backupAndRecoverySubtitle,
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: AppSpacing.xs),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.upload_rounded),
                    title: Text(l10n.exportData),
                    subtitle: Text(
                      l10n.exportDataSubtitle,
                      style: textTheme.bodySmall,
                    ),
                    onTap: _exportBackup,
                  ),
                  const Divider(height: 1, indent: AppSpacing.md, endIndent: AppSpacing.md),
                  ListTile(
                    leading: const Icon(Icons.download_rounded),
                    title: Text(l10n.importData),
                    subtitle: Text(
                      l10n.importDataSubtitle,
                      style: textTheme.bodySmall,
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
          style: textTheme.bodySmall,
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
