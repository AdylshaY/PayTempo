import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';
import 'package:pay_tempo/features/onboarding/data/user_settings_service.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class NotificationService {
  NotificationService._internal();

  static final NotificationService instance = NotificationService._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  /// Initializes the local notifications plugin and configures timezones.
  Future<void> initialize() async {
    if (_initialized) return;

    // Initialize Timezones with robust error fallback
    try {
      tz.initializeTimeZones();
      final timeZoneInfo = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timeZoneInfo.identifier));
    } catch (_) {
      // Fallback to UTC if timezone lookup fails
      tz.setLocalLocation(tz.UTC);
    }

    // Android Configuration
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Apple/iOS Configuration
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        // Handle notification tap if necessary
      },
    );

    _initialized = true;
  }

  /// Request permissions for local notifications dynamically.
  Future<bool> requestPermissions() async {
    if (Platform.isIOS) {
      final bool? result = await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      return result ?? false;
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>();
      final bool? result =
          await androidImplementation?.requestNotificationsPermission();
      return result ?? false;
    }
    return false;
  }

  /// Schedules two zoned notifications for a subscription:
  /// 1. One day before the next payment date at 09:00 AM local time.
  /// 2. On the next payment date at 09:00 AM local time.
  Future<void> scheduleSubscriptionNotifications(SubscriptionRecord subscription) async {
    // Ensure initialization is completed
    await initialize();

    // Clean up if the subscription has been soft-deleted
    if (subscription.isDeleted) {
      await cancelSubscriptionNotifications(subscription);
      return;
    }

    // Cancel if notifications are disabled for this specific subscription
    if (!subscription.enableNotifications) {
      await cancelSubscriptionNotifications(subscription);
      return;
    }

    // Cancel if global notifications are disabled
    final settings = await UserSettingsService().getSettings();
    final bool globalEnabled = settings?.notificationsEnabled ?? true;
    if (!globalEnabled) {
      await cancelSubscriptionNotifications(subscription);
      return;
    }

    // Determine target locale and load localization keys programmatically without context
    final String localeCode = UserSettingsService.appLanguageNotifier.value ?? 'en';
    final Locale locale = Locale(localeCode);
    final AppLocalizations l10n = await AppLocalizations.delegate.load(locale);

    final String formattedPrice = subscription.price.toStringAsFixed(2);

    final String title1DayBefore = l10n.notification1DayBeforeTitle;
    final String body1DayBefore = l10n.notification1DayBeforeBody(
      subscription.name,
      formattedPrice,
      subscription.currency,
    );

    final String titleDueToday = l10n.notificationDueTodayTitle;
    final String bodyDueToday = l10n.notificationDueTodayBody(
      subscription.name,
      formattedPrice,
      subscription.currency,
    );

    // Parse next payment date
    final DateTime nextPayment = subscription.nextPaymentDate;

    // Create target time scheduled for 09:00 AM on due date in user's local timezone
    final tz.TZDateTime scheduledDateToday = tz.TZDateTime(
      tz.local,
      nextPayment.year,
      nextPayment.month,
      nextPayment.day,
      9, // Hour: 09:00 AM
      0, // Minute: 00
    );

    final tz.TZDateTime scheduledDate1DayBefore =
        scheduledDateToday.subtract(const Duration(days: 1));

    // Platform-specific notification channels
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'pay_tempo_reminders',
      'Reminders',
      channelDescription: 'Subscription payment due reminders',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    // Derived notification IDs from Isar auto-increment ID
    final int id1DayBefore = subscription.id * 2;
    final int idDueToday = subscription.id * 2 + 1;

    final tz.TZDateTime nowZoned = tz.TZDateTime.now(tz.local);

    // Schedule 1 day before notification if it is in the future
    if (scheduledDate1DayBefore.isAfter(nowZoned)) {
      await _flutterLocalNotificationsPlugin.zonedSchedule(
        id: id1DayBefore,
        title: title1DayBefore,
        body: body1DayBefore,
        scheduledDate: scheduledDate1DayBefore,
        notificationDetails: platformDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    }

    // Schedule due today notification if it is in the future
    if (scheduledDateToday.isAfter(nowZoned)) {
      await _flutterLocalNotificationsPlugin.zonedSchedule(
        id: idDueToday,
        title: titleDueToday,
        body: bodyDueToday,
        scheduledDate: scheduledDateToday,
        notificationDetails: platformDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    }
  }

  /// Cancels both scheduled notifications for a subscription.
  Future<void> cancelSubscriptionNotifications(SubscriptionRecord subscription) async {
    await initialize();

    final int id1DayBefore = subscription.id * 2;
    final int idDueToday = subscription.id * 2 + 1;

    await _flutterLocalNotificationsPlugin.cancel(id: id1DayBefore);
    await _flutterLocalNotificationsPlugin.cancel(id: idDueToday);
  }

  /// Cancels all scheduled notifications across all subscriptions.
  Future<void> cancelAllNotifications() async {
    await initialize();
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
