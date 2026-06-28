import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/data/local/models/user_settings.dart';
import 'package:pay_tempo/features/profile/widgets/guest_status_widget.dart';
import 'package:pay_tempo/features/profile/widgets/profile_header_card_widget.dart';

/// Determines which profile UI variant to show.
enum AccountStatus { guest, proActive, proExpired }

/// Top-level orchestrator that composes the profile header card + guest status card.
class ProfileAccountSection extends StatelessWidget {
  const ProfileAccountSection({
    required this.settings,
    this.onProfileTap,
    super.key,
  });

  final UserSettings? settings;
  final VoidCallback? onProfileTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileHeaderCardWidget(
          settings: settings,
          status: AccountStatus.guest,
          onProfileTap: onProfileTap,
        ),
        const SizedBox(height: AppSpacing.sm),
        const GuestStatusWidget(),
      ],
    );
  }
}
