import 'package:flutter/material.dart';
import 'package:pay_tempo/features/analytics/analytics_screen.dart';
import 'package:pay_tempo/features/dashboard/dashboard_screen.dart';
import 'package:pay_tempo/features/onboarding/data/user_settings_service.dart';
import 'package:pay_tempo/features/payments/payments_screen.dart';
import 'package:pay_tempo/features/profile/profile_screen.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class AppShellScreen extends StatefulWidget {
  const AppShellScreen({super.key});

  @override
  State<AppShellScreen> createState() => _AppShellScreenState();
}

class _AppShellScreenState extends State<AppShellScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ValueListenableBuilder<String>(
      valueListenable: UserSettingsService.baseCurrencyNotifier,
      builder: (BuildContext context, String baseCurrency, Widget? _) {
        final List<Widget> pages = <Widget>[
          DashboardScreen(baseCurrency: baseCurrency),
          const PaymentsScreen(),
          const AnalyticsScreen(),
          const ProfileScreen(),
        ];

        return Scaffold(
          body: IndexedStack(index: _currentIndex, children: pages),
          bottomNavigationBar: SafeArea(
            top: false,
            child: SizedBox(
              height: 80,
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (int index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                type: BottomNavigationBarType.fixed,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.dashboard_outlined),
                    activeIcon: const Icon(Icons.dashboard),
                    label: l10n.dashboard,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.receipt_long_outlined),
                    activeIcon: const Icon(Icons.receipt_long),
                    label: l10n.payments,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.bar_chart_outlined),
                    activeIcon: const Icon(Icons.bar_chart),
                    label: l10n.analytics,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.person_outline),
                    activeIcon: const Icon(Icons.person),
                    label: l10n.profile,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
