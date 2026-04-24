import 'package:flutter/material.dart';

class SubscriptionTemplate {
  const SubscriptionTemplate({
    required this.id,
    required this.title,
    required this.category,
    required this.icon,
    required this.brandColor,
  });

  final String id;
  final String title;
  final String category;
  final IconData icon;
  final Color brandColor;
}

const List<SubscriptionTemplate> subscriptionTemplates = <SubscriptionTemplate>[
  SubscriptionTemplate(
    id: 'netflix',
    title: 'Netflix',
    category: 'Streaming',
    icon: Icons.movie_creation_outlined,
    brandColor: Color(0xFFE50914),
  ),
  SubscriptionTemplate(
    id: 'spotify',
    title: 'Spotify',
    category: 'Music',
    icon: Icons.graphic_eq_rounded,
    brandColor: Color(0xFF1DB954),
  ),
  SubscriptionTemplate(
    id: 'youtube_premium',
    title: 'YouTube Premium',
    category: 'Video',
    icon: Icons.play_circle_fill_rounded,
    brandColor: Color(0xFFFF0000),
  ),
  SubscriptionTemplate(
    id: 'apple_music',
    title: 'Apple Music',
    category: 'Music',
    icon: Icons.music_note_rounded,
    brandColor: Color(0xFFFA243C),
  ),
  SubscriptionTemplate(
    id: 'icloud_plus',
    title: 'iCloud+',
    category: 'Cloud',
    icon: Icons.cloud_outlined,
    brandColor: Color(0xFF0A84FF),
  ),
  SubscriptionTemplate(
    id: 'chatgpt_plus',
    title: 'ChatGPT Plus',
    category: 'AI',
    icon: Icons.smart_toy_outlined,
    brandColor: Color(0xFF10A37F),
  ),
];
