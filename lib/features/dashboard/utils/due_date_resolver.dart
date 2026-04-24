import 'package:pay_tempo/data/local/models/subscription_record.dart';

DateTime resolveEffectiveDueDate({
  required SubscriptionRecord subscription,
  required DateTime now,
  required bool isPaidThisMonth,
}) {
  final DateTime normalizedNow = DateTime(now.year, now.month, now.day);
  final DateTime storedNextPaymentDate = DateTime(
    subscription.nextPaymentDate.year,
    subscription.nextPaymentDate.month,
    subscription.nextPaymentDate.day,
  );

  if (isPaidThisMonth || subscription.billingCycle != 'monthly') {
    return storedNextPaymentDate;
  }

  final DateTime nextMonthStart = DateTime(
    normalizedNow.year,
    normalizedNow.month + 1,
    1,
  );
  final bool pointsToNextMonth =
      storedNextPaymentDate.year == nextMonthStart.year &&
      storedNextPaymentDate.month == nextMonthStart.month;

  if (!pointsToNextMonth) {
    return storedNextPaymentDate;
  }

  final int lastDayCurrentMonth =
      DateTime(normalizedNow.year, normalizedNow.month + 1, 0).day;
  final int currentDueDay = subscription.anchorDay <= lastDayCurrentMonth
      ? subscription.anchorDay
      : lastDayCurrentMonth;
  final DateTime currentMonthDueDate = DateTime(
    normalizedNow.year,
    normalizedNow.month,
    currentDueDay,
  );

  if (!currentMonthDueDate.isAfter(normalizedNow)) {
    return currentMonthDueDate;
  }

  return storedNextPaymentDate;
}