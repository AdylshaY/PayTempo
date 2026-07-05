import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/features/profile/widgets/profile_account_section.dart';
import 'package:pay_tempo/features/profile/widgets/settings_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(AppSpacing.sm, AppSpacing.sm, AppSpacing.sm, 130),
          child: Column(
            children: [
              ProfileAccountSection(),
              SizedBox(height: AppSpacing.sm),
              SettingsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
