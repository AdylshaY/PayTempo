import 'package:pay_tempo/l10n/app_localizations.dart';

class OnboardingCurrency {
  const OnboardingCurrency({
    required this.code,
    required this.label,
  });

  final String code;
  final String label;
}

String getCurrencyLabel(String code, AppLocalizations l10n) {
  switch (code.toUpperCase()) {
    case 'TRY':
      return l10n.currencyTRY;
    case 'USD':
      return l10n.currencyUSD;
    case 'EUR':
      return l10n.currencyEUR;
    case 'GBP':
      return l10n.currencyGBP;
    case 'JPY':
      return l10n.currencyJPY;
    case 'CNY':
      return l10n.currencyCNY;
    case 'CAD':
      return l10n.currencyCAD;
    case 'AUD':
      return l10n.currencyAUD;
    case 'CHF':
      return l10n.currencyCHF;
    default:
      return code;
  }
}

const List<OnboardingCurrency> onboardingCurrencies = <OnboardingCurrency>[
  OnboardingCurrency(code: 'TRY', label: 'Turkish Lira'),
  OnboardingCurrency(code: 'USD', label: 'US Dollar'),
  OnboardingCurrency(code: 'EUR', label: 'Euro'),
  OnboardingCurrency(code: 'GBP', label: 'British Pound'),
  OnboardingCurrency(code: 'JPY', label: 'Japanese Yen'),
  OnboardingCurrency(code: 'CNY', label: 'Chinese Yuan'),
  OnboardingCurrency(code: 'CAD', label: 'Canadian Dollar'),
  OnboardingCurrency(code: 'AUD', label: 'Australian Dollar'),
  OnboardingCurrency(code: 'CHF', label: 'Swiss Franc'),
];
