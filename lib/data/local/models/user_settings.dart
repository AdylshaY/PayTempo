import 'package:isar/isar.dart';

part 'user_settings.g.dart';

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
}
