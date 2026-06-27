import 'package:pay_tempo/l10n/app_localizations.dart';

String billingCycleLabel(String cycle, AppLocalizations l10n) {
  switch (cycle.toLowerCase()) {
    case 'monthly':
      return l10n.monthlyLabel;
    case 'yearly':
      return l10n.yearlyLabel;
    case 'weekly':
      return l10n.weeklyLabel;
    case 'quarterly':
      return l10n.quarterlyLabel;
    default:
      return cycle;
  }
}
