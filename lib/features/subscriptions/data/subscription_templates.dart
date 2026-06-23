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
    icon: Icons.music_note_rounded,
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
    id: 'disney_plus',
    title: 'Disney+',
    category: 'Streaming',
    icon: Icons.movie_creation_outlined,
    brandColor: Color(0xFF0F1E36),
  ),
  SubscriptionTemplate(
    id: 'prime_video',
    title: 'Prime Video',
    category: 'Streaming',
    icon: Icons.movie_creation_outlined,
    brandColor: Color(0xFF00A8E1),
  ),
  SubscriptionTemplate(
    id: 'hbo_max',
    title: 'Max',
    category: 'Streaming',
    icon: Icons.movie_creation_outlined,
    brandColor: Color(0xFF5A1EAF),
  ),
  SubscriptionTemplate(
    id: 'apple_tv_plus',
    title: 'Apple TV+',
    category: 'Streaming',
    icon: Icons.movie_creation_outlined,
    brandColor: Color(0xFF111111),
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
    id: 'google_one',
    title: 'Google One',
    category: 'Cloud',
    icon: Icons.cloud_outlined,
    brandColor: Color(0xFF4285F4),
  ),
  SubscriptionTemplate(
    id: 'dropbox',
    title: 'Dropbox',
    category: 'Cloud',
    icon: Icons.cloud_outlined,
    brandColor: Color(0xFF0061FE),
  ),
  SubscriptionTemplate(
    id: 'chatgpt_plus',
    title: 'ChatGPT Plus',
    category: 'AI',
    icon: Icons.smart_toy_outlined,
    brandColor: Color(0xFF10A37F),
  ),
  SubscriptionTemplate(
    id: 'midjourney',
    title: 'Midjourney',
    category: 'AI',
    icon: Icons.smart_toy_outlined,
    brandColor: Color(0xFF6366F1),
  ),
  SubscriptionTemplate(
    id: 'playstation_plus',
    title: 'PlayStation Plus',
    category: 'Gaming',
    icon: Icons.sports_esports_outlined,
    brandColor: Color(0xFF003087),
  ),
  SubscriptionTemplate(
    id: 'xbox_game_pass',
    title: 'Xbox Game Pass',
    category: 'Gaming',
    icon: Icons.sports_esports_outlined,
    brandColor: Color(0xFF107C10),
  ),
  SubscriptionTemplate(
    id: 'nintendo_switch_online',
    title: 'Nintendo Switch Online',
    category: 'Gaming',
    icon: Icons.sports_esports_outlined,
    brandColor: Color(0xFFE60012),
  ),
  SubscriptionTemplate(
    id: 'microsoft_365',
    title: 'Microsoft 365',
    category: 'Productivity',
    icon: Icons.workspaces_outline,
    brandColor: Color(0xFFD83B01),
  ),
  SubscriptionTemplate(
    id: 'adobe_creative_cloud',
    title: 'Creative Cloud',
    category: 'Productivity',
    icon: Icons.workspaces_outline,
    brandColor: Color(0xFFFA0F00),
  ),
  SubscriptionTemplate(
    id: 'canva_pro',
    title: 'Canva Pro',
    category: 'Productivity',
    icon: Icons.workspaces_outline,
    brandColor: Color(0xFF00C4CC),
  ),
  SubscriptionTemplate(
    id: 'duolingo_plus',
    title: 'Duolingo Super',
    category: 'Productivity',
    icon: Icons.workspaces_outline,
    brandColor: Color(0xFF58CC02),
  ),
  SubscriptionTemplate(
    id: 'slack_pro',
    title: 'Slack Pro',
    category: 'Productivity',
    icon: Icons.workspaces_outline,
    brandColor: Color(0xFF4A154B),
  ),
  SubscriptionTemplate(
    id: 'audible',
    title: 'Audible',
    category: 'News',
    icon: Icons.newspaper_outlined,
    brandColor: Color(0xFFF58220),
  ),
  SubscriptionTemplate(
    id: 'ny_times',
    title: 'NY Times',
    category: 'News',
    icon: Icons.newspaper_outlined,
    brandColor: Color(0xFF121212),
  ),
];
