import 'package:flutter/material.dart';
import 'package:pay_tempo/data/local/models/user_settings.dart';
import 'package:pay_tempo/features/onboarding/data/user_settings_service.dart';

class AvatarWidget extends StatelessWidget {
  AvatarWidget({super.key});

  final Future<UserSettings?> _settingsFuture = UserSettingsService()
      .getSettings();

  Widget _userIdTile(String? userId) {
    if (userId == null || userId.isEmpty) {
      return const Text(
        'Local User',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      );
    }
    return Text('User ID: $userId', style: const TextStyle(fontSize: 16));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserSettings?>(
      future: _settingsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasData) {
          final userSettings = snapshot.data;
          return Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blueGrey,
                child: Text(
                  userSettings?.userId ?? '?',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _userIdTile(userSettings?.userId),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
