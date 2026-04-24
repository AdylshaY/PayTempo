import 'package:flutter/material.dart';

class SubscriptionTemplate {
  const SubscriptionTemplate({
    required this.id,
    required this.title,
    required this.category,
    required this.icon,
    required this.brandColor,
    required this.suggestedPrice,
    required this.defaultCurrency,
    required this.defaultBillingCycle,
  });

  final String id;
  final String title;
  final String category;
  final IconData icon;
  final Color brandColor;
  final double suggestedPrice;
  final String defaultCurrency;
  final String defaultBillingCycle;
}

const List<SubscriptionTemplate> subscriptionTemplates = <SubscriptionTemplate>[
  SubscriptionTemplate(
    id: 'netflix',
    title: 'Netflix',
    category: 'Streaming',
    icon: Icons.movie_creation_outlined,
    brandColor: Color(0xFFE50914),
    suggestedPrice: 9.99,
    defaultCurrency: 'USD',
    defaultBillingCycle: 'monthly',
  ),
  SubscriptionTemplate(
    id: 'spotify',
    title: 'Spotify',
    category: 'Music',
    icon: Icons.graphic_eq_rounded,
    brandColor: Color(0xFF1DB954),
    suggestedPrice: 6.99,
    defaultCurrency: 'USD',
    defaultBillingCycle: 'monthly',
  ),
  SubscriptionTemplate(
    id: 'youtube_premium',
    title: 'YouTube Premium',
    category: 'Video',
    icon: Icons.play_circle_fill_rounded,
    brandColor: Color(0xFFFF0000),
    suggestedPrice: 8.49,
    defaultCurrency: 'USD',
    defaultBillingCycle: 'monthly',
  ),
  SubscriptionTemplate(
    id: 'apple_music',
    title: 'Apple Music',
    category: 'Music',
    icon: Icons.music_note_rounded,
    brandColor: Color(0xFFFA243C),
    suggestedPrice: 10.99,
    defaultCurrency: 'USD',
    defaultBillingCycle: 'monthly',
  ),
  SubscriptionTemplate(
    id: 'icloud_plus',
    title: 'iCloud+',
    category: 'Cloud',
    icon: Icons.cloud_outlined,
    brandColor: Color(0xFF0A84FF),
    suggestedPrice: 2.99,
    defaultCurrency: 'USD',
    defaultBillingCycle: 'monthly',
  ),
  SubscriptionTemplate(
    id: 'chatgpt_plus',
    title: 'ChatGPT Plus',
    category: 'AI',
    icon: Icons.smart_toy_outlined,
    brandColor: Color(0xFF10A37F),
    suggestedPrice: 20,
    defaultCurrency: 'USD',
    defaultBillingCycle: 'monthly',
  ),
];
