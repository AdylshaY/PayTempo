import 'package:flutter/material.dart';
import 'package:pay_tempo/features/profile/widgets/avatar_widget.dart';
import 'package:pay_tempo/features/profile/widgets/settings_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            spacing: 16,
            children: [AvatarWidget(), SettingsWidget()],
          ),
        ),
      ),
    );
  }
}
