import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/app/utils/date_formatter.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';
import 'package:pay_tempo/data/local/services/exchange_rate_service.dart';
import 'package:pay_tempo/features/subscriptions/data/subscription_categories.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class SubscriptionShareCard extends StatelessWidget {
  const SubscriptionShareCard({
    required this.subscription,
    required this.baseCurrency,
    super.key,
  });

  final SubscriptionRecord subscription;
  final String baseCurrency;

  Widget _buildAvatar() {
    final Color backgroundColor = subscription.avatarColorValue != null
        ? Color(subscription.avatarColorValue!)
        : AppColors.primary;

    if (subscription.avatarType == 'emoji' &&
        subscription.avatarEmoji != null &&
        subscription.avatarEmoji!.isNotEmpty) {
      return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
        alignment: Alignment.center,
        child: Text(
          subscription.avatarEmoji!,
          style: const TextStyle(fontSize: 30),
        ),
      );
    }

    if (subscription.avatarIconCodePoint != null) {
      return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Icon(
          IconData(
            subscription.avatarIconCodePoint!,
            fontFamily: subscription.avatarIconFontFamily,
            fontPackage: subscription.avatarIconFontPackage,
          ),
          color: Colors.white,
          size: 30,
        ),
      );
    }

    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: const Icon(
        Icons.subscriptions,
        color: Colors.white,
        size: 30,
      ),
    );
  }

  String _billingCycleLabel(String cycle, AppLocalizations l10n) {
    switch (cycle.toLowerCase()) {
      case 'monthly':
        return l10n.monthlyLabel;
      case 'yearly':
        return l10n.yearlyLabel;
      case 'weekly':
        return l10n.weeklyLabel;
      case 'quarterly':
        return l10n.quarterlyLabel;
      default:
        return cycle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bool showConversion =
        subscription.currency.toUpperCase() != baseCurrency.toUpperCase();
    final double convertedAmount = ExchangeRateService.instance.convert(
      subscription.price,
      subscription.currency,
      baseCurrency,
    );

    final String cycleLabel = _billingCycleLabel(subscription.billingCycle, l10n);

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: TextScaler.noScaling,
      ),
      child: Container(
        width: 360,
        height: 360,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF3F37C9), // Deep indigo
              Color(0xFF7209B7), // Rich violet-purple
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        alignment: Alignment.center,
        child: Stack(
          children: [
            // Background abstract circle details for premium aesthetic
            Positioned(
              top: -40,
              right: -40,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ),
            ),
            Positioned(
              bottom: -60,
              left: -20,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.03),
                ),
              ),
            ),

            // Glassmorphic main content panel
            Center(
              child: Container(
                width: 312,
                height: 312,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildAvatar(),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      subscription.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      getCategoryLabel(subscription.category, l10n),
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      '${subscription.price.toStringAsFixed(2)} ${subscription.currency} / $cycleLabel',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    if (showConversion) ...[
                      const SizedBox(height: 2),
                      Text(
                        '≈ ${convertedAmount.toStringAsFixed(2)} $baseCurrency',
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.7),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.sm),
                    Container(
                      height: 1,
                      width: 80,
                      color: Colors.white.withValues(alpha: 0.15),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      '${l10n.nextPaymentLabel}: ${subscription.nextPaymentDate.toMonthDayYearCommaLabel(l10n.localeName)}',
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    // Footer brand info
                    Text(
                      'PayTempo — Tracker ⚡',
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 10,
                        color: Colors.white.withValues(alpha: 0.5),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
