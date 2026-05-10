// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'PayTempo';

  @override
  String get settings => 'Settings';

  @override
  String get settingsSubtitle => 'Manage your profile and app settings.';

  @override
  String get yourCurrency => 'Your Currency';

  @override
  String get yourCurrencySubtitle =>
      'Selected currency used for totals and reports.';

  @override
  String get appearance => 'Appearance';

  @override
  String get appearanceSubtitle => 'Customize your app theme.';

  @override
  String get language => 'Language';

  @override
  String get languageSubtitle => 'Choose your preferred language.';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get languageSystem => 'System Default';

  @override
  String get guestStatusTitle =>
      'All your data is stored only on this device. Upgrade to Pro to back up your data to the cloud.';

  @override
  String get tryPro => 'Try PayTempo Pro';

  @override
  String get proFeature1 => 'Cloud backup — safe even when switching devices';

  @override
  String get proFeature2 => 'Advanced analytics — category & trend charts';

  @override
  String get proFeature3 => 'Custom categories & priority support';

  @override
  String get viewProPlans => 'View Pro Plans';

  @override
  String get proActiveTitle => 'PayTempo Pro';

  @override
  String get proActiveActiveBadge => 'Active';

  @override
  String get proActiveExpires => 'Expires / Renews';

  @override
  String get proActivePlan => 'Plan';

  @override
  String get manageSubscription =>
      'Manage Subscription (App Store / Play Store)';

  @override
  String get proFeatureCloudSync => 'Cloud Sync Active';

  @override
  String get proExpiredTitle => 'PayTempo Pro Expired';

  @override
  String get proExpiredSubtitle =>
      'Your data is preserved, but cloud sync and advanced analytics have been temporarily disabled.';

  @override
  String get expiredLabel => 'Expired: ';

  @override
  String get renewPro => 'Renew PayTempo Pro';

  @override
  String get noAccountCreated => 'No account created';

  @override
  String get payments => 'Payments';

  @override
  String get paymentsFailedToLoad => 'Payments failed to load.';

  @override
  String paymentsCount(int count) {
    return '$count payments';
  }

  @override
  String get noPaymentsForMonth => 'No payments recorded for this month.';

  @override
  String get searchSubscription => 'Search by subscription name';

  @override
  String get showingLast3Months => 'Showing last 3 months';

  @override
  String get showingFilteredRange => 'Showing filtered date range';

  @override
  String get clearFilters => 'Clear filters';

  @override
  String get anyTime => 'Any time';

  @override
  String get noPaymentsMatchFilter => 'No payments match the current filters.';

  @override
  String get noPaymentsRecordedYet => 'No payments recorded yet.';

  @override
  String get recordedLabel => 'Recorded';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get subscriptions => 'Subscriptions';

  @override
  String get profile => 'Profile';

  @override
  String get anonymousLocalData => 'Anonymous · Local Data';

  @override
  String get proPlanActive => 'Pro Plan · Active';

  @override
  String get proExpiredBadge => 'Pro Expired';

  @override
  String get guestUser => 'Guest User';

  @override
  String get user => 'User';

  @override
  String get analytics => 'Analytics';

  @override
  String get paidThisMonth => 'Paid this month';

  @override
  String remainingFromActive(String amount, String currency) {
    return 'Remaining: $amount $currency from active subscriptions';
  }

  @override
  String get activeSubscriptionsFailed =>
      'Active subscriptions failed to load.';

  @override
  String get activeSubscriptions => 'Active subscriptions';

  @override
  String get noActiveSubscriptions => 'No active subscriptions yet.';

  @override
  String totalItems(int count) {
    return '$count total';
  }

  @override
  String get paidLabel => 'Paid';

  @override
  String get alreadyRecordedThisMonth =>
      'You already recorded a payment for this month.';

  @override
  String get overdue => 'Overdue';

  @override
  String get dueToday => 'Due today';

  @override
  String get dueSoon => 'Due soon';

  @override
  String get scheduled => 'Scheduled';

  @override
  String dueSubtitle(String price, String currency, String date) {
    return '$price $currency • Due $date';
  }
}
