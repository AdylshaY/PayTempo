import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/app/widgets/icon_circle_widget.dart';
import 'package:pay_tempo/features/onboarding/data/onboarding_currencies.dart';
import 'package:pay_tempo/features/onboarding/data/user_settings_service.dart';
import 'package:pay_tempo/features/onboarding/widgets/currency_dropdown.dart';
import 'package:pay_tempo/features/onboarding/widgets/warning_banner.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({required this.onCompleted, super.key});

  final VoidCallback onCompleted;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final UserSettingsService _settingsService = UserSettingsService();
  final ValueNotifier<String?> _selectedCurrency = ValueNotifier<String?>(
    onboardingCurrencies.first.code,
  );
  final ValueNotifier<bool> _saving = ValueNotifier<bool>(false);
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _selectedCurrency.dispose();
    _saving.dispose();
    super.dispose();
  }

  Future<void> _saveAndContinue() async {
    final String? currency = _selectedCurrency.value;
    if (currency == null) return;

    _saving.value = true;

    try {
      await _settingsService.saveBaseCurrency(currency);
      if (!mounted) return;
      widget.onCompleted();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.failedToSaveBaseCurrency),
        ),
      );
      _saving.value = false;
    }
  }

  Widget _buildIndicators(int count, int activeIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final bool isActive = index == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: isActive ? 24 : 8,
          decoration: BoxDecoration(
            color: isActive
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  Widget _buildPage({
    required String title,
    required String subtitle,
    required String lottieAsset,
    required IconData fallbackIcon,
    Widget? extraChild,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 240,
                  height: 240,
                  child: Lottie.asset(
                    lottieAsset,
                    repeat: true,
                    animate: true,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return IconCircleWidget(icon: fallbackIcon, size: 180);
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                  child: Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.4,
                    ),
                  ),
                ),
                if (extraChild != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  extraChild,
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: [
                      _buildPage(
                        title: l10n.onboardingPage1Title,
                        subtitle: l10n.onboardingPage1Subtitle,
                        lottieAsset: 'assets/lottie/onboarding_lottie.json',
                        fallbackIcon: Icons.security_outlined,
                      ),
                      _buildPage(
                        title: l10n.onboardingPage2Title,
                        subtitle: l10n.onboardingPage2Subtitle,
                        lottieAsset: 'assets/lottie/onboarding_currency.json',
                        fallbackIcon: Icons.currency_exchange_rounded,
                      ),
                      _buildPage(
                        title: l10n.onboardingPage3Title,
                        subtitle: l10n.onboardingPage3Subtitle,
                        lottieAsset: 'assets/lottie/onboarding_alerts.json',
                        fallbackIcon: Icons.notifications_active_outlined,
                      ),
                      _buildPage(
                        title: l10n.baseCurrencyTitle,
                        subtitle: l10n.selectBaseCurrencyDesc,
                        lottieAsset: 'assets/lottie/onboarding_currency_select.json',
                        fallbackIcon: Icons.account_balance_wallet_outlined,
                        extraChild: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: AppSpacing.sm),
                            CurrencyDropdown(
                              selectedCurrency: _selectedCurrency,
                              saving: _saving,
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            const WarningBanner(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Persistent Bottom Area
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildIndicators(4, _currentPage),
                      const SizedBox(height: AppSpacing.sm),
                      ListenableBuilder(
                        listenable: Listenable.merge([_selectedCurrency, _saving]),
                        builder: (context, _) {
                          final bool isLastPage = _currentPage == 3;
                          final bool isButtonDisabled = _saving.value || (isLastPage && _selectedCurrency.value == null);
                          
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isButtonDisabled
                                  ? null
                                  : () {
                                      if (isLastPage) {
                                        _saveAndContinue();
                                      } else {
                                        _pageController.nextPage(
                                          duration: const Duration(milliseconds: 300),
                                          curve: Curves.easeInOutCubic,
                                        );
                                      }
                                    },
                              child: _saving.value
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    )
                                  : Text(
                                      isLastPage
                                          ? l10n.getStartedButtonLabel
                                          : l10n.continueButtonLabel,
                                    ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (_currentPage < 3)
              Positioned(
                top: AppSpacing.sm,
                right: AppSpacing.md,
                child: TextButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    _pageController.animateToPage(
                      3,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOutCubic,
                    );
                  },
                  child: Text(l10n.skipButtonLabel),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


