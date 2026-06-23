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
    this.userId,
    this.displayName,
    this.email,
    required this.baseCurrency,
    this.isPro = false,
    this.lastSyncTime,
    this.proExpiryDate,
    this.proPlanType,
    this.proPriceDisplay,
    this.themeMode = AppThemeMode.system,
    this.languageCode,
    this.notificationsEnabled = true,
  });

  Id id;

  String? userId;

  /// User's display name (from auth provider).
  String? displayName;

  /// User's email address (from auth provider).
  String? email;

  @Index(caseSensitive: false)
  String baseCurrency;

  bool isPro;

  DateTime? lastSyncTime;

  /// When the Pro subscription expires / renews.
  DateTime? proExpiryDate;

  /// Plan type: "monthly" or "yearly".
  String? proPlanType;

  /// Formatted price string from the store (e.g. "₺599").
  String? proPriceDisplay;

  @enumerated
  AppThemeMode themeMode;

  /// Selected language code ('en', 'tr', etc.) or null for system default.
  String? languageCode;

  bool notificationsEnabled;
}
