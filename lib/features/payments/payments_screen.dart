import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/data/local/isar_database.dart';
import 'package:pay_tempo/data/local/models/payment_transaction.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';
import 'package:pay_tempo/features/payments/sheets/payments_filter_sheet.dart';
import 'package:pay_tempo/features/payments/widgets/payment_row.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  String _searchQuery = '';
  DateTime? _fromDate;
  DateTime? _toDate;

  String _monthLabel(DateTime date) {
    const List<String> months = <String>[
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${months[date.month - 1]} ${date.year}';
  }

  String _dateLabel(DateTime date) {
    const List<String> months = <String>[
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  DateTime _monthStart(DateTime date) => DateTime(date.year, date.month);

  DateTime _subtractMonths(DateTime date, int months) {
    final int targetMonthIndex = date.year * 12 + (date.month - 1) - months;
    final int year = targetMonthIndex ~/ 12;
    final int month = (targetMonthIndex % 12) + 1;
    return DateTime(year, month);
  }

  DateTime _rangeStart() {
    final DateTime now = DateTime.now();
    final DateTime currentMonth = _monthStart(now);
    return _fromDate == null
        ? _subtractMonths(currentMonth, 2)
        : _monthStart(_fromDate!);
  }

  DateTime _rangeEnd() {
    final DateTime now = DateTime.now();
    return _toDate == null ? _monthStart(now) : _monthStart(_toDate!);
  }

  List<DateTime> _visiblePeriods() {
    final DateTime start = _rangeStart();
    final DateTime end = _rangeEnd();
    final List<DateTime> periods = <DateTime>[];

    DateTime cursor = start;
    while (!cursor.isAfter(end)) {
      periods.add(cursor);
      cursor = DateTime(cursor.year, cursor.month + 1);
    }

    return periods;
  }

  bool _isWithinDateRange(DateTime paidAt) {
    final DateTime normalizedPaidAt = _monthStart(paidAt);
    final DateTime? fromDate = _fromDate == null
        ? null
        : _monthStart(_fromDate!);
    final DateTime? toDate = _toDate == null ? null : _monthStart(_toDate!);

    if (fromDate != null && normalizedPaidAt.isBefore(fromDate)) {
      return false;
    }

    if (toDate != null && normalizedPaidAt.isAfter(toDate)) {
      return false;
    }

    return true;
  }

  Future<void> _openFilterSheet() async {
    final DateTime now = DateTime.now();
    final DateTime initialFrom =
        _fromDate ?? _subtractMonths(_monthStart(now), 2);
    final DateTime initialTo = _toDate ?? _monthStart(now);

    final ({DateTime? fromDate, DateTime? toDate})? result =
        await showModalBottomSheet<({DateTime? fromDate, DateTime? toDate})>(
          context: context,
          showDragHandle: true,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return PaymentsFilterSheet(
              initialFromDate: initialFrom,
              initialToDate: initialTo,
            );
          },
        );

    if (result == null || !mounted) {
      return;
    }

    setState(() {
      _fromDate = result.fromDate;
      _toDate = result.toDate;
    });
  }

  Future<void> _clearFilters() async {
    setState(() {
      _searchQuery = '';
      _fromDate = null;
      _toDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Isar isar = LocalDatabase.instance.isar;

    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<List<SubscriptionRecord>>(
          stream: isar.subscriptionRecords
              .filter()
              .isDeletedEqualTo(false)
              .watch(fireImmediately: true),
          builder:
              (
                BuildContext context,
                AsyncSnapshot<List<SubscriptionRecord>> subscriptionsSnapshot,
              ) {
                return StreamBuilder<List<PaymentTransaction>>(
                  stream: isar.paymentTransactions
                      .filter()
                      .isDeletedEqualTo(false)
                      .watch(fireImmediately: true),
                  builder:
                      (
                        BuildContext context,
                        AsyncSnapshot<List<PaymentTransaction>>
                        paymentsSnapshot,
                      ) {
                        if (subscriptionsSnapshot.hasError ||
                            paymentsSnapshot.hasError) {
                          return Center(
                            child: Text(
                              'Payments failed to load.',
                              style: textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          );
                        }

                        final Map<String, SubscriptionRecord>
                        subscriptionByUid = <String, SubscriptionRecord>{
                          for (final SubscriptionRecord subscription
                              in subscriptionsSnapshot.data ??
                                  const <SubscriptionRecord>[])
                            subscription.uid: subscription,
                        };

                        final List<PaymentTransaction> payments =
                            List<PaymentTransaction>.from(
                              paymentsSnapshot.data ??
                                  const <PaymentTransaction>[],
                            )..sort((
                              PaymentTransaction left,
                              PaymentTransaction right,
                            ) {
                              return right.paidAt.compareTo(left.paidAt);
                            });

                        final List<DateTime> visiblePeriods = _visiblePeriods();
                        final Map<DateTime, List<PaymentTransaction>>
                        groupedPayments =
                            <DateTime, List<PaymentTransaction>>{};

                        for (final DateTime period in visiblePeriods) {
                          groupedPayments[period] = <PaymentTransaction>[];
                        }

                        final String searchQuery = _searchQuery
                            .trim()
                            .toLowerCase();

                        for (final PaymentTransaction payment in payments) {
                          final DateTime month = _monthStart(payment.paidAt);
                          final String subscriptionName =
                              subscriptionByUid[payment.subscriptionUid]
                                  ?.name ??
                              '';
                          final bool matchesSearch =
                              searchQuery.isEmpty ||
                              subscriptionName.toLowerCase().contains(
                                searchQuery,
                              );
                          final bool isVisible =
                              groupedPayments.containsKey(month) &&
                              _isWithinDateRange(payment.paidAt) &&
                              matchesSearch;

                          if (isVisible) {
                            groupedPayments[month]!.add(payment);
                          }
                        }

                        final List<DateTime> nonEmptyPeriods = visiblePeriods
                            .where(
                              (DateTime period) =>
                                  (groupedPayments[period] ??
                                          const <PaymentTransaction>[])
                                      .isNotEmpty,
                            )
                            .toList(growable: false);

                        final bool hasActiveFilters =
                            searchQuery.isNotEmpty ||
                            _fromDate != null ||
                            _toDate != null;

                        final List<DateTime> periodsToRender = nonEmptyPeriods;

                        final List<Widget> sections = <Widget>[];
                        for (final DateTime period in periodsToRender) {
                          final List<PaymentTransaction> items =
                              groupedPayments[period] ??
                              const <PaymentTransaction>[];

                          sections.add(
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(AppSpacing.md),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          _monthLabel(period),
                                          style: textTheme.titleMedium,
                                        ),
                                        Text(
                                          '${items.length} payments',
                                          style: textTheme.bodySmall?.copyWith(
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: AppSpacing.sm),
                                    if (items.isEmpty)
                                      Text(
                                        'No payments recorded for this month.',
                                        style: textTheme.bodyMedium?.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                      )
                                    else
                                      ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: items.length,
                                        separatorBuilder: (_, index) =>
                                            const SizedBox(
                                              height: AppSpacing.xs,
                                            ),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                              final PaymentTransaction item =
                                                  items[index];
                                              final SubscriptionRecord?
                                              subscription =
                                                  subscriptionByUid[item
                                                      .subscriptionUid];

                                              return PaymentRow(
                                                subscriptionName:
                                                    subscription?.name ??
                                                    'Unknown subscription',
                                                paidAmount: item.paidAmount,
                                                paidCurrency: item.paidCurrency,
                                                snapshotBaseAmount:
                                                    item.snapshotBaseAmount,
                                                snapshotBaseCurrency:
                                                    item.snapshotBaseCurrency,
                                                paidAt: item.paidAt,
                                              );
                                            },
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }

                        final Widget topContent = Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    onChanged: (String value) {
                                      setState(() {
                                        _searchQuery = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Search by subscription name',
                                      prefixIcon: const Icon(Icons.search),
                                      suffixIcon: _searchQuery.isEmpty
                                          ? null
                                          : IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  _searchQuery = '';
                                                });
                                              },
                                              icon: const Icon(Icons.clear),
                                            ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.xs),
                                IconButton.filledTonal(
                                  onPressed: _openFilterSheet,
                                  icon: const Icon(Icons.tune),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _fromDate == null && _toDate == null
                                        ? 'Showing last 3 months'
                                        : 'Showing filtered date range',
                                    style: textTheme.bodySmall?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                                if (_fromDate != null || _toDate != null)
                                  TextButton(
                                    onPressed: _clearFilters,
                                    child: const Text('Clear filters'),
                                  ),
                              ],
                            ),
                            if (_fromDate != null || _toDate != null)
                              Text(
                                '${_fromDate == null ? 'Any time' : _dateLabel(_fromDate!)} - ${_toDate == null ? 'Any time' : _dateLabel(_toDate!)}',
                                style: textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            const SizedBox(height: AppSpacing.md),
                          ],
                        );

                        if (sections.isEmpty) {
                          return ListView(
                            padding: const EdgeInsets.all(AppSpacing.sm),
                            children: <Widget>[
                              topContent,
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(AppSpacing.md),
                                  child: Text(
                                    hasActiveFilters
                                        ? 'No payments match the current filters.'
                                        : 'No payments recorded yet.',
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }

                        return ListView(
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          children: <Widget>[topContent, ...sections],
                        );
                      },
                );
              },
        ),
      ),
    );
  }
}
