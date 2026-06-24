import 'package:flutter/material.dart';
import 'package:pay_tempo/features/analytics/analytics_screen.dart';
import 'package:pay_tempo/features/dashboard/dashboard_screen.dart';
import 'package:pay_tempo/features/onboarding/data/user_settings_service.dart';
import 'package:pay_tempo/features/payments/payments_screen.dart';
import 'package:pay_tempo/features/profile/profile_screen.dart';
import 'package:pay_tempo/features/subscriptions/subscription_template_picker_screen.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class AppShellScreen extends StatefulWidget {
  const AppShellScreen({super.key});

  @override
  State<AppShellScreen> createState() => _AppShellScreenState();
}

class _AppShellScreenState extends State<AppShellScreen> {
  int _currentIndex = 0;

  Future<void> _openAddSubscription() async {
    await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => const SubscriptionTemplatePickerScreen(),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    IconData inactiveIcon,
    IconData activeIcon,
    String label,
  ) {
    final bool isSelected = _currentIndex == index;
    final ThemeData theme = Theme.of(context);
    final Color activeColor = theme.colorScheme.primary;
    final Color inactiveColor = theme.colorScheme.onSurfaceVariant;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _currentIndex = index;
          });
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedScale(
              scale: isSelected ? 1.15 : 1.0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              child: Icon(
                isSelected ? activeIcon : inactiveIcon,
                color: isSelected ? activeColor : inactiveColor,
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isSelected ? activeColor : inactiveColor,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

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
          extendBody: true,
          body: IndexedStack(index: _currentIndex, children: pages),
          bottomNavigationBar: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
              child: SizedBox(
                height: 86,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      height: 68,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.92),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildNavItem(
                              0,
                              Icons.dashboard_outlined,
                              Icons.dashboard,
                              l10n.dashboard,
                            ),
                            _buildNavItem(
                              1,
                              Icons.receipt_long_outlined,
                              Icons.receipt_long,
                              l10n.payments,
                            ),
                            const Expanded(child: SizedBox.shrink()),
                            _buildNavItem(
                              2,
                              Icons.bar_chart_outlined,
                              Icons.bar_chart,
                              l10n.analytics,
                            ),
                            _buildNavItem(
                              3,
                              Icons.person_outline,
                              Icons.person,
                              l10n.profile,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: GestureDetector(
                          onTap: _openAddSubscription,
                          child: Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.primary,
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.add_rounded,
                              color: Theme.of(context).colorScheme.onPrimary,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
