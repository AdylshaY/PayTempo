import 'package:flutter/material.dart';
import 'package:pay_tempo/app/widgets/app_dropdown_field_widget.dart';
import 'package:pay_tempo/features/onboarding/data/onboarding_currencies.dart';

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
    return ListenableBuilder(
      listenable: Listenable.merge([selectedCurrency, saving]),
      builder: (BuildContext context, _) {
        return AppDropdownFieldWidget<String>(
          initialSelection: selectedCurrency.value,
          hintText: 'Select base currency',
          enabled: !saving.value,
          onSelected: (String? value) => selectedCurrency.value = value,
          entries: onboardingCurrencies
              .map(
                (OnboardingCurrency currency) => DropdownMenuEntry<String>(
                  value: currency.code,
                  label: '${currency.code} - ${currency.label}',
                ),
              )
              .toList(growable: false),
        );
      },
    );
  }
}
