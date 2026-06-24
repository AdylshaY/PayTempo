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

  /// No description provided for @categoryStreaming.
  ///
  /// In en, this message translates to:
  /// **'Streaming'**
  String get categoryStreaming;

  /// No description provided for @categoryMusic.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get categoryMusic;

  /// No description provided for @categoryVideo.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get categoryVideo;

  /// No description provided for @categoryCloud.
  ///
  /// In en, this message translates to:
  /// **'Cloud'**
  String get categoryCloud;

  /// No description provided for @categoryAi.
  ///
  /// In en, this message translates to:
  /// **'AI'**
  String get categoryAi;

  /// No description provided for @categoryProductivity.
  ///
  /// In en, this message translates to:
  /// **'Productivity'**
  String get categoryProductivity;

  /// No description provided for @categoryGaming.
  ///
  /// In en, this message translates to:
  /// **'Gaming'**
  String get categoryGaming;

  /// No description provided for @categoryNews.
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get categoryNews;

  /// No description provided for @currencyTRY.
  ///
  /// In en, this message translates to:
  /// **'Turkish Lira'**
  String get currencyTRY;

  /// No description provided for @currencyUSD.
  ///
  /// In en, this message translates to:
  /// **'US Dollar'**
  String get currencyUSD;

  /// No description provided for @currencyEUR.
  ///
  /// In en, this message translates to:
  /// **'Euro'**
  String get currencyEUR;

  /// No description provided for @currencyGBP.
  ///
  /// In en, this message translates to:
  /// **'British Pound'**
  String get currencyGBP;

  /// No description provided for @currencyJPY.
  ///
  /// In en, this message translates to:
  /// **'Japanese Yen'**
  String get currencyJPY;

  /// No description provided for @currencyCNY.
  ///
  /// In en, this message translates to:
  /// **'Chinese Yuan'**
  String get currencyCNY;

  /// No description provided for @currencyCAD.
  ///
  /// In en, this message translates to:
  /// **'Canadian Dollar'**
  String get currencyCAD;

  /// No description provided for @currencyAUD.
  ///
  /// In en, this message translates to:
  /// **'Australian Dollar'**
  String get currencyAUD;

  /// No description provided for @currencyCHF.
  ///
  /// In en, this message translates to:
  /// **'Swiss Franc'**
  String get currencyCHF;

  /// No description provided for @presetServiceSettings.
  ///
  /// In en, this message translates to:
  /// **'Preset Service Settings'**
  String get presetServiceSettings;

  /// No description provided for @newSubscription.
  ///
  /// In en, this message translates to:
  /// **'New Subscription'**
  String get newSubscription;

  /// No description provided for @avatarLabel.
  ///
  /// In en, this message translates to:
  /// **'Avatar'**
  String get avatarLabel;

  /// No description provided for @presetAvatarDesc.
  ///
  /// In en, this message translates to:
  /// **'This is a preset avatar based on the selected service.'**
  String get presetAvatarDesc;

  /// No description provided for @tapToSelectAvatarDesc.
  ///
  /// In en, this message translates to:
  /// **'Tap to select an icon, emoji, or color.'**
  String get tapToSelectAvatarDesc;

  /// No description provided for @categoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categoryLabel;

  /// No description provided for @priceLabel.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get priceLabel;

  /// No description provided for @priceHint.
  ///
  /// In en, this message translates to:
  /// **'Example: 9.99'**
  String get priceHint;

  /// No description provided for @priceRequired.
  ///
  /// In en, this message translates to:
  /// **'Price is required.'**
  String get priceRequired;

  /// No description provided for @currencyLabel.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currencyLabel;

  /// No description provided for @monthlyLabel.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthlyLabel;

  /// No description provided for @yearlyLabel.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get yearlyLabel;

  /// No description provided for @firstPaymentDateLabel.
  ///
  /// In en, this message translates to:
  /// **'First Payment Date'**
  String get firstPaymentDateLabel;

  /// No description provided for @saveSubscriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Save Subscription'**
  String get saveSubscriptionLabel;

  /// No description provided for @enterValidAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid amount.'**
  String get enterValidAmount;

  /// No description provided for @failedToSaveSubscription.
  ///
  /// In en, this message translates to:
  /// **'Failed to save subscription. Please try again.'**
  String get failedToSaveSubscription;

  /// No description provided for @presetServicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Preset Services'**
  String get presetServicesTitle;

  /// No description provided for @pickServiceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pick a service. You can enter the price on the next form screen.'**
  String get pickServiceSubtitle;

  /// No description provided for @addManuallyLabel.
  ///
  /// In en, this message translates to:
  /// **'Add Manually'**
  String get addManuallyLabel;

  /// No description provided for @iconTabLabel.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get iconTabLabel;

  /// No description provided for @emojiTabLabel.
  ///
  /// In en, this message translates to:
  /// **'Emoji'**
  String get emojiTabLabel;

  /// No description provided for @colorPaletteTitle.
  ///
  /// In en, this message translates to:
  /// **'Color Palette'**
  String get colorPaletteTitle;

  /// No description provided for @iconSelectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Icon Selection'**
  String get iconSelectionTitle;

  /// No description provided for @selectEmojiTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Emoji'**
  String get selectEmojiTitle;

  /// No description provided for @saveSelectionLabel.
  ///
  /// In en, this message translates to:
  /// **'Save Selection'**
  String get saveSelectionLabel;

  /// No description provided for @changeCurrencyTitle.
  ///
  /// In en, this message translates to:
  /// **'Change currency'**
  String get changeCurrencyTitle;

  /// No description provided for @changeDisplayCurrencyTitle.
  ///
  /// In en, this message translates to:
  /// **'Change display currency?'**
  String get changeDisplayCurrencyTitle;

  /// No description provided for @confirmChangeCurrencyContent.
  ///
  /// In en, this message translates to:
  /// **'Your base currency will change to {newCurrency}. All past payments will be recalculated using the historical exchange rate from the date they were recorded.'**
  String confirmChangeCurrencyContent(String newCurrency);

  /// No description provided for @cancelButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButtonLabel;

  /// No description provided for @changeButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get changeButtonLabel;

  /// No description provided for @currencyChangedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Currency changed to {newCurrency}. {count} payments recalculated.'**
  String currencyChangedSuccess(String newCurrency, int count);

  /// No description provided for @failedToChangeCurrency.
  ///
  /// In en, this message translates to:
  /// **'Failed to change currency. Please try again.'**
  String get failedToChangeCurrency;

  /// No description provided for @baseCurrencyTitle.
  ///
  /// In en, this message translates to:
  /// **'Base Currency'**
  String get baseCurrencyTitle;

  /// No description provided for @selectBaseCurrencyDesc.
  ///
  /// In en, this message translates to:
  /// **'Please select your base currency. This will be used for all calculations and displays in the app.'**
  String get selectBaseCurrencyDesc;

  /// No description provided for @failedToSaveBaseCurrency.
  ///
  /// In en, this message translates to:
  /// **'Base currency could not be saved. Please try again.'**
  String get failedToSaveBaseCurrency;

  /// No description provided for @selectBaseCurrencyHint.
  ///
  /// In en, this message translates to:
  /// **'Select base currency'**
  String get selectBaseCurrencyHint;

  /// No description provided for @warningBannerText.
  ///
  /// In en, this message translates to:
  /// **'You can change your base currency anytime in Settings. Your previous payments will be automatically recalculated.'**
  String get warningBannerText;

  /// No description provided for @onboardingFeaturePrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy-First: All data is saved locally on your device.'**
  String get onboardingFeaturePrivacy;

  /// No description provided for @onboardingFeatureCurrency.
  ///
  /// In en, this message translates to:
  /// **'Multi-Currency: Automatic exchange rate conversions.'**
  String get onboardingFeatureCurrency;

  /// No description provided for @onboardingFeatureAlerts.
  ///
  /// In en, this message translates to:
  /// **'Smart Alerts: Get notified before your bills are due.'**
  String get onboardingFeatureAlerts;

  /// No description provided for @onboardingPage1Title.
  ///
  /// In en, this message translates to:
  /// **'Privacy-First Tracker'**
  String get onboardingPage1Title;

  /// No description provided for @onboardingPage1Subtitle.
  ///
  /// In en, this message translates to:
  /// **'All your subscription data is stored locally and securely on your device. No registration required.'**
  String get onboardingPage1Subtitle;

  /// No description provided for @onboardingPage2Title.
  ///
  /// In en, this message translates to:
  /// **'Track in Any Currency'**
  String get onboardingPage2Title;

  /// No description provided for @onboardingPage2Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Add subscriptions in different currencies. Rates are fetched daily and converted to your base currency.'**
  String get onboardingPage2Subtitle;

  /// No description provided for @onboardingPage3Title.
  ///
  /// In en, this message translates to:
  /// **'Never Pay Unwanted Bills'**
  String get onboardingPage3Title;

  /// No description provided for @onboardingPage3Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Get smart alerts before your bills are due. Stay in control of your recurring expenses.'**
  String get onboardingPage3Subtitle;

  /// No description provided for @getStartedButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStartedButtonLabel;

  /// No description provided for @skipButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skipButtonLabel;

  /// No description provided for @continueButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButtonLabel;

  /// No description provided for @filterPaymentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter payments'**
  String get filterPaymentsTitle;

  /// No description provided for @fromDateLabel.
  ///
  /// In en, this message translates to:
  /// **'From date'**
  String get fromDateLabel;

  /// No description provided for @toDateLabel.
  ///
  /// In en, this message translates to:
  /// **'To date'**
  String get toDateLabel;

  /// No description provided for @clearLabel.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clearLabel;

  /// No description provided for @applyLabel.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get applyLabel;

  /// No description provided for @markAsPaid.
  ///
  /// In en, this message translates to:
  /// **'Mark as paid'**
  String get markAsPaid;

  /// No description provided for @markPaidSuccess.
  ///
  /// In en, this message translates to:
  /// **'This subscription is already marked paid for this month.'**
  String get markPaidSuccess;

  /// No description provided for @markPaidFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to record payment. Please try again.'**
  String get markPaidFailed;

  /// No description provided for @paymentDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Payment date'**
  String get paymentDateLabel;

  /// No description provided for @amountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amountLabel;

  /// No description provided for @savePaymentLabel.
  ///
  /// In en, this message translates to:
  /// **'Save payment'**
  String get savePaymentLabel;

  /// No description provided for @equivalentLabel.
  ///
  /// In en, this message translates to:
  /// **'Equivalent'**
  String get equivalentLabel;

  /// No description provided for @billingCycleLabel.
  ///
  /// In en, this message translates to:
  /// **'Billing cycle'**
  String get billingCycleLabel;

  /// No description provided for @nextPaymentLabel.
  ///
  /// In en, this message translates to:
  /// **'Next payment'**
  String get nextPaymentLabel;

  /// No description provided for @anchorDayLabel.
  ///
  /// In en, this message translates to:
  /// **'Anchor day'**
  String get anchorDayLabel;

  /// No description provided for @alreadyPaidThisMonth.
  ///
  /// In en, this message translates to:
  /// **'Already paid this month'**
  String get alreadyPaidThisMonth;

  /// No description provided for @recentPaymentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent payments'**
  String get recentPaymentsTitle;

  /// No description provided for @countRecorded.
  ///
  /// In en, this message translates to:
  /// **'{count} recorded'**
  String countRecorded(int count);

  /// No description provided for @weeklyLabel.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weeklyLabel;

  /// No description provided for @quarterlyLabel.
  ///
  /// In en, this message translates to:
  /// **'Quarterly'**
  String get quarterlyLabel;

  /// No description provided for @paymentsMadeTitle.
  ///
  /// In en, this message translates to:
  /// **'Payments made'**
  String get paymentsMadeTitle;

  /// No description provided for @noPaymentsRecordedThisMonth.
  ///
  /// In en, this message translates to:
  /// **'No payments were recorded this month yet.'**
  String get noPaymentsRecordedThisMonth;

  /// No description provided for @paymentsCompletedDesc.
  ///
  /// In en, this message translates to:
  /// **'Completed payments for the current month.'**
  String get paymentsCompletedDesc;

  /// No description provided for @unknownSubscriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Unknown subscription'**
  String get unknownSubscriptionLabel;

  /// No description provided for @upgradeToProTitle.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro'**
  String get upgradeToProTitle;

  /// No description provided for @proBenefitsTitle.
  ///
  /// In en, this message translates to:
  /// **'Pro Benefits'**
  String get proBenefitsTitle;

  /// No description provided for @proBenefit1.
  ///
  /// In en, this message translates to:
  /// **'Cloud backup for your local data'**
  String get proBenefit1;

  /// No description provided for @proBenefit2.
  ///
  /// In en, this message translates to:
  /// **'Sync across your devices'**
  String get proBenefit2;

  /// No description provided for @proBenefit3.
  ///
  /// In en, this message translates to:
  /// **'Safer recovery when switching phones'**
  String get proBenefit3;

  /// No description provided for @proOfflineDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Your current app keeps working fully offline. Pro only adds optional sync and backup.'**
  String get proOfflineDisclaimer;

  /// No description provided for @proUpgradeSoon.
  ///
  /// In en, this message translates to:
  /// **'Pro purchase flow will be available soon.'**
  String get proUpgradeSoon;

  /// No description provided for @continueToProLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue to Pro'**
  String get continueToProLabel;

  /// No description provided for @analyticsScreenPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Analytics Screen'**
  String get analyticsScreenPlaceholder;

  /// No description provided for @thisMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get thisMonth;

  /// No description provided for @thisMonthSubtitle.
  ///
  /// In en, this message translates to:
  /// **'See what is expected and what has already been paid.'**
  String get thisMonthSubtitle;

  /// No description provided for @proUnlockMessage.
  ///
  /// In en, this message translates to:
  /// **'Unlock Pro to view your spending distribution and monthly trends.'**
  String get proUnlockMessage;

  /// No description provided for @proUnlockedSuccess.
  ///
  /// In en, this message translates to:
  /// **'PayTempo Pro unlocked!'**
  String get proUnlockedSuccess;

  /// No description provided for @spendingByCategory.
  ///
  /// In en, this message translates to:
  /// **'Spending by Category'**
  String get spendingByCategory;

  /// No description provided for @monthlyTrends.
  ///
  /// In en, this message translates to:
  /// **'Monthly Trends'**
  String get monthlyTrends;

  /// No description provided for @noDataForAnalytics.
  ///
  /// In en, this message translates to:
  /// **'No payment data available for this month.'**
  String get noDataForAnalytics;

  /// No description provided for @last6Months.
  ///
  /// In en, this message translates to:
  /// **'Last 6 Months'**
  String get last6Months;

  /// No description provided for @totalSpending.
  ///
  /// In en, this message translates to:
  /// **'Total Spending'**
  String get totalSpending;

  /// No description provided for @billingCycleBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Billing Cycle Breakdown'**
  String get billingCycleBreakdown;

  /// No description provided for @monthlySubscriptions.
  ///
  /// In en, this message translates to:
  /// **'Monthly Subscriptions'**
  String get monthlySubscriptions;

  /// No description provided for @yearlySubscriptions.
  ///
  /// In en, this message translates to:
  /// **'Yearly Subscriptions'**
  String get yearlySubscriptions;

  /// No description provided for @equivalentMonthlyTotal.
  ///
  /// In en, this message translates to:
  /// **'Equivalent Monthly Cost'**
  String get equivalentMonthlyTotal;

  /// No description provided for @equivalentYearlyTotal.
  ///
  /// In en, this message translates to:
  /// **'Equivalent Yearly Cost'**
  String get equivalentYearlyTotal;

  /// No description provided for @monthlyCycleLabel.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthlyCycleLabel;

  /// No description provided for @yearlyCycleLabel.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get yearlyCycleLabel;

  /// No description provided for @potentialSavingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Optimize Savings'**
  String get potentialSavingsTitle;

  /// No description provided for @potentialSavingsDesc.
  ///
  /// In en, this message translates to:
  /// **'Consider switching monthly subscriptions to yearly billing to save up to 20% annually.'**
  String get potentialSavingsDesc;

  /// No description provided for @manageCategories.
  ///
  /// In en, this message translates to:
  /// **'Custom Categories'**
  String get manageCategories;

  /// No description provided for @manageCategoriesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add or remove custom subscription categories.'**
  String get manageCategoriesSubtitle;

  /// No description provided for @addCategory.
  ///
  /// In en, this message translates to:
  /// **'Add Category'**
  String get addCategory;

  /// No description provided for @deleteCategory.
  ///
  /// In en, this message translates to:
  /// **'Delete Category'**
  String get deleteCategory;

  /// No description provided for @deleteCategoryConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this category? Subscriptions using it will keep their category name but will fall back to a default icon.'**
  String get deleteCategoryConfirm;

  /// No description provided for @categoryNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Category Name'**
  String get categoryNameLabel;

  /// No description provided for @categoryNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Category name is required.'**
  String get categoryNameRequired;

  /// No description provided for @categoryNameMinLength.
  ///
  /// In en, this message translates to:
  /// **'Name must be at least 2 characters.'**
  String get categoryNameMinLength;

  /// No description provided for @categoryNameExists.
  ///
  /// In en, this message translates to:
  /// **'A category with this name already exists.'**
  String get categoryNameExists;

  /// No description provided for @addCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Add Custom Category'**
  String get addCategoryLabel;

  /// No description provided for @categoryIconLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Icon'**
  String get categoryIconLabel;

  /// No description provided for @categorySavedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Category created successfully.'**
  String get categorySavedSuccess;

  /// No description provided for @failedToSaveCategory.
  ///
  /// In en, this message translates to:
  /// **'Failed to create category.'**
  String get failedToSaveCategory;

  /// No description provided for @categoryDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Category deleted.'**
  String get categoryDeletedSuccess;

  /// No description provided for @noCustomCategoriesYet.
  ///
  /// In en, this message translates to:
  /// **'No custom categories created yet. Tap \'+\' to add one.'**
  String get noCustomCategoriesYet;

  /// No description provided for @searchTemplates.
  ///
  /// In en, this message translates to:
  /// **'Search services...'**
  String get searchTemplates;

  /// No description provided for @allLabel.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allLabel;

  /// No description provided for @notification1DayBeforeTitle.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Payment'**
  String get notification1DayBeforeTitle;

  /// No description provided for @notification1DayBeforeBody.
  ///
  /// In en, this message translates to:
  /// **'Your subscription for {name} ({price} {currency}) is due tomorrow.'**
  String notification1DayBeforeBody(String name, String price, String currency);

  /// No description provided for @notificationDueTodayTitle.
  ///
  /// In en, this message translates to:
  /// **'Subscription Due Today'**
  String get notificationDueTodayTitle;

  /// No description provided for @notificationDueTodayBody.
  ///
  /// In en, this message translates to:
  /// **'Your subscription for {name} ({price} {currency}) is due today.'**
  String notificationDueTodayBody(String name, String price, String currency);

  /// No description provided for @notificationsLabel.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsLabel;

  /// No description provided for @notificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enable or disable reminders for upcoming bills.'**
  String get notificationsSubtitle;

  /// No description provided for @notificationsEnabledSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Reminders are scheduled for this subscription.'**
  String get notificationsEnabledSubtitle;

  /// No description provided for @notificationsDisabledSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Reminders are turned off for this subscription.'**
  String get notificationsDisabledSubtitle;

  /// No description provided for @manageSubscriptionDetailLabel.
  ///
  /// In en, this message translates to:
  /// **'Manage & History'**
  String get manageSubscriptionDetailLabel;

  /// No description provided for @subscriptionManageTitle.
  ///
  /// In en, this message translates to:
  /// **'Subscription Details'**
  String get subscriptionManageTitle;

  /// No description provided for @totalSpentLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Spent'**
  String get totalSpentLabel;

  /// No description provided for @editSubscription.
  ///
  /// In en, this message translates to:
  /// **'Edit Subscription'**
  String get editSubscription;

  /// No description provided for @deleteSubscription.
  ///
  /// In en, this message translates to:
  /// **'Delete Subscription'**
  String get deleteSubscription;

  /// No description provided for @deleteSubscriptionConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this subscription? This will cancel all upcoming reminders and keep payment history as read-only.'**
  String get deleteSubscriptionConfirm;

  /// No description provided for @subscriptionDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Subscription deleted.'**
  String get subscriptionDeletedSuccess;

  /// No description provided for @subscriptionUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Subscription updated.'**
  String get subscriptionUpdatedSuccess;

  /// No description provided for @backupAndRecovery.
  ///
  /// In en, this message translates to:
  /// **'Backup & Recovery'**
  String get backupAndRecovery;

  /// No description provided for @backupAndRecoverySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Export or import your subscription data locally.'**
  String get backupAndRecoverySubtitle;

  /// No description provided for @exportData.
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get exportData;

  /// No description provided for @exportDataSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Save your subscriptions and payments as a JSON file.'**
  String get exportDataSubtitle;

  /// No description provided for @importData.
  ///
  /// In en, this message translates to:
  /// **'Import Data'**
  String get importData;

  /// No description provided for @importDataSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Restore data from a previously saved backup file.'**
  String get importDataSubtitle;

  /// No description provided for @confirmRestoreTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Restore'**
  String get confirmRestoreTitle;

  /// No description provided for @confirmRestoreMessage.
  ///
  /// In en, this message translates to:
  /// **'This will overwrite all your current local data. Are you sure you want to proceed?'**
  String get confirmRestoreMessage;

  /// No description provided for @exportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Data exported successfully.'**
  String get exportSuccess;

  /// No description provided for @exportFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to export data.'**
  String get exportFailed;

  /// No description provided for @importSuccess.
  ///
  /// In en, this message translates to:
  /// **'Data restored successfully.'**
  String get importSuccess;

  /// No description provided for @importFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to import data.'**
  String get importFailed;

  /// No description provided for @invalidBackupFile.
  ///
  /// In en, this message translates to:
  /// **'Selected file is not a valid PayTempo backup.'**
  String get invalidBackupFile;

  /// No description provided for @restoreWarning.
  ///
  /// In en, this message translates to:
  /// **'Warning: Restoring data will overwrite your current settings, subscriptions, and payment history.'**
  String get restoreWarning;

  /// No description provided for @searchActiveSubscriptions.
  ///
  /// In en, this message translates to:
  /// **'Search subscriptions...'**
  String get searchActiveSubscriptions;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get sortBy;

  /// No description provided for @sortByDueDate.
  ///
  /// In en, this message translates to:
  /// **'Payment Date'**
  String get sortByDueDate;

  /// No description provided for @sortByName.
  ///
  /// In en, this message translates to:
  /// **'Name (A-Z)'**
  String get sortByName;

  /// No description provided for @sortByPriceHigh.
  ///
  /// In en, this message translates to:
  /// **'Price (High to Low)'**
  String get sortByPriceHigh;

  /// No description provided for @sortByPriceLow.
  ///
  /// In en, this message translates to:
  /// **'Price (Low to High)'**
  String get sortByPriceLow;

  /// No description provided for @noSubscriptionsMatchSearch.
  ///
  /// In en, this message translates to:
  /// **'No subscriptions match your search.'**
  String get noSubscriptionsMatchSearch;

  /// No description provided for @offlineRatesWarning.
  ///
  /// In en, this message translates to:
  /// **'Exchange rates could not be updated. Using cached rates from {date}.'**
  String offlineRatesWarning(String date);

  /// No description provided for @offlineRatesWarningNoCache.
  ///
  /// In en, this message translates to:
  /// **'No cached exchange rates available. Please check your internet connection.'**
  String get offlineRatesWarningNoCache;
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
