import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/app/utils/date_formatter.dart';
import 'package:pay_tempo/app/widgets/empty_state_widget.dart';
import 'package:pay_tempo/data/local/models/payment_transaction.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';
import 'package:pay_tempo/features/dashboard/sheets/mark_subscription_paid_sheet.dart';
import 'package:pay_tempo/features/dashboard/sheets/subscription_detail_sheet.dart';
import 'package:pay_tempo/features/dashboard/widgets/subscription_list_item_widget.dart';
import 'package:pay_tempo/features/payments/widgets/payment_row.dart';
import 'package:pay_tempo/features/subscriptions/subscription_manage_screen.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class CalendarDayEvent {
  CalendarDayEvent({
    required this.subscription,
    this.transaction,
    required this.date,
  });

  final SubscriptionRecord subscription;
  final PaymentTransaction? transaction;
  final DateTime date;

  bool get isPaid => transaction != null;
}

class PaymentCalendarWidget extends StatefulWidget {
  const PaymentCalendarWidget({
    required this.subscriptions,
    required this.transactions,
    required this.baseCurrency,
    super.key,
  });

  final List<SubscriptionRecord> subscriptions;
  final List<PaymentTransaction> transactions;
  final String baseCurrency;

  @override
  State<PaymentCalendarWidget> createState() => _PaymentCalendarWidgetState();
}

class _PaymentCalendarWidgetState extends State<PaymentCalendarWidget> {
  late DateTime _visibleMonth;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    final DateTime now = DateTime.now();
    _visibleMonth = DateTime(now.year, now.month, 1);
    _selectedDay = DateTime(now.year, now.month, now.day);
  }

  DateTime? _getSubscriptionDueDateInMonth(SubscriptionRecord sub, DateTime date) {
    if (sub.isDeleted) return null;

    final int year = date.year;
    final int month = date.month;

    if (sub.billingCycle == 'monthly') {
      final int lastDay = DateTime(year, month + 1, 0).day;
      final int dueDay = sub.anchorDay <= lastDay ? sub.anchorDay : lastDay;
      return DateTime(year, month, dueDay);
    } else {
      final DateTime nextDate = sub.nextPaymentDate;
      if (nextDate.year == year && nextDate.month == month) {
        return DateTime(year, month, nextDate.day);
      }
    }
    return null;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  List<CalendarDayEvent> _getEventsForDay(DateTime day) {
    final List<CalendarDayEvent> events = <CalendarDayEvent>[];

    // 1. Paid events on this day
    for (final PaymentTransaction tx in widget.transactions) {
      if (_isSameDay(tx.paidAt, day)) {
        final SubscriptionRecord sub = widget.subscriptions.firstWhere(
          (SubscriptionRecord s) => s.uid == tx.subscriptionUid,
          orElse: () => SubscriptionRecord(
            uid: tx.subscriptionUid,
            name: '?',
            category: '',
            price: tx.paidAmount,
            currency: tx.paidCurrency,
            billingCycle: 'monthly',
            anchorDay: tx.paidAt.day,
            nextPaymentDate: tx.paidAt,
            updatedAt: tx.updatedAt,
          ),
        );
        events.add(CalendarDayEvent(
          subscription: sub,
          transaction: tx,
          date: day,
        ));
      }
    }

    // 2. Unpaid dues on this day
    for (final SubscriptionRecord sub in widget.subscriptions) {
      // Check if this subscription is paid in the month of 'day'
      final bool isPaidInMonth = widget.transactions.any((PaymentTransaction tx) {
        return tx.subscriptionUid == sub.uid &&
            tx.paidAt.year == day.year &&
            tx.paidAt.month == day.month;
      });

      if (!isPaidInMonth) {
        final DateTime? dueDate = _getSubscriptionDueDateInMonth(sub, day);
        if (dueDate != null && _isSameDay(dueDate, day)) {
          events.add(CalendarDayEvent(
            subscription: sub,
            date: day,
          ));
        }
      }
    }

    return events;
  }

  Color _getEventColor(CalendarDayEvent event) {
    if (event.isPaid) {
      return AppColors.success;
    }
    final DateTime today = DateTime.now();
    final DateTime normalizedToday = DateTime(today.year, today.month, today.day);
    final DateTime normalizedEventDate = DateTime(event.date.year, event.date.month, event.date.day);
    final int daysDiff = normalizedEventDate.difference(normalizedToday).inDays;

    if (daysDiff < 0) {
      return AppColors.error;
    } else if (daysDiff <= 3) {
      return AppColors.warning;
    } else {
      return AppColors.secondaryHighlight;
    }
  }

  void _previousMonth() {
    HapticFeedback.lightImpact();
    setState(() {
      _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month - 1, 1);
    });
  }

  void _nextMonth() {
    HapticFeedback.lightImpact();
    setState(() {
      _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month + 1, 1);
    });
  }

  void _jumpToToday() {
    HapticFeedback.mediumImpact();
    final DateTime now = DateTime.now();
    setState(() {
      _visibleMonth = DateTime(now.year, now.month, 1);
      _selectedDay = DateTime(now.year, now.month, now.day);
    });
  }

  Future<void> _openPaidSheet(
    BuildContext context,
    SubscriptionRecord subscription,
  ) async {
    await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext context) {
        return MarkSubscriptionPaidSheet(
          subscription: subscription,
          baseCurrency: widget.baseCurrency,
        );
      },
    );
  }

  Future<void> _openDetailSheet(
    BuildContext context,
    SubscriptionRecord subscription, {
    required bool isPaidThisMonth,
  }) async {
    final bool? shouldManage = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext sheetContext) {
        return SubscriptionDetailSheet(
          subscription: subscription,
          baseCurrency: widget.baseCurrency,
          isPaidThisMonth: isPaidThisMonth,
          onMarkPaid: () => _openPaidSheet(context, subscription),
        );
      },
    );

    if (shouldManage == true && context.mounted) {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => SubscriptionManageScreen(
            subscription: subscription,
            baseCurrency: widget.baseCurrency,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final String locale = l10n.localeName;

    // Calendar generation variables
    final DateTime firstDayOfMonth = _visibleMonth;
    final int prefixDays = firstDayOfMonth.weekday - 1; // Monday as first day (1..7)
    final DateTime gridStartDate = firstDayOfMonth.subtract(Duration(days: prefixDays));

    final DateTime today = DateTime.now();
    final DateTime normalizedToday = DateTime(today.year, today.month, today.day);

    final List<CalendarDayEvent> selectedDayEvents = _getEventsForDay(_selectedDay);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Month selector & "Today" button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: _previousMonth,
              icon: const Icon(Icons.chevron_left_rounded),
            ),
            Expanded(
              child: Center(
                child: Text(
                  DateFormat.yMMMM(locale).format(_visibleMonth),
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (!_isSameDay(_visibleMonth, DateTime(today.year, today.month, 1)))
              TextButton.icon(
                onPressed: _jumpToToday,
                icon: const Icon(Icons.today_rounded, size: 16),
                label: Text(
                  l10n.themeSystem, // fallback or generic today label
                  style: const TextStyle(fontSize: 12),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                  minimumSize: const Size(60, 32),
                ),
              ),
            IconButton(
              onPressed: _nextMonth,
              icon: const Icon(Icons.chevron_right_rounded),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),

        // 2. Weekday headers
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (int index) {
              final DateTime tempDate = gridStartDate.add(Duration(days: index));
              final String weekdayName = DateFormat.E(locale).format(tempDate);
              return Expanded(
                child: Center(
                  child: Text(
                    weekdayName,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 8),

        // 3. Grid of days
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xs),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 42, // 6 rows * 7 columns fixed
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                childAspectRatio: 1.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                final DateTime cellDate = gridStartDate.add(Duration(days: index));
                final bool isCurrentMonth = cellDate.month == _visibleMonth.month;
                final bool isSelected = _isSameDay(cellDate, _selectedDay);
                final bool isToday = _isSameDay(cellDate, normalizedToday);

                final List<CalendarDayEvent> dayEvents = _getEventsForDay(cellDate);

                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      setState(() {
                        _selectedDay = cellDate;
                        // If user tapped a day of another month shown in the grid, change month
                        if (cellDate.month != _visibleMonth.month) {
                          _visibleMonth = DateTime(cellDate.year, cellDate.month, 1);
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(AppRadii.button),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? colorScheme.primary
                            : isToday
                                ? colorScheme.primary.withValues(alpha: 0.08)
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(AppRadii.button),
                        border: isToday && !isSelected
                            ? Border.all(color: colorScheme.primary, width: 1.0)
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            cellDate.day.toString(),
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: isSelected || isToday
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isSelected
                                  ? Colors.white
                                  : isCurrentMonth
                                      ? null
                                      : colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                            ),
                          ),
                          const SizedBox(height: 2),
                          // Dots under day
                          if (dayEvents.isNotEmpty)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: dayEvents.take(3).map((CalendarDayEvent ev) {
                                return Container(
                                  width: 4,
                                  height: 4,
                                  margin: const EdgeInsets.symmetric(horizontal: 0.5),
                                  decoration: BoxDecoration(
                                    color: isSelected ? Colors.white : _getEventColor(ev),
                                    shape: BoxShape.circle,
                                  ),
                                );
                              }).toList(),
                            )
                          else
                            const SizedBox(height: 4),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // 4. Day Details Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedDay.toFullDateLabel(locale),
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              l10n.totalItems(selectedDayEvents.length),
              style: textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),

        // 5. Day Details List
        if (selectedDayEvents.isEmpty)
          Card(
            child: EmptyStateWidget(
              icon: Icons.calendar_today_rounded,
              title: l10n.payments,
              message: l10n.noPaymentsOnDay,
            ),
          )
        else
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: selectedDayEvents.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.xs),
            itemBuilder: (BuildContext context, int index) {
              final CalendarDayEvent event = selectedDayEvents[index];

              if (event.isPaid) {
                // Return transaction row
                final PaymentTransaction tx = event.transaction!;
                return PaymentRow(
                  paidAmount: tx.paidAmount,
                  paidCurrency: tx.paidCurrency,
                  snapshotBaseAmount: tx.snapshotBaseAmount,
                  snapshotBaseCurrency: tx.snapshotBaseCurrency,
                  paidAt: tx.paidAt,
                  subscription: event.subscription,
                );
              } else {
                // Return due subscription row with swipe-to-pay confirmed actions
                final SubscriptionRecord sub = event.subscription;

                return Dismissible(
                  key: ValueKey<String>('cal-due-${sub.uid}'),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (_) async {
                    await _openPaidSheet(context, sub);
                    return false;
                  },
                  background: const SizedBox.shrink(),
                  secondaryBackground: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(AppRadii.card),
                    ),
                    child: const Icon(
                      Icons.check_circle_outline,
                      color: AppColors.success,
                    ),
                  ),
                  child: SubscriptionListItemWidget(
                    item: sub,
                    dueDateOverride: event.date,
                    onTap: () => _openDetailSheet(
                      context,
                      sub,
                      isPaidThisMonth: false,
                    ),
                  ),
                );
              }
            },
          ),
      ],
    );
  }
}
