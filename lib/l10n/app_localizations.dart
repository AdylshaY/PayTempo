import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'PayTempo'**
  String get appTitle;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @settingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your profile and app settings.'**
  String get settingsSubtitle;

  /// No description provided for @yourCurrency.
  ///
  /// In en, this message translates to:
  /// **'Your Currency'**
  String get yourCurrency;

  /// No description provided for @yourCurrencySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Selected currency used for totals and reports.'**
  String get yourCurrencySubtitle;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @appearanceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Customize your app theme.'**
  String get appearanceSubtitle;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language.'**
  String get languageSubtitle;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get languageSystem;

  /// No description provided for @guestStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'All your data is stored only on this device. Upgrade to Pro to back up your data to the cloud.'**
  String get guestStatusTitle;

  /// No description provided for @tryPro.
  ///
  /// In en, this message translates to:
  /// **'Try PayTempo Pro'**
  String get tryPro;

  /// No description provided for @proFeature1.
  ///
  /// In en, this message translates to:
  /// **'Cloud backup — safe even when switching devices'**
  String get proFeature1;

  /// No description provided for @proFeature2.
  ///
  /// In en, this message translates to:
  /// **'Advanced analytics — category & trend charts'**
  String get proFeature2;

  /// No description provided for @proFeature3.
  ///
  /// In en, this message translates to:
  /// **'Custom categories & priority support'**
  String get proFeature3;

  /// No description provided for @viewProPlans.
  ///
  /// In en, this message translates to:
  /// **'View Pro Plans'**
  String get viewProPlans;

  /// No description provided for @proActiveTitle.
  ///
  /// In en, this message translates to:
  /// **'PayTempo Pro'**
  String get proActiveTitle;

  /// No description provided for @proActiveActiveBadge.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get proActiveActiveBadge;

  /// No description provided for @proActiveExpires.
  ///
  /// In en, this message translates to:
  /// **'Expires / Renews'**
  String get proActiveExpires;

  /// No description provided for @proActivePlan.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get proActivePlan;

  /// No description provided for @manageSubscription.
  ///
  /// In en, this message translates to:
  /// **'Manage Subscription (App Store / Play Store)'**
  String get manageSubscription;

  /// No description provided for @proFeatureCloudSync.
  ///
  /// In en, this message translates to:
  /// **'Cloud Sync Active'**
  String get proFeatureCloudSync;

  /// No description provided for @proExpiredTitle.
  ///
  /// In en, this message translates to:
  /// **'PayTempo Pro Expired'**
  String get proExpiredTitle;

  /// No description provided for @proExpiredSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your data is preserved, but cloud sync and advanced analytics have been temporarily disabled.'**
  String get proExpiredSubtitle;

  /// No description provided for @expiredLabel.
  ///
  /// In en, this message translates to:
  /// **'Expired: '**
  String get expiredLabel;

  /// No description provided for @renewPro.
  ///
  /// In en, this message translates to:
  /// **'Renew PayTempo Pro'**
  String get renewPro;

  /// No description provided for @noAccountCreated.
  ///
  /// In en, this message translates to:
  /// **'No account created'**
  String get noAccountCreated;

  /// No description provided for @payments.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get payments;

  /// No description provided for @paymentsFailedToLoad.
  ///
  /// In en, this message translates to:
  /// **'Payments failed to load.'**
  String get paymentsFailedToLoad;

  /// No description provided for @paymentsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} payments'**
  String paymentsCount(int count);

  /// No description provided for @noPaymentsForMonth.
  ///
  /// In en, this message translates to:
  /// **'No payments recorded for this month.'**
  String get noPaymentsForMonth;

  /// No description provided for @searchSubscription.
  ///
  /// In en, this message translates to:
  /// **'Search by subscription name'**
  String get searchSubscription;

  /// No description provided for @showingLast3Months.
  ///
  /// In en, this message translates to:
  /// **'Showing last 3 months'**
  String get showingLast3Months;

  /// No description provided for @showingFilteredRange.
  ///
  /// In en, this message translates to:
  /// **'Showing filtered date range'**
  String get showingFilteredRange;

  /// No description provided for @clearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get clearFilters;

  /// No description provided for @anyTime.
  ///
  /// In en, this message translates to:
  /// **'Any time'**
  String get anyTime;

  /// No description provided for @noPaymentsMatchFilter.
  ///
  /// In en, this message translates to:
  /// **'No payments match the current filters.'**
  String get noPaymentsMatchFilter;

  /// No description provided for @noPaymentsRecordedYet.
  ///
  /// In en, this message translates to:
  /// **'No payments recorded yet.'**
  String get noPaymentsRecordedYet;

  /// No description provided for @recordedLabel.
  ///
  /// In en, this message translates to:
  /// **'Recorded'**
  String get recordedLabel;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @subscriptions.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions'**
  String get subscriptions;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @anonymousLocalData.
  ///
  /// In en, this message translates to:
  /// **'Anonymous · Local Data'**
  String get anonymousLocalData;

  /// No description provided for @proPlanActive.
  ///
  /// In en, this message translates to:
  /// **'Pro Plan · Active'**
  String get proPlanActive;

  /// No description provided for @proExpiredBadge.
  ///
  /// In en, this message translates to:
  /// **'Pro Expired'**
  String get proExpiredBadge;

  /// No description provided for @guestUser.
  ///
  /// In en, this message translates to:
  /// **'Guest User'**
  String get guestUser;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @analytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analytics;

  /// No description provided for @paidThisMonth.
  ///
  /// In en, this message translates to:
  /// **'Paid this month'**
  String get paidThisMonth;

  /// No description provided for @remainingFromActive.
  ///
  /// In en, this message translates to:
  /// **'Remaining: {amount} {currency} from active subscriptions'**
  String remainingFromActive(String amount, String currency);

  /// No description provided for @activeSubscriptionsFailed.
  ///
  /// In en, this message translates to:
  /// **'Active subscriptions failed to load.'**
  String get activeSubscriptionsFailed;

  /// No description provided for @activeSubscriptions.
  ///
  /// In en, this message translates to:
  /// **'Active subscriptions'**
  String get activeSubscriptions;

  /// No description provided for @noActiveSubscriptions.
  ///
  /// In en, this message translates to:
  /// **'No active subscriptions yet.'**
  String get noActiveSubscriptions;

  /// No description provided for @totalItems.
  ///
  /// In en, this message translates to:
  /// **'{count} total'**
  String totalItems(int count);

  /// No description provided for @paidLabel.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paidLabel;

  /// No description provided for @alreadyRecordedThisMonth.
  ///
  /// In en, this message translates to:
  /// **'You already recorded a payment for this month.'**
  String get alreadyRecordedThisMonth;

  /// No description provided for @overdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get overdue;

  /// No description provided for @dueToday.
  ///
  /// In en, this message translates to:
  /// **'Due today'**
  String get dueToday;

  /// No description provided for @dueSoon.
  ///
  /// In en, this message translates to:
  /// **'Due soon'**
  String get dueSoon;

  /// No description provided for @scheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get scheduled;

  /// No description provided for @dueSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{price} {currency} • Due {date}'**
  String dueSubtitle(String price, String currency, String date);

  /// No description provided for @subscriptionNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Subscription Name'**
  String get subscriptionNameLabel;

  /// No description provided for @subscriptionNameHint.
  ///
  /// In en, this message translates to:
  /// **'Example: Netflix'**
  String get subscriptionNameHint;

  /// No description provided for @subscriptionNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Subscription name is required.'**
  String get subscriptionNameRequired;

  /// No description provided for @subscriptionNameMinLength.
  ///
  /// In en, this message translates to:
  /// **'Please enter at least 2 characters.'**
  String get subscriptionNameMinLength;

  /// No description provided for @noteLabel.
  ///
  /// In en, this message translates to:
  /// **'Note / Description (Optional)'**
  String get noteLabel;

  /// No description provided for @noteHint.
  ///
  /// In en, this message translates to:
  /// **'Example: Spouse\'s line, personal account'**
  String get noteHint;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
