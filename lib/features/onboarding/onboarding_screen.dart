import 'package:flutter/material.dart';
import 'package:subscription_tracker/app/theme/app_theme.dart';
import 'package:subscription_tracker/data/local/services/user_settings_service.dart';
import 'package:subscription_tracker/features/onboarding/data/onboarding_currencies.dart';
import 'package:subscription_tracker/features/onboarding/widgets/continue_button.dart';
import 'package:subscription_tracker/features/onboarding/widgets/currency_dropdown.dart';
import 'package:subscription_tracker/features/onboarding/widgets/onboarding_animated_icon.dart';
import 'package:subscription_tracker/features/onboarding/widgets/warning_banner.dart';

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
        const SnackBar(
          content: Text('Base currency could not be saved. Please try again.'),
        ),
      );
      _saving.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

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
              Text('Base Currency', style: textTheme.headlineMedium),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Please select your base currency. This will be used for all calculations and displays in the app.',
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
