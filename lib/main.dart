import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:subscription_tracker/app/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      builder: (BuildContext context, Widget? child) {
        final Brightness brightness = Theme.of(context).brightness;
        final SystemUiOverlayStyle overlayStyle = brightness == Brightness.dark
            ? AppTheme.darkSystemUi
            : AppTheme.lightSystemUi;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: overlayStyle,
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const _ThemePreviewScreen(),
    );
  }
}

class _ThemePreviewScreen extends StatelessWidget {
  const _ThemePreviewScreen();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('PayTempo'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.sm),
            Text('Theme Ready', style: textTheme.headlineMedium),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'DESIGN_SYSTEM.md tokenlariyla uyumlu temel tema aktif.',
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bu Ayki Toplam Harcama', style: textTheme.titleMedium),
                    const SizedBox(height: AppSpacing.xs),
                    Text('€0.00', style: textTheme.displayLarge),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
