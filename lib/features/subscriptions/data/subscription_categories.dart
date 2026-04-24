import 'package:flutter/material.dart';

class SubscriptionCategoryOption {
  const SubscriptionCategoryOption({
    required this.value,
    required this.label,
    required this.icon,
  });

  final String value;
  final String label;
  final IconData icon;
}

const List<SubscriptionCategoryOption> subscriptionCategories = <SubscriptionCategoryOption>[
  SubscriptionCategoryOption(
    value: 'streaming',
    label: 'Streaming',
    icon: Icons.movie_creation_outlined,
  ),
  SubscriptionCategoryOption(
    value: 'music',
    label: 'Music',
    icon: Icons.music_note_rounded,
  ),
  SubscriptionCategoryOption(
    value: 'video',
    label: 'Video',
    icon: Icons.play_circle_fill_rounded,
  ),
  SubscriptionCategoryOption(
    value: 'cloud',
    label: 'Cloud',
    icon: Icons.cloud_outlined,
  ),
  SubscriptionCategoryOption(
    value: 'ai',
    label: 'AI',
    icon: Icons.smart_toy_outlined,
  ),
  SubscriptionCategoryOption(
    value: 'productivity',
    label: 'Productivity',
    icon: Icons.workspaces_outline,
  ),
  SubscriptionCategoryOption(
    value: 'gaming',
    label: 'Gaming',
    icon: Icons.sports_esports_outlined,
  ),
  SubscriptionCategoryOption(
    value: 'news',
    label: 'News',
    icon: Icons.newspaper_outlined,
  ),
];
