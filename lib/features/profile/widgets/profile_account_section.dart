import 'package:flutter/material.dart';
import 'package:pay_tempo/features/profile/widgets/profile_header_card_widget.dart';

/// Top-level orchestrator that composes the profile header card.
class ProfileAccountSection extends StatelessWidget {
  const ProfileAccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ProfileHeaderCardWidget(),
      ],
    );
  }
}
