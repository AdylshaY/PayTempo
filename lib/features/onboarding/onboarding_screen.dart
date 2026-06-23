import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/features/onboarding/data/onboarding_currencies.dart';
import 'package:pay_tempo/features/onboarding/data/user_settings_service.dart';
import 'package:pay_tempo/features/onboarding/widgets/continue_button.dart';
import 'package:pay_tempo/features/onboarding/widgets/currency_dropdown.dart';
import 'package:pay_tempo/features/onboarding/widgets/onboarding_animated_icon.dart';
import 'package:pay_tempo/features/onboarding/widgets/warning_banner.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({required this.onCompleted, super.key});

  final VoidCallback onCompleted;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final UserSettingsService _settingsService = UserSettingsService();
  final ValueNotifier<String?> _selectedCurrency = ValueNotifier<String?>(
    onboardingCurrencies.first.code,
  );
  final ValueNotifier<bool> _saving = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _selectedCurrency.dispose();
    _saving.dispose();
    super.dispose();
  }

  Future<void> _saveAndContinue() async {
    final String? currency = _selectedCurrency.value;
    if (currency == null) return;

    _saving.value = true;

    try {
      await _settingsService.saveBaseCurrency(currency);
      if (!mounted) return;
      widget.onCompleted();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.failedToSaveBaseCurrency),
        ),
      );
      _saving.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.md),
              const Center(child: OnboardingAnimatedIcon()),
              const SizedBox(height: AppSpacing.md),
              Text(l10n.baseCurrencyTitle, style: textTheme.headlineMedium),
              const SizedBox(height: AppSpacing.xs),
              Text(
                l10n.selectBaseCurrencyDesc,
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              CurrencyDropdown(
                selectedCurrency: _selectedCurrency,
                saving: _saving,
              ),
              const SizedBox(height: AppSpacing.sm),
              const WarningBanner(),
              const Spacer(),
              ContinueButton(
                selectedCurrency: _selectedCurrency,
                saving: _saving,
                onPressed: _saveAndContinue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
