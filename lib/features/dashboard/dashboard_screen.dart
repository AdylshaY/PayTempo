import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/data/local/services/exchange_rate_service.dart';
import 'package:pay_tempo/features/dashboard/subscription_list_screen.dart';
import 'package:pay_tempo/features/dashboard/widgets/dashboard_header_widget.dart';
import 'package:pay_tempo/features/dashboard/widgets/monthly_spending_card_widget.dart';
import 'package:pay_tempo/features/dashboard/widgets/offline_status_banner.dart';
import 'package:pay_tempo/features/dashboard/widgets/upcoming_payments_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({required this.baseCurrency, super.key});

  final String baseCurrency;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  void _navigateToSubscriptionList() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const SubscriptionListScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () async {
            // Haptic impact for starting refresh
            HapticFeedback.mediumImpact();

            final DateTime startTime = DateTime.now();

            // Perform rates reload
            await ExchangeRateService.instance.fetchAndCacheRates(widget.baseCurrency);

            // Calculate duration to enforce a minimum of 500ms visual spinner delay
            final int elapsedMs = DateTime.now().difference(startTime).inMilliseconds;
            if (elapsedMs < 500) {
              await Future.delayed(Duration(milliseconds: 500 - elapsedMs));
            }

            if (mounted) {
              setState(() {});
            }

            // Haptic impact for completing refresh
            HapticFeedback.lightImpact();
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(AppSpacing.sm, AppSpacing.sm, AppSpacing.sm, 130),
            children: [
              const OfflineStatusBanner(),
              DashboardHeaderWidget(baseCurrency: widget.baseCurrency),
              const SizedBox(height: AppSpacing.md),
              MonthlySpendingCardWidget(baseCurrency: widget.baseCurrency),
              const SizedBox(height: AppSpacing.md),
              UpcomingPaymentsWidget(
                baseCurrency: widget.baseCurrency,
                onSeeAll: _navigateToSubscriptionList,
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }
}
