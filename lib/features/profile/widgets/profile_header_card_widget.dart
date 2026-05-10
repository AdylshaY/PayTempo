import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/data/local/models/user_settings.dart';
import 'package:pay_tempo/features/profile/widgets/profile_account_section.dart';

/// Reusable status badge chip used in profile header cards.
class StatusBadge extends StatelessWidget {
  const StatusBadge({
    required this.icon,
    required this.iconSize,
    required this.label,
    required this.color,
    super.key,
  });

  final IconData icon;
  final double iconSize;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: iconSize, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

/// Profile header card showing avatar, name, email, and status badge.
///
/// Adapts its appearance based on [AccountStatus]:
/// - Guest: person icon + "Anonymous · Local Data" badge
/// - Pro Active: initials avatar (gold gradient) + "Pro Plan · Active" badge
/// - Pro Expired: initials avatar (neutral) + "Pro Expired" badge
class ProfileHeaderCardWidget extends StatelessWidget {
  const ProfileHeaderCardWidget({
    required this.settings,
    required this.status,
    this.onProfileTap,
    super.key,
  });

  final UserSettings? settings;
  final AccountStatus status;
  final VoidCallback? onProfileTap;

  String _initials(String? name) {
    if (name == null || name.trim().isEmpty) return '?';
    final parts = name.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return parts[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isGuest = status == AccountStatus.guest;
    final isProActive = status == AccountStatus.proActive;
    final isProExpired = status == AccountStatus.proExpired;

    // Avatar colors
    Color avatarBg;
    Color avatarBorder;
    if (isGuest) {
      avatarBg = colorScheme.surface.withValues(alpha: 0.6);
      avatarBorder = Colors.transparent;
    } else if (isProActive) {
      avatarBg = AppColors.proGold;
      avatarBorder = AppColors.proGold;
    } else if (isProExpired) {
      avatarBg = colorScheme.surface;
      avatarBorder = Colors.transparent;
    } else {
      avatarBg = colorScheme.surface;
      avatarBorder = Colors.transparent;
    }

    // Badge
    Widget badge;
    if (isGuest) {
      badge = const StatusBadge(
        icon: Icons.circle,
        iconSize: 8,
        label: 'Anonymous · Local Data',
        color: AppColors.warning,
      );
    } else if (isProActive) {
      badge = const StatusBadge(
        icon: Icons.auto_awesome,
        iconSize: 14,
        label: 'Pro Plan · Active',
        color: AppColors.proGold,
      );
    } else {
      badge = const StatusBadge(
        icon: Icons.warning_rounded,
        iconSize: 14,
        label: 'Pro Expired',
        color: AppColors.error,
      );
    }

    // Card gradient for pro active
    BoxDecoration? decoration;
    if (isProActive) {
      decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadii.card),
        gradient: LinearGradient(
          colors: [
            AppColors.proGold.withValues(alpha: 0.15),
            AppColors.proGold.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppColors.proGold.withValues(alpha: 0.3)),
      );
    }

    final email = settings?.email;
    final displayName = settings?.displayName;

    return Card(
      child: Container(
        decoration: decoration,
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: avatarBg,
                borderRadius: BorderRadius.circular(AppRadii.card),
                border: avatarBorder != Colors.transparent
                    ? Border.all(color: avatarBorder, width: 2)
                    : null,
              ),
              alignment: Alignment.center,
              child: isGuest
                  ? Icon(
                      Icons.person_outline,
                      size: 32,
                      color: colorScheme.onSurface.withValues(alpha: 0.5),
                    )
                  : Text(
                      _initials(displayName),
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: isProActive
                            ? Colors.black87
                            : colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isGuest ? 'Guest User' : (displayName ?? 'User'),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (!isGuest && email != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      email,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.textTheme.bodySmall?.color?.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    ),
                  ],
                  if (isGuest) ...[
                    const SizedBox(height: 2),
                    Text(
                      'No account created',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.textTheme.bodySmall?.color?.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  badge,
                ],
              ),
            ),
            if (!isGuest)
              Icon(
                Icons.chevron_right,
                color: colorScheme.onSurface.withValues(alpha: 0.4),
              ),
          ],
        ),
      ),
    );
  }
}
