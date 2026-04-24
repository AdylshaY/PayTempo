import 'package:isar/isar.dart';

part 'subscription_record.g.dart';

@collection
class SubscriptionRecord {
  SubscriptionRecord({
    this.id = Isar.autoIncrement,
    required this.uid,
    required this.name,
    required this.category,
    this.avatarType,
    this.avatarEmoji,
    this.avatarIconCodePoint,
    this.avatarIconFontFamily,
    this.avatarIconFontPackage,
    this.avatarColorValue,
    required this.price,
    required this.currency,
    required this.billingCycle,
    required this.anchorDay,
    required this.nextPaymentDate,
    required this.updatedAt,
    this.userId,
    this.isDeleted = false,
  });

  Id id;

  String uid;

  String? userId;

  String name;

  @Index(caseSensitive: false)
  String category;

  @Index(caseSensitive: false)
  String? avatarType;

  String? avatarEmoji;

  int? avatarIconCodePoint;

  String? avatarIconFontFamily;

  String? avatarIconFontPackage;

  int? avatarColorValue;

  double price;

  @Index(caseSensitive: false)
  String currency;

  @Index(caseSensitive: false)
  String billingCycle;

  int anchorDay;

  @Index()
  DateTime nextPaymentDate;

  @Index()
  DateTime updatedAt;

  bool isDeleted;
}
