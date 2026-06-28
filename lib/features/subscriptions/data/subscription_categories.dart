import 'package:flutter/material.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class SubscriptionCategoryOption {
  const SubscriptionCategoryOption({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  final String value;
  final String label;
  final IconData icon;
  final Color color;
}

String getCategoryLabel(String valueOrLabel, AppLocalizations l10n) {
  switch (valueOrLabel.toLowerCase()) {
    case 'streaming':
      return l10n.categoryStreaming;
    case 'music':
      return l10n.categoryMusic;
    case 'video':
      return l10n.categoryVideo;
    case 'cloud':
      return l10n.categoryCloud;
    case 'ai':
      return l10n.categoryAi;
    case 'productivity':
      return l10n.categoryProductivity;
    case 'gaming':
      return l10n.categoryGaming;
    case 'news':
      return l10n.categoryNews;
    case 'housing':
    case 'housing/rent':
      return l10n.categoryHousing;
    case 'utilities':
    case 'bills/utilities':
      return l10n.categoryUtilities;
    case 'finance':
    case 'finance/installment':
      return l10n.categoryFinance;
    default:
      return valueOrLabel;
  }
}

Color getCategoryColor(String valueOrLabel) {
  final normalized = valueOrLabel.toLowerCase();
  for (final cat in subscriptionCategories) {
    if (cat.value == normalized) {
      return cat.color;
    }
  }
  return const Color(0xFF94A3B8); // Default fallback
}

const List<SubscriptionCategoryOption> subscriptionCategories = <SubscriptionCategoryOption>[
  SubscriptionCategoryOption(
    value: 'streaming',
    label: 'Streaming',
    icon: Icons.movie_creation_outlined,
    color: Color(0xFFEF4444),
  ),
  SubscriptionCategoryOption(
    value: 'music',
    label: 'Music',
    icon: Icons.music_note_rounded,
    color: Color(0xFF10B981),
  ),
  SubscriptionCategoryOption(
    value: 'video',
    label: 'Video',
    icon: Icons.play_circle_fill_rounded,
    color: Color(0xFFF59E0B),
  ),
  SubscriptionCategoryOption(
    value: 'cloud',
    label: 'Cloud',
    icon: Icons.cloud_outlined,
    color: Color(0xFF3B82F6),
  ),
  SubscriptionCategoryOption(
    value: 'ai',
    label: 'AI',
    icon: Icons.smart_toy_outlined,
    color: Color(0xFF8B5CF6),
  ),
  SubscriptionCategoryOption(
    value: 'productivity',
    label: 'Productivity',
    icon: Icons.workspaces_outline,
    color: Color(0xFFEC4899),
  ),
  SubscriptionCategoryOption(
    value: 'gaming',
    label: 'Gaming',
    icon: Icons.sports_esports_outlined,
    color: Color(0xFF06B6D4),
  ),
  SubscriptionCategoryOption(
    value: 'news',
    label: 'News',
    icon: Icons.newspaper_outlined,
    color: Color(0xFF64748B),
  ),
  SubscriptionCategoryOption(
    value: 'housing',
    label: 'Housing/Rent',
    icon: Icons.home_outlined,
    color: Color(0xFFF59E0B),
  ),
  SubscriptionCategoryOption(
    value: 'utilities',
    label: 'Bills/Utilities',
    icon: Icons.electric_bolt_outlined,
    color: Color(0xFF06B6D4),
  ),
  SubscriptionCategoryOption(
    value: 'finance',
    label: 'Finance/Installment',
    icon: Icons.credit_card_outlined,
    color: Color(0xFF10B981),
  ),
];
