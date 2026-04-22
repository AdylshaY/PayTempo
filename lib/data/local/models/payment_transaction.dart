import 'package:isar/isar.dart';

part 'payment_transaction.g.dart';

@collection
class PaymentTransaction {
  PaymentTransaction({
    this.id = Isar.autoIncrement,
    required this.uid,
    required this.subscriptionUid,
    required this.paidAmount,
    required this.paidCurrency,
    required this.snapshotBaseCurrency,
    required this.snapshotBaseAmount,
    required this.paidAt,
    required this.updatedAt,
    this.userId,
    this.isDeleted = false,
  });

  Id id;

  String uid;

  @Index(caseSensitive: false)
  String subscriptionUid;

  String? userId;

  double paidAmount;

  @Index(caseSensitive: false)
  String paidCurrency;

  @Index(caseSensitive: false)
  String snapshotBaseCurrency;

  double snapshotBaseAmount;

  @Index()
  DateTime paidAt;

  @Index()
  DateTime updatedAt;

  bool isDeleted;
}
