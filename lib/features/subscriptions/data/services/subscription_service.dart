import 'dart:math';

import 'package:isar/isar.dart';
import 'package:pay_tempo/data/local/isar_database.dart';
import 'package:pay_tempo/data/local/models/payment_transaction.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';
import 'package:pay_tempo/features/subscriptions/data/models/subscription_draft.dart';

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

  Future<void> markSubscriptionAsPaid({
    required SubscriptionRecord subscription,
    required DateTime paidAt,
    required String baseCurrency,
  }) async {
    final DateTime normalizedPaidAt = DateTime(
      paidAt.year,
      paidAt.month,
      paidAt.day,
    );
    final DateTime now = DateTime.now();
    final DateTime nextPaymentDate = _nextPaymentDateAfter(
      paidAt: normalizedPaidAt,
      anchorDay: subscription.anchorDay,
      billingCycle: subscription.billingCycle,
    );
    final PaymentTransaction transaction = PaymentTransaction(
      uid: _generateUid(now),
      subscriptionUid: subscription.uid,
      userId: subscription.userId,
      paidAmount: subscription.price,
      paidCurrency: subscription.currency,
      snapshotBaseCurrency: baseCurrency.trim().toUpperCase(),
      snapshotBaseAmount: subscription.price,
      paidAt: normalizedPaidAt,
      updatedAt: now,
      isDeleted: false,
    );

    await _isar.writeTxn(() async {
      final DateTime monthStart = DateTime(normalizedPaidAt.year, normalizedPaidAt.month);
      final DateTime nextMonthStart = DateTime(
        normalizedPaidAt.year,
        normalizedPaidAt.month + 1,
      );
      final bool alreadyPaidThisMonth = await _isar.paymentTransactions
          .filter()
          .isDeletedEqualTo(false)
          .subscriptionUidEqualTo(subscription.uid)
          .paidAtBetween(
            monthStart,
            nextMonthStart,
            includeLower: true,
            includeUpper: false,
          )
          .findFirst() !=
          null;

      if (alreadyPaidThisMonth) {
        throw StateError('This subscription is already marked paid for this month.');
      }

      await _isar.paymentTransactions.put(transaction);

      subscription.nextPaymentDate = nextPaymentDate;
      subscription.updatedAt = now;
      await _isar.subscriptionRecords.put(subscription);
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
    final DateTime today = DateTime(now.year, now.month, now.day);
    DateTime candidate = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
    );

    while (candidate.isBefore(today)) {
      candidate = _advanceWithAnchor(
        date: candidate,
        anchorDay: anchorDay,
        billingCycle: billingCycle,
      );
    }

    return candidate;
  }

  DateTime _nextPaymentDateAfter({
    required DateTime paidAt,
    required int anchorDay,
    required String billingCycle,
  }) {
    DateTime candidate = DateTime(paidAt.year, paidAt.month, paidAt.day);

    while (!candidate.isAfter(paidAt)) {
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