import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/features/subscriptions/sheets/subscription_template_picker_sheet.dart';
import 'package:pay_tempo/features/dashboard/widgets/monthly_spending_card_widget.dart';
import 'package:pay_tempo/features/dashboard/widgets/subscription_list_section_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({required this.baseCurrency, super.key});

  final String baseCurrency;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<void> _openAddSubscription() async {
    final bool? created = await showSubscriptionTemplateBottomSheet(context);

    if (created != true || !mounted) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PayTempo')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        children: [
          const SizedBox(height: AppSpacing.sm),
          MonthlySpendingCardWidget(baseCurrency: widget.baseCurrency),
          const SizedBox(height: AppSpacing.md),
          SubscriptionListSectionWidget(baseCurrency: widget.baseCurrency),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddSubscription,
        child: const Icon(Icons.add),
      ),
    );
  }
}
