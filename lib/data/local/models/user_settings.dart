import 'package:isar/isar.dart';

part 'user_settings.g.dart';

enum AppThemeMode {
  system,
  light,
  dark,
}

@collection
class UserSettings {
  UserSettings({
    this.id = 1,
    required this.baseCurrency,
    this.themeMode = AppThemeMode.system,
    this.languageCode,
    this.notificationsEnabled = true,
    this.notificationHour = 9,
    this.notificationMinute = 0,
  });

  Id id;

  @Index(caseSensitive: false)
  String baseCurrency;

  @enumerated
  AppThemeMode themeMode;

  /// Selected language code ('en', 'tr', etc.) or null for system default.
  String? languageCode;

  bool notificationsEnabled;

  /// Monthly subscription budget limit in base currency.
  /// Null means no budget has been set.
  double? monthlyBudgetLimit;

  int notificationHour;
  int notificationMinute;
}
