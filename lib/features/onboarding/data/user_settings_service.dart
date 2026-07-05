import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:pay_tempo/data/local/isar_database.dart';
import 'package:pay_tempo/data/local/models/payment_transaction.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';
import 'package:pay_tempo/data/local/models/user_settings.dart';
import 'package:pay_tempo/data/local/services/exchange_rate_service.dart';
import 'package:pay_tempo/data/local/services/notification_service.dart';

class UserSettingsService {
  UserSettingsService({Isar? isar}) : _isar = isar ?? LocalDatabase.instance.isar;

  final Isar _isar;

  /// Global notifier for the app theme to enable instant UI updates.
  static final ValueNotifier<ThemeMode> appThemeNotifier =
      ValueNotifier(ThemeMode.system);

  /// Global notifier for the app language to enable instant UI updates.
  static final ValueNotifier<String?> appLanguageNotifier = ValueNotifier(null);

  /// Global notifier for the base currency to enable instant UI updates
  /// when the user changes their display currency.
  static final ValueNotifier<String> baseCurrencyNotifier =
      ValueNotifier('USD');

  /// Global notifier for notifications configuration to enable instant UI updates.
  static final ValueNotifier<bool> notificationsEnabledNotifier =
      ValueNotifier(true);

  /// Global notifier for the notification time hour.
  static final ValueNotifier<int> notificationHourNotifier = ValueNotifier(9);

  /// Global notifier for the notification time minute.
  static final ValueNotifier<int> notificationMinuteNotifier = ValueNotifier(0);

  /// Global notifier for the monthly budget limit.
  /// Null means no budget has been set.
  static final ValueNotifier<double?> budgetLimitNotifier =
      ValueNotifier(null);

  /// Converts Isar AppThemeMode enum to Flutter ThemeMode.
  ThemeMode _toFlutterThemeMode(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  /// Initializes the notifiers with values from the database.
  Future<void> initializeSettings() async {
    final settings = await getSettings();
    if (settings != null) {
      appThemeNotifier.value = _toFlutterThemeMode(settings.themeMode);
      appLanguageNotifier.value = settings.languageCode;
      notificationsEnabledNotifier.value = settings.notificationsEnabled;
      budgetLimitNotifier.value = settings.monthlyBudgetLimit;
      notificationHourNotifier.value = settings.notificationHour;
      notificationMinuteNotifier.value = settings.notificationMinute;
      if (settings.baseCurrency.trim().isNotEmpty) {
        baseCurrencyNotifier.value = settings.baseCurrency.trim().toUpperCase();
      }
    }
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    await _isar.writeTxn(() async {
      final UserSettings? current = await _isar.userSettings.get(1);
      if (current != null) {
        current.themeMode = mode;
        await _isar.userSettings.put(current);
        appThemeNotifier.value = _toFlutterThemeMode(mode);
      }
    });
  }

  Future<void> setLanguageCode(String? code) async {
    await _isar.writeTxn(() async {
      final UserSettings? current = await _isar.userSettings.get(1);
      if (current != null) {
        current.languageCode = code;
        await _isar.userSettings.put(current);
        appLanguageNotifier.value = code;
      }
    });
  }

  Future<UserSettings?> getSettings() {
    return _isar.userSettings.get(1);
  }

  Future<bool> hasBaseCurrency() async {
    final UserSettings? settings = await getSettings();
    final String? currency = settings?.baseCurrency;
    if (currency == null) {
      return false;
    }
    return currency.trim().isNotEmpty;
  }

  /// Saves the base currency during onboarding (first time only).
  Future<void> saveBaseCurrency(String baseCurrency) async {
    final String normalized = baseCurrency.trim().toUpperCase();

    await _isar.writeTxn(() async {
      final UserSettings? current = await _isar.userSettings.get(1);
      if (current == null) {
        await _isar.userSettings.put(
          UserSettings(baseCurrency: normalized),
        );
        baseCurrencyNotifier.value = normalized;
        return;
      }

      current.baseCurrency = normalized;
      await _isar.userSettings.put(current);
      baseCurrencyNotifier.value = normalized;
    });
  }

  /// Changes the base currency and recalculates all payment snapshots
  /// using historical exchange rates for accuracy.
  ///
  /// For each [PaymentTransaction], fetches the rate for the exact date
  /// the payment was made, then updates [snapshotBaseAmount] and
  /// [snapshotBaseCurrency]. This ensures 100% accurate conversions
  /// even for historical payments.
  ///
  /// Returns the number of transactions that were recalculated.
  Future<int> changeBaseCurrency(String newCurrency) async {
    final String normalized = newCurrency.trim().toUpperCase();
    final ExchangeRateService rateService = ExchangeRateService.instance;

    // 1. Fetch and cache current rates for the new base currency.
    await rateService.fetchAndCacheRates(normalized);

    // 2. Load all non-deleted payment transactions.
    final List<PaymentTransaction> transactions = await _isar
        .paymentTransactions
        .filter()
        .isDeletedEqualTo(false)
        .findAll();

    // 3. Recalculate each transaction's snapshot using historical rates.
    int recalculated = 0;
    for (final PaymentTransaction tx in transactions) {
      final double? historicalRate = await rateService.fetchHistoricalRate(
        date: tx.paidAt,
        fromCurrency: tx.paidCurrency,
        toCurrency: normalized,
      );

      if (historicalRate != null) {
        tx.snapshotBaseAmount = tx.paidAmount * historicalRate;
        tx.snapshotBaseCurrency = normalized;
        tx.updatedAt = DateTime.now();
        recalculated++;
      }
    }

    // 4. Write all updates in a single transaction.
    await _isar.writeTxn(() async {
      await _isar.paymentTransactions.putAll(transactions);

      final UserSettings? current = await _isar.userSettings.get(1);
      if (current != null) {
        current.baseCurrency = normalized;
        await _isar.userSettings.put(current);
      }
    });

    // 5. Update reactive notifier so UI rebuilds instantly.
    baseCurrencyNotifier.value = normalized;

    return recalculated;
  }



  Future<void> setNotificationsEnabled(bool enabled) async {
    await _isar.writeTxn(() async {
      final UserSettings? current = await _isar.userSettings.get(1);
      if (current != null) {
        current.notificationsEnabled = enabled;
        await _isar.userSettings.put(current);
        notificationsEnabledNotifier.value = enabled;
      }
    });

    if (enabled) {
      // Reschedule notifications for all active subscriptions that have reminders enabled
      final subscriptions = await _isar.subscriptionRecords
          .filter()
          .isDeletedEqualTo(false)
          .enableNotificationsEqualTo(true)
          .findAll();
      for (final SubscriptionRecord sub in subscriptions) {
        await NotificationService.instance.scheduleSubscriptionNotifications(sub);
      }
    } else {
      // Cancel all notifications
      await NotificationService.instance.cancelAllNotifications();
    }
  }

  /// Sets or removes the monthly budget limit.
  /// Pass null to remove the budget.
  Future<void> setBudgetLimit(double? limit) async {
    await _isar.writeTxn(() async {
      final UserSettings? current = await _isar.userSettings.get(1);
      if (current != null) {
        current.monthlyBudgetLimit = limit;
        await _isar.userSettings.put(current);
        budgetLimitNotifier.value = limit;
      }
    });
  }

  /// Sets custom global notification time and reschedules all reminders.
  Future<void> setNotificationTime(int hour, int minute) async {
    await _isar.writeTxn(() async {
      final UserSettings? current = await _isar.userSettings.get(1);
      if (current != null) {
        current.notificationHour = hour;
        current.notificationMinute = minute;
        await _isar.userSettings.put(current);
        notificationHourNotifier.value = hour;
        notificationMinuteNotifier.value = minute;
      }
    });

    // Reschedule all active notifications
    if (notificationsEnabledNotifier.value) {
      final subscriptions = await _isar.subscriptionRecords
          .filter()
          .isDeletedEqualTo(false)
          .enableNotificationsEqualTo(true)
          .findAll();
      for (final SubscriptionRecord sub in subscriptions) {
        await NotificationService.instance.scheduleSubscriptionNotifications(sub);
      }
    }
  }
}