import 'package:flutter/material.dart';
import 'package:subscription_tracker/app/theme/app_theme.dart';
import 'package:subscription_tracker/features/onboarding/data/onboarding_currencies.dart';

class CurrencyDropdown extends StatelessWidget {
  const CurrencyDropdown({
    super.key,
    required this.selectedCurrency,
    required this.saving,
  });

  final ValueNotifier<String?> selectedCurrency;
  final ValueNotifier<bool> saving;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextStyle? dropdownTextStyle = textTheme.bodyMedium?.copyWith(
      color: AppColors.textPrimary,
    );

    return ListenableBuilder(
      listenable: Listenable.merge([selectedCurrency, saving]),
      builder: (BuildContext context, _) {
        return DropdownMenu<String>(
          initialSelection: selectedCurrency.value,
          textStyle: dropdownTextStyle,
          menuStyle: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(
              Theme.of(context).colorScheme.surface,
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadii.card),
              ),
            ),
          ),
          expandedInsets: EdgeInsets.zero,
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          hintText: 'Select base currency',
          enabled: !saving.value,
          onSelected: (String? value) {
            selectedCurrency.value = value;
          },
          dropdownMenuEntries: onboardingCurrencies
              .map(
                (OnboardingCurrency currency) => DropdownMenuEntry<String>(
                  value: currency.code,
                  label: '${currency.code} - ${currency.label}',
                  style: ButtonStyle(
                    textStyle: WidgetStatePropertyAll(dropdownTextStyle),
                  ),
                ),
              )
              .toList(growable: false),
        );
      },
    );
  }
}
