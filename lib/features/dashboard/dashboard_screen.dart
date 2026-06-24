import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/features/dashboard/widgets/dashboard_header_widget.dart';
import 'package:pay_tempo/features/dashboard/widgets/monthly_spending_card_widget.dart';
import 'package:pay_tempo/features/dashboard/widgets/subscription_list_section_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({required this.baseCurrency, super.key});

  final String baseCurrency;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(AppSpacing.sm, AppSpacing.sm, AppSpacing.sm, 130),
          children: [
            DashboardHeaderWidget(baseCurrency: widget.baseCurrency),
            const SizedBox(height: AppSpacing.md),
            MonthlySpendingCardWidget(baseCurrency: widget.baseCurrency),
            const SizedBox(height: AppSpacing.md),
            SubscriptionListSectionWidget(baseCurrency: widget.baseCurrency),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}
