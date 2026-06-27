import 'package:isar/isar.dart';

part 'notification_reminder.g.dart';

@collection
class NotificationReminder {
  NotificationReminder({
    this.id = Isar.autoIncrement,
    required this.uid,
    required this.subscriptionUid,
    required this.daysBefore,
    this.customHour,
    this.customMinute,
    required this.updatedAt,
  });

  Id id;

  @Index(unique: true)
  String uid;

  @Index()
  String subscriptionUid;

  int daysBefore;

  int? customHour;
  int? customMinute;

  DateTime updatedAt;
}
