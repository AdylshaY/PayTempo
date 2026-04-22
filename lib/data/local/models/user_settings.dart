import 'package:isar/isar.dart';

part 'user_settings.g.dart';

@collection
class UserSettings {
  UserSettings({
    this.id = 1,
    this.userId,
    required this.baseCurrency,
    this.isPro = false,
    this.lastSyncTime,
  });

  Id id;

  String? userId;

  @Index(caseSensitive: false)
  String baseCurrency;

  bool isPro;

  DateTime? lastSyncTime;
}
