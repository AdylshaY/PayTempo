class OnboardingCurrency {
  const OnboardingCurrency({
    required this.code,
    required this.label,
  });

  final String code;
  final String label;
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
