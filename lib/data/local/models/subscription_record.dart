import 'package:isar/isar.dart';

part 'subscription_record.g.dart';

@collection
class SubscriptionRecord {
  SubscriptionRecord({
    this.id = Isar.autoIncrement,
    required this.uid,
    required this.name,
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
