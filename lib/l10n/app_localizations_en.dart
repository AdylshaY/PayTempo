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

  @override
  String get subscriptionNameLabel => 'Subscription Name';

  @override
  String get subscriptionNameHint => 'Example: Netflix';

  @override
  String get subscriptionNameRequired => 'Subscription name is required.';

  @override
  String get subscriptionNameMinLength => 'Please enter at least 2 characters.';

  @override
  String get noteLabel => 'Note / Description (Optional)';

  @override
  String get noteHint => 'Example: Spouse\'s line, personal account';

  @override
  String get categoryStreaming => 'Streaming';

  @override
  String get categoryMusic => 'Music';

  @override
  String get categoryVideo => 'Video';

  @override
  String get categoryCloud => 'Cloud';

  @override
  String get categoryAi => 'AI';

  @override
  String get categoryProductivity => 'Productivity';

  @override
  String get categoryGaming => 'Gaming';

  @override
  String get categoryNews => 'News';

  @override
  String get categoryHousing => 'Housing/Rent';

  @override
  String get categoryUtilities => 'Bills/Utilities';

  @override
  String get categoryFinance => 'Finance/Installment';

  @override
  String get isInstallmentLabel => 'Installment Payment';

  @override
  String get totalInstallmentsLabel => 'Total Installments';

  @override
  String get remainingInstallmentsLabel => 'Remaining Installments';

  @override
  String installmentProgress(int current, int total) {
    return 'Installment $current of $total';
  }

  @override
  String get installmentsCompleted => 'Installments Completed';

  @override
  String get validationInstallmentRange =>
      'Remaining installments cannot exceed total installments.';

  @override
  String get fieldRequired => 'This field is required.';

  @override
  String get invalidNumber => 'Please enter a valid number.';

  @override
  String get templateRent => 'Rent';

  @override
  String get templateElectricity => 'Electricity Bill';

  @override
  String get templateWater => 'Water Bill';

  @override
  String get templateGas => 'Gas Bill';

  @override
  String get templateInternet => 'Internet Bill';

  @override
  String get templateInstallment => 'Card Installment';

  @override
  String get currencyTRY => 'Turkish Lira';

  @override
  String get currencyUSD => 'US Dollar';

  @override
  String get currencyEUR => 'Euro';

  @override
  String get currencyGBP => 'British Pound';

  @override
  String get currencyJPY => 'Japanese Yen';

  @override
  String get currencyCNY => 'Chinese Yuan';

  @override
  String get currencyCAD => 'Canadian Dollar';

  @override
  String get currencyAUD => 'Australian Dollar';

  @override
  String get currencyCHF => 'Swiss Franc';

  @override
  String get presetServiceSettings => 'Preset Service Settings';

  @override
  String get newSubscription => 'New Subscription';

  @override
  String get avatarLabel => 'Avatar';

  @override
  String get presetAvatarDesc =>
      'This is a preset avatar based on the selected service.';

  @override
  String get tapToSelectAvatarDesc => 'Tap to select an icon, emoji, or color.';

  @override
  String get categoryLabel => 'Category';

  @override
  String get priceLabel => 'Price';

  @override
  String get priceHint => 'Example: 9.99';

  @override
  String get priceRequired => 'Price is required.';

  @override
  String get currencyLabel => 'Currency';

  @override
  String get monthlyLabel => 'Monthly';

  @override
  String get yearlyLabel => 'Yearly';

  @override
  String get firstPaymentDateLabel => 'First Payment Date';

  @override
  String get saveSubscriptionLabel => 'Save Subscription';

  @override
  String get enterValidAmount => 'Please enter a valid amount.';

  @override
  String get failedToSaveSubscription =>
      'Failed to save subscription. Please try again.';

  @override
  String get presetServicesTitle => 'Preset Services';

  @override
  String get pickServiceSubtitle =>
      'Pick a service. You can enter the price on the next form screen.';

  @override
  String get addManuallyLabel => 'Add Manually';

  @override
  String get iconTabLabel => 'Icon';

  @override
  String get emojiTabLabel => 'Emoji';

  @override
  String get colorPaletteTitle => 'Color Palette';

  @override
  String get iconSelectionTitle => 'Icon Selection';

  @override
  String get selectEmojiTitle => 'Select Emoji';

  @override
  String get saveSelectionLabel => 'Save Selection';

  @override
  String get changeCurrencyTitle => 'Change currency';

  @override
  String get changeDisplayCurrencyTitle => 'Change display currency?';

  @override
  String confirmChangeCurrencyContent(String newCurrency) {
    return 'Your base currency will change to $newCurrency. All past payments will be recalculated using the historical exchange rate from the date they were recorded.';
  }

  @override
  String get cancelButtonLabel => 'Cancel';

  @override
  String get changeButtonLabel => 'Change';

  @override
  String currencyChangedSuccess(String newCurrency, int count) {
    return 'Currency changed to $newCurrency. $count payments recalculated.';
  }

  @override
  String get failedToChangeCurrency =>
      'Failed to change currency. Please try again.';

  @override
  String get baseCurrencyTitle => 'Base Currency';

  @override
  String get selectBaseCurrencyDesc =>
      'Please select your base currency. This will be used for all calculations and displays in the app.';

  @override
  String get failedToSaveBaseCurrency =>
      'Base currency could not be saved. Please try again.';

  @override
  String get selectBaseCurrencyHint => 'Select base currency';

  @override
  String get warningBannerText =>
      'You can change your base currency anytime in Settings. Your previous payments will be automatically recalculated.';

  @override
  String get onboardingFeaturePrivacy =>
      'Privacy-First: All data is saved locally on your device.';

  @override
  String get onboardingFeatureCurrency =>
      'Multi-Currency: Automatic exchange rate conversions.';

  @override
  String get onboardingFeatureAlerts =>
      'Smart Alerts: Get notified before your bills are due.';

  @override
  String get onboardingPage1Title => 'Privacy-First Tracker';

  @override
  String get onboardingPage1Subtitle =>
      'All your subscription data is stored locally and securely on your device. No registration required.';

  @override
  String get onboardingPage2Title => 'Track in Any Currency';

  @override
  String get onboardingPage2Subtitle =>
      'Add subscriptions in different currencies. Rates are fetched daily and converted to your base currency.';

  @override
  String get onboardingPage3Title => 'Never Pay Unwanted Bills';

  @override
  String get onboardingPage3Subtitle =>
      'Get smart alerts before your bills are due. Stay in control of your recurring expenses.';

  @override
  String get getStartedButtonLabel => 'Get Started';

  @override
  String get skipButtonLabel => 'Skip';

  @override
  String get continueButtonLabel => 'Continue';

  @override
  String get filterPaymentsTitle => 'Filter payments';

  @override
  String get fromDateLabel => 'From date';

  @override
  String get toDateLabel => 'To date';

  @override
  String get clearLabel => 'Clear';

  @override
  String get applyLabel => 'Apply';

  @override
  String get markAsPaid => 'Mark as paid';

  @override
  String get markPaidSuccess =>
      'This subscription is already marked paid for this month.';

  @override
  String get markPaidFailed => 'Failed to record payment. Please try again.';

  @override
  String get paymentDateLabel => 'Payment date';

  @override
  String get amountLabel => 'Amount';

  @override
  String get savePaymentLabel => 'Save payment';

  @override
  String get equivalentLabel => 'Equivalent';

  @override
  String get billingCycleLabel => 'Billing cycle';

  @override
  String get nextPaymentLabel => 'Next payment';

  @override
  String get anchorDayLabel => 'Anchor day';

  @override
  String get alreadyPaidThisMonth => 'Already paid this month';

  @override
  String get recentPaymentsTitle => 'Recent payments';

  @override
  String countRecorded(int count) {
    return '$count recorded';
  }

  @override
  String get weeklyLabel => 'Weekly';

  @override
  String get quarterlyLabel => 'Quarterly';

  @override
  String get paymentsMadeTitle => 'Payments made';

  @override
  String get noPaymentsRecordedThisMonth =>
      'No payments were recorded this month yet.';

  @override
  String get paymentsCompletedDesc =>
      'Completed payments for the current month.';

  @override
  String get unknownSubscriptionLabel => 'Unknown subscription';

  @override
  String get upgradeToProTitle => 'Upgrade to Pro';

  @override
  String get proBenefitsTitle => 'Pro Benefits';

  @override
  String get proBenefit1 => 'Cloud backup for your local data';

  @override
  String get proBenefit2 => 'Sync across your devices';

  @override
  String get proBenefit3 => 'Safer recovery when switching phones';

  @override
  String get proOfflineDisclaimer =>
      'Your current app keeps working fully offline. Pro only adds optional sync and backup.';

  @override
  String get proUpgradeSoon => 'Pro purchase flow will be available soon.';

  @override
  String get continueToProLabel => 'Continue to Pro';

  @override
  String get analyticsScreenPlaceholder => 'Analytics Screen';

  @override
  String get thisMonth => 'This Month';

  @override
  String get thisMonthSubtitle =>
      'See what is expected and what has already been paid.';

  @override
  String get proUnlockMessage =>
      'Unlock Pro to view your spending distribution and monthly trends.';

  @override
  String get proUnlockedSuccess => 'PayTempo Pro unlocked!';

  @override
  String get spendingByCategory => 'Spending by Category';

  @override
  String get monthlyTrends => 'Monthly Trends';

  @override
  String get noDataForAnalytics => 'No payment data available for this month.';

  @override
  String get last6Months => 'Last 6 Months';

  @override
  String get totalSpending => 'Total Spending';

  @override
  String get billingCycleBreakdown => 'Billing Cycle Breakdown';

  @override
  String get monthlySubscriptions => 'Monthly Subscriptions';

  @override
  String get yearlySubscriptions => 'Yearly Subscriptions';

  @override
  String get equivalentMonthlyTotal => 'Equivalent Monthly Cost';

  @override
  String get equivalentYearlyTotal => 'Equivalent Yearly Cost';

  @override
  String get monthlyCycleLabel => 'Monthly';

  @override
  String get yearlyCycleLabel => 'Yearly';

  @override
  String get potentialSavingsTitle => 'Optimize Savings';

  @override
  String get potentialSavingsDesc =>
      'Consider switching monthly subscriptions to yearly billing to save up to 20% annually.';

  @override
  String get manageCategories => 'Custom Categories';

  @override
  String get manageCategoriesSubtitle =>
      'Add or remove custom subscription categories.';

  @override
  String get addCategory => 'Add Category';

  @override
  String get deleteCategory => 'Delete Category';

  @override
  String get deleteCategoryConfirm =>
      'Are you sure you want to delete this category? Subscriptions using it will keep their category name but will fall back to a default icon.';

  @override
  String get categoryNameLabel => 'Category Name';

  @override
  String get categoryNameRequired => 'Category name is required.';

  @override
  String get categoryNameMinLength => 'Name must be at least 2 characters.';

  @override
  String get categoryNameExists => 'A category with this name already exists.';

  @override
  String get addCategoryLabel => 'Add Custom Category';

  @override
  String get categoryIconLabel => 'Select Icon';

  @override
  String get categorySavedSuccess => 'Category created successfully.';

  @override
  String get failedToSaveCategory => 'Failed to create category.';

  @override
  String get categoryDeletedSuccess => 'Category deleted.';

  @override
  String get noCustomCategoriesYet =>
      'No custom categories created yet. Tap \'+\' to add one.';

  @override
  String get searchTemplates => 'Search services...';

  @override
  String get allLabel => 'All';

  @override
  String get notification1DayBeforeTitle => 'Upcoming Payment';

  @override
  String notification1DayBeforeBody(
    String name,
    String price,
    String currency,
  ) {
    return 'Your subscription for $name ($price $currency) is due tomorrow.';
  }

  @override
  String get notificationDueTodayTitle => 'Subscription Due Today';

  @override
  String notificationDueTodayBody(String name, String price, String currency) {
    return 'Your subscription for $name ($price $currency) is due today.';
  }

  @override
  String get notificationsLabel => 'Notifications';

  @override
  String get notificationsSubtitle =>
      'Enable or disable reminders for upcoming bills.';

  @override
  String get notificationsEnabledSubtitle =>
      'Reminders are scheduled for this subscription.';

  @override
  String get notificationsDisabledSubtitle =>
      'Reminders are turned off for this subscription.';

  @override
  String get manageSubscriptionDetailLabel => 'Manage & History';

  @override
  String get subscriptionManageTitle => 'Subscription Details';

  @override
  String get totalSpentLabel => 'Total Spent';

  @override
  String get editSubscription => 'Edit Subscription';

  @override
  String get deleteSubscription => 'Delete Subscription';

  @override
  String get deleteSubscriptionConfirm =>
      'Are you sure you want to delete this subscription? This will cancel all upcoming reminders and keep payment history as read-only.';

  @override
  String get subscriptionDeletedSuccess => 'Subscription deleted.';

  @override
  String get subscriptionUpdatedSuccess => 'Subscription updated.';

  @override
  String get backupAndRecovery => 'Backup & Recovery';

  @override
  String get backupAndRecoverySubtitle =>
      'Export or import your subscription data locally.';

  @override
  String get exportData => 'Export Data';

  @override
  String get exportDataSubtitle =>
      'Save your subscriptions and payments as a JSON file.';

  @override
  String get importData => 'Import Data';

  @override
  String get importDataSubtitle =>
      'Restore data from a previously saved backup file.';

  @override
  String get confirmRestoreTitle => 'Confirm Restore';

  @override
  String get confirmRestoreMessage =>
      'This will overwrite all your current local data. Are you sure you want to proceed?';

  @override
  String get exportSuccess => 'Data exported successfully.';

  @override
  String get exportFailed => 'Failed to export data.';

  @override
  String get importSuccess => 'Data restored successfully.';

  @override
  String get importFailed => 'Failed to import data.';

  @override
  String get invalidBackupFile =>
      'Selected file is not a valid PayTempo backup.';

  @override
  String get restoreWarning =>
      'Warning: Restoring data will overwrite your current settings, subscriptions, and payment history.';

  @override
  String get searchActiveSubscriptions => 'Search subscriptions...';

  @override
  String get sortBy => 'Sort by';

  @override
  String get sortByDueDate => 'Payment Date';

  @override
  String get sortByName => 'Name (A-Z)';

  @override
  String get sortByPriceHigh => 'Price (High to Low)';

  @override
  String get sortByPriceLow => 'Price (Low to High)';

  @override
  String get noSubscriptionsMatchSearch =>
      'No subscriptions match your search.';

  @override
  String offlineRatesWarning(String date) {
    return 'Exchange rates could not be updated. Using cached rates from $date.';
  }

  @override
  String get offlineRatesWarningNoCache =>
      'No cached exchange rates available. Please check your internet connection.';

  @override
  String get shareSubscription => 'Share subscription';

  @override
  String get budgetLabel => 'Monthly Budget';

  @override
  String budgetOf(String spent, String limit, String currency) {
    return '$spent / $limit $currency';
  }

  @override
  String get budgetExceeded => 'Budget exceeded!';

  @override
  String get budgetNotSet => 'No budget set';

  @override
  String get setBudget => 'Set Budget';

  @override
  String get removeBudget => 'Remove Budget';

  @override
  String get budgetSettingDesc =>
      'Set a monthly spending limit for your subscriptions.';

  @override
  String get budgetAmountHint => 'Amount';

  @override
  String get upcomingPayments => 'Upcoming Payments';

  @override
  String seeAllCount(int count) {
    return 'See All ($count)';
  }

  @override
  String get noUpcomingPayments => 'All caught up! No upcoming payments.';

  @override
  String get heroStatActive => 'Active';

  @override
  String get heroStatPaid => 'Paid';

  @override
  String get heroStatEstimated => 'Estimated';

  @override
  String get calendarView => 'Calendar';

  @override
  String get listView => 'List';

  @override
  String get noPaymentsOnDay => 'No payments on this day';

  @override
  String get notificationTimeLabel => 'Notification Time';

  @override
  String get notificationTimeDesc =>
      'Set the default time to receive daily reminders';

  @override
  String get reminderDaysLabel => 'Reminders';

  @override
  String get reminderSameDay => 'Same Day';

  @override
  String get reminder1DayBefore => '1 Day Before';

  @override
  String get reminder2DaysBefore => '2 Days Before';

  @override
  String get reminder3DaysBefore => '3 Days Before';

  @override
  String get reminder7DaysBefore => '1 Week Before';

  @override
  String get notificationDaysBeforeTitle => 'Upcoming Payment';

  @override
  String notificationDaysBeforeBody(
    String name,
    String days,
    String price,
    String currency,
  ) {
    return '$name is due in $days days ($price $currency)';
  }

  @override
  String get pauseSubscription => 'Pause Subscription';

  @override
  String get resumeSubscription => 'Resume Subscription';

  @override
  String get subscriptionPausedSuccess => 'Subscription paused successfully.';

  @override
  String get subscriptionResumedSuccess =>
      'Subscription activated successfully.';

  @override
  String get pausedStatus => 'Paused';

  @override
  String get activeStatus => 'Active';

  @override
  String get pauseConfirmTitle => 'Pause Subscription?';

  @override
  String get pauseConfirmBody =>
      'When you pause this subscription, upcoming payments will be excluded from calculations and reminders will be temporarily disabled.';

  @override
  String get pausedSubscriptions => 'Paused Subscriptions';
}
