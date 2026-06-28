import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';
import 'package:pay_tempo/data/local/models/notification_reminder.dart';
import 'package:pay_tempo/data/local/isar_database.dart';
import 'package:pay_tempo/features/onboarding/data/user_settings_service.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';
import 'package:isar/isar.dart';

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

  /// Schedules zoned notifications for a subscription's active reminders.
  Future<void> scheduleSubscriptionNotifications(SubscriptionRecord subscription) async {
    // Ensure initialization is completed
    await initialize();

    final isar = LocalDatabase.instance.isar;

    // Fetch existing reminders in DB
    final List<NotificationReminder> reminders = await isar.notificationReminders
        .filter()
        .subscriptionUidEqualTo(subscription.uid)
        .findAll();

    // Cancel currently scheduled alarms for these reminders
    for (final reminder in reminders) {
      await _flutterLocalNotificationsPlugin.cancel(id: reminder.id);
    }

    // Clean up if the subscription has been soft-deleted
    if (subscription.isDeleted) {
      if (reminders.isNotEmpty) {
        await isar.writeTxn(() async {
          await isar.notificationReminders.deleteAll(reminders.map((r) => r.id).toList());
        });
      }
      return;
    }

    // Return if the subscription is paused
    if (subscription.isPaused) {
      return;
    }

    // Return if notifications are disabled for this subscription
    if (!subscription.enableNotifications) {
      return;
    }

    // Return if global notifications are disabled
    final settings = await UserSettingsService().getSettings();
    final bool globalEnabled = settings?.notificationsEnabled ?? true;
    if (!globalEnabled) {
      return;
    }

    // Seed default reminders if empty
    List<NotificationReminder> activeReminders = List.from(reminders);
    if (activeReminders.isEmpty) {
      final nowTime = DateTime.now().microsecondsSinceEpoch;
      activeReminders = [
        NotificationReminder(
          uid: '${nowTime}_0_${subscription.uid}',
          subscriptionUid: subscription.uid,
          daysBefore: 0,
          updatedAt: DateTime.now(),
        ),
        NotificationReminder(
          uid: '${nowTime}_1_${subscription.uid}',
          subscriptionUid: subscription.uid,
          daysBefore: 1,
          updatedAt: DateTime.now(),
        ),
      ];
      await isar.writeTxn(() async {
        await isar.notificationReminders.putAll(activeReminders);
      });
      // Re-query to get auto-incremented IDs
      activeReminders = await isar.notificationReminders
          .filter()
          .subscriptionUidEqualTo(subscription.uid)
          .findAll();
    }

    // Determine target locale and load localization keys
    final String localeCode = UserSettingsService.appLanguageNotifier.value ?? 'en';
    final Locale locale = Locale(localeCode);
    final AppLocalizations l10n = await AppLocalizations.delegate.load(locale);

    final String formattedPrice = subscription.price.toStringAsFixed(2);
    final tz.TZDateTime nowZoned = tz.TZDateTime.now(tz.local);

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

    final int globalHour = settings?.notificationHour ?? 9;
    final int globalMinute = settings?.notificationMinute ?? 0;

    // Schedule each reminder
    for (final reminder in activeReminders) {
      final DateTime targetDate = subscription.nextPaymentDate.subtract(
        Duration(days: reminder.daysBefore),
      );

      final tz.TZDateTime scheduledTime = tz.TZDateTime(
        tz.local,
        targetDate.year,
        targetDate.month,
        targetDate.day,
        reminder.customHour ?? globalHour,
        reminder.customMinute ?? globalMinute,
      );

      if (scheduledTime.isAfter(nowZoned)) {
        String title;
        String body;

        if (reminder.daysBefore == 0) {
          title = l10n.notificationDueTodayTitle;
          body = l10n.notificationDueTodayBody(
            subscription.name,
            formattedPrice,
            subscription.currency,
          );
        } else if (reminder.daysBefore == 1) {
          title = l10n.notification1DayBeforeTitle;
          body = l10n.notification1DayBeforeBody(
            subscription.name,
            formattedPrice,
            subscription.currency,
          );
        } else {
          title = l10n.notificationDaysBeforeTitle;
          body = l10n.notificationDaysBeforeBody(
            subscription.name,
            reminder.daysBefore.toString(),
            formattedPrice,
            subscription.currency,
          );
        }

        await _flutterLocalNotificationsPlugin.zonedSchedule(
          id: reminder.id,
          title: title,
          body: body,
          scheduledDate: scheduledTime,
          notificationDetails: platformDetails,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        );
      }
    }
  }

  /// Cancels scheduled notifications for a subscription. Optionally deletes reminder records.
  Future<void> cancelSubscriptionNotifications(
    SubscriptionRecord subscription, {
    bool deleteFromDb = false,
  }) async {
    await initialize();

    final isar = LocalDatabase.instance.isar;
    final List<NotificationReminder> reminders = await isar.notificationReminders
        .filter()
        .subscriptionUidEqualTo(subscription.uid)
        .findAll();

    for (final reminder in reminders) {
      await _flutterLocalNotificationsPlugin.cancel(id: reminder.id);
    }

    if (deleteFromDb && reminders.isNotEmpty) {
      await isar.writeTxn(() async {
        await isar.notificationReminders.deleteAll(reminders.map((r) => r.id).toList());
      });
    }
  }

  /// Cancels all scheduled notifications across all subscriptions.
  Future<void> cancelAllNotifications() async {
    await initialize();
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
