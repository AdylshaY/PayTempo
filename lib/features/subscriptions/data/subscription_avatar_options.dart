import 'package:flutter/material.dart';

class SubscriptionAvatarIconOption {
  const SubscriptionAvatarIconOption({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

const List<Color> subscriptionAvatarPalette = <Color>[
  Color(0xFF4F46E5),
  Color(0xFF818CF8),
  Color(0xFF0EA5E9),
  Color(0xFF14B8A6),
  Color(0xFF10B981),
  Color(0xFF22C55E),
  Color(0xFFF59E0B),
  Color(0xFFF97316),
  Color(0xFFEF4444),
  Color(0xFFEC4899),
  Color(0xFF8B5CF6),
  Color(0xFF64748B),
  Color(0xFFE50914),
  Color(0xFF1DB954),
  Color(0xFFFF0000),
  Color(0xFFFA243C),
  Color(0xFF0A84FF),
  Color(0xFF10A37F),
];

const List<SubscriptionAvatarIconOption>
subscriptionAvatarIcons = <SubscriptionAvatarIconOption>[
  SubscriptionAvatarIconOption(
    label: 'Play',
    icon: Icons.play_circle_fill_rounded,
  ),
  SubscriptionAvatarIconOption(label: 'Music', icon: Icons.music_note_rounded),
  SubscriptionAvatarIconOption(label: 'Cloud', icon: Icons.cloud_outlined),
  SubscriptionAvatarIconOption(label: 'AI', icon: Icons.smart_toy_outlined),
  SubscriptionAvatarIconOption(
    label: 'Cart',
    icon: Icons.shopping_bag_outlined,
  ),
  SubscriptionAvatarIconOption(
    label: 'Game',
    icon: Icons.sports_esports_outlined,
  ),
  SubscriptionAvatarIconOption(label: 'Work', icon: Icons.workspaces_outline),
  SubscriptionAvatarIconOption(label: 'News', icon: Icons.newspaper_outlined),
];
