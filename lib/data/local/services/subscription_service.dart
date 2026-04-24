import 'dart:math';

import 'package:isar/isar.dart';
import 'package:pay_tempo/data/local/isar_database.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';

class SubscriptionDraft {
  SubscriptionDraft({
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
    required this.firstPaymentDate,
    this.userId,
  });

  final String name;
  final String category;
  final String? avatarType;
  final String? avatarEmoji;
  final int? avatarIconCodePoint;
  final String? avatarIconFontFamily;
  final String? avatarIconFontPackage;
  final int? avatarColorValue;
  final double price;
  final String currency;
  final String billingCycle;
  final DateTime firstPaymentDate;
  final String? userId;
}

class SubscriptionService {
  SubscriptionService({Isar? isar})
    : _isar = isar ?? LocalDatabase.instance.isar;

  final Isar _isar;
  final Random _random = Random();

  Future<void> createSubscription(SubscriptionDraft draft) async {
    final DateTime now = DateTime.now();
    final int anchorDay = draft.firstPaymentDate.day;
    final DateTime nextPaymentDate = _nextPaymentDate(
      startDate: draft.firstPaymentDate,
      anchorDay: anchorDay,
      billingCycle: draft.billingCycle,
      now: now,
    );

    final SubscriptionRecord record = SubscriptionRecord(
      uid: _generateUid(now),
      userId: draft.userId,
      name: draft.name.trim(),
      category: draft.category.trim(),
      avatarType: draft.avatarType?.trim(),
      avatarEmoji: draft.avatarEmoji?.trim(),
      avatarIconCodePoint: draft.avatarIconCodePoint,
      avatarIconFontFamily: draft.avatarIconFontFamily?.trim(),
      avatarIconFontPackage: draft.avatarIconFontPackage?.trim(),
      avatarColorValue: draft.avatarColorValue,
      price: draft.price,
      currency: draft.currency.trim().toUpperCase(),
      billingCycle: draft.billingCycle,
      anchorDay: anchorDay,
      nextPaymentDate: nextPaymentDate,
      updatedAt: now,
      isDeleted: false,
    );

    await _isar.writeTxn(() async {
      await _isar.subscriptionRecords.put(record);
    });
  }

  Future<List<SubscriptionRecord>> getActiveSubscriptions() {
    return _isar.subscriptionRecords.filter().isDeletedEqualTo(false).findAll();
  }

  Stream<List<SubscriptionRecord>> watchActiveSubscriptions() {
    return _isar.subscriptionRecords
        .filter()
        .isDeletedEqualTo(false)
        .watch(fireImmediately: true);
  }

  DateTime _nextPaymentDate({
    required DateTime startDate,
    required int anchorDay,
    required String billingCycle,
    required DateTime now,
  }) {
    DateTime candidate = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
    );

    while (!candidate.isAfter(now)) {
      candidate = _advanceWithAnchor(
        date: candidate,
        anchorDay: anchorDay,
        billingCycle: billingCycle,
      );
    }

    return candidate;
  }

  DateTime _advanceWithAnchor({
    required DateTime date,
    required int anchorDay,
    required String billingCycle,
  }) {
    final bool isYearly = billingCycle == 'yearly';
    final int targetYear = isYearly
        ? date.year + 1
        : (date.month == 12 ? date.year + 1 : date.year);
    final int targetMonth = isYearly
        ? date.month
        : (date.month == 12 ? 1 : date.month + 1);

    final int lastDay = DateTime(targetYear, targetMonth + 1, 0).day;
    final int day = anchorDay <= lastDay ? anchorDay : lastDay;
    return DateTime(targetYear, targetMonth, day);
  }

  String _generateUid(DateTime now) {
    final int randomPart = _random.nextInt(900000) + 100000;
    return 'sub_${now.microsecondsSinceEpoch}_$randomPart';
  }
}
