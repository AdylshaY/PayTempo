import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/data/local/models/user_settings.dart';
import 'package:pay_tempo/features/profile/widgets/guest_status_widget.dart';
import 'package:pay_tempo/features/profile/widgets/pro_active_widget.dart';
import 'package:pay_tempo/features/profile/widgets/pro_expired_widget.dart';
import 'package:pay_tempo/features/profile/widgets/profile_header_card_widget.dart';

/// Determines which profile UI variant to show.
enum AccountStatus { guest, proActive, proExpired }

/// Resolves the account status from [UserSettings].
///
/// Auth only happens as part of Pro purchase (RevenueCat), so there is no
/// separate "free member" state. A user is either a guest (local-only),
/// an active Pro subscriber, or an expired Pro subscriber.
AccountStatus resolveAccountStatus(UserSettings? settings) {
  if (settings == null || !settings.isPro) {
    // No Pro purchase ever made, or isPro explicitly false.
    final expiryDate = settings?.proExpiryDate;
    if (expiryDate != null && settings?.userId != null) {
      // Had Pro before but it lapsed.
      return AccountStatus.proExpired;
    }
    return AccountStatus.guest;
  }
  final expiryDate = settings.proExpiryDate;
  if (expiryDate != null && expiryDate.isBefore(DateTime.now())) {
    return AccountStatus.proExpired;
  }
  return AccountStatus.proActive;
}

/// Top-level orchestrator that composes the profile header card + the
/// appropriate status card based on the user's account state.
class ProfileAccountSection extends StatelessWidget {
  const ProfileAccountSection({
    required this.settings,
    this.onManageSubscription,
    this.onRenewPro,
    this.onShowPaywall,
    this.onProfileTap,
    super.key,
  });

  final UserSettings? settings;
  final VoidCallback? onManageSubscription;
  final VoidCallback? onRenewPro;
  final VoidCallback? onShowPaywall;
  final VoidCallback? onProfileTap;

  @override
  Widget build(BuildContext context) {
    final AccountStatus status = resolveAccountStatus(settings);

    return Column(
      children: [
        ProfileHeaderCardWidget(
          settings: settings,
          status: status,
          onProfileTap: onProfileTap,
        ),
        const SizedBox(height: AppSpacing.sm),
        _buildStatusCard(status),
      ],
    );
  }

  Widget _buildStatusCard(AccountStatus status) {
    switch (status) {
      case AccountStatus.guest:
        return GuestStatusWidget(onShowPaywall: onShowPaywall);
      case AccountStatus.proActive:
        return ProActiveWidget(
          settings: settings,
          onManageSubscription: onManageSubscription,
        );
      case AccountStatus.proExpired:
        return ProExpiredWidget(settings: settings, onRenewPro: onRenewPro);
    }
  }
}
